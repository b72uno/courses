#! usr/bin/env python

import hashlib
import hmac
import jinja2
import json
import logging
import markupsafe
import os
import random
import re
import webapp2

from string import letters

from google.appengine.ext import db
from google.appengine.api import memcache

template_dir = os.path.join(os.path.dirname(__file__), 'templates')
jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(template_dir),
                               autoescape=True)

# UTILS
SECRET = 'madness'
DEBUG = True


def make_secure_val(val):
    return "%s|%s" % (val, hmac.new(SECRET, val).hexdigest())


def check_secure_val(secure_val):
    val = secure_val.split('|')[0]
    return secure_val == make_secure_val(val)


def make_salt(length=5):
    return "".join(random.sample(letters, 5))


def make_pw_hash(val, salt=None):
    if not salt:
        salt = make_salt()
    return "%s|%s" % (salt, hmac.new(str(salt), val, hashlib.sha256)
                      .hexdigest())


def valid_pw(password, h):
    if h:
        salt = h.split("|")[0]
    return h == make_pw_hash(password, salt)


def users_key(group='default'):
    return db.Key.from_path('users', group)


class WikiPage(db.Model):
    name = db.StringProperty(required=True)
    content = db.TextProperty()
    history = db.TextProperty()
    created = db.DateTimeProperty(auto_now_add=True)
    modified = db.DateTimeProperty(auto_now=True)


class User(db.Model):
    username = db.StringProperty(required=True)
    password = db.StringProperty(required=True)
    email = db.StringProperty()

    @classmethod
    def by_id(cls, uid):
        return User.get_by_id(uid, parent=users_key())

    @classmethod
    def by_name(cls, name):
        q = db.GqlQuery("SELECT * FROM User WHERE username=:u", u=name)
        u = q.get()
        return u

    @classmethod
    def register(cls, name, pw, email=None):
        pw_hash = make_pw_hash(pw)
        return User(parent=users_key(),
                    username=name,
                    password=pw_hash,
                    email=email)

    @classmethod
    def login(cls, name, pw):
        u = cls.by_name(name)
        if u and valid_pw(pw, u.password):
            return u


# Regex
USER_RE = re.compile(r"^[a-zA-Z0-9]{3,20}$")
PASS_RE = re.compile(r"^.{3,20}$")
EMAIL_RE = re.compile(r"^[\S]+@[\S]+\.[\S]+$")


def valid_username(username):
    q = User.gql("WHERE username=:u LIMIT 1", u=username)
    u = q.get()
    return not u and username and USER_RE.match(username)


def valid_password(password):
    return password and PASS_RE.match(password)


def valid_email(email):
    return not email or EMAIL_RE.match(email)


class Handler(webapp2.RequestHandler):
    def write(self, *a, **kw):
        self.response.out.write(*a, **kw)

    def render_str(self, template, **params):
        t = jinja_env.get_template(template)
        return t.render(params)

    def render(self, template, **kw):
        self.write(self.render_str(template, **kw))

    def render_json(self, d):
        json_txt = json.dumps(d)
        self.response.headers['Content-Type'] = 'application/json; \
                              charset=UTF-8'
        self.write(json_txt)

    def set_secure_cookie(self, name, value):
        cookie_val = make_secure_val(value)
        self.response.headers.add_header('Set-Cookie',
                                         '%s=%s; Path=/'
                                         % (name, cookie_val))

    def read_secure_cookie(self, name):
        cookie_val = self.request.cookies.get(name)
        if check_secure_val(cookie_val):
            return cookie_val

    def login(self, user):
        self.set_secure_cookie('user_id', str(user.key().id()))

    def logout(self):
        self.set_secure_cookie('user_id', 'user_id=; Path=/')

    def get_user(self):
        u = None
        uid = self.read_secure_cookie('user_id')
        if uid:
            uid = uid.split('|')[0]
            u = User.get_by_id(int(uid))
        return u


class LogIn(Handler):
    def get(self):
        self.render('login.html')

    def post(self):
        username = self.request.get('username')
        password = self.request.get('password')

        u = User.login(username, password)
        if u:
            self.login(u)
            self.redirect('/wiki/welcome')
        else:
            msg = "Invalid login"
            self.render('login.html', error_login=msg)


class SignUp(Handler):
    def get(self):
        self.render('signup.html')

    def post(self):
        have_error = False

        self.username = self.request.get('username')
        self.password = self.request.get('password')
        self.verify = self.request.get('verify')
        self.email = self.request.get('email')

        params = dict(username=self.username, email=self.email)

        if not valid_username(self.username):
            params['error_username'] = "That is not a valid username."
            have_error = True

        if not valid_password(self.password):
            params['error_password'] = "Thats not a valid password"
            have_error = True
        elif self.password != self.verify:
            params['error_verify'] = "Passwords didnt match!"
            have_error = True

        if not valid_email(self.email):
            params['error_email'] = "That's not a valid email!"
            have_error = True

        if have_error:
            self.render('signup.html', **params)
        else:
            user = User(username=self.username,
                        password=make_pw_hash(self.password),
                        email=self.email)
            user.put()
            self.login(user)
            self.redirect('/wiki/welcome')


class WelcomePage(Handler):
    def get(self):
        u = self.get_user()
        self.render('wikiwelcome.html', user=u)


class LogOut(Handler):
    def get(self):
        self.logout()
        self.redirect('/wiki/welcome')


class MainPage(Handler):
    def get(self, path):
        u = self.get_user()
        if len(path) == 0:
            self.render('wikimain.html', user=u, current_page=path)
        else:
            q = db.GqlQuery("SELECT * FROM WikiPage WHERE name=:n", n=path)
            p = q.get()
            if not p:
                self.redirect('/wiki/_edit/%s' % path)
            else:
                self.render('wikimain.html', user=u, current_page=path, page=p)


class EditPage(Handler):
    def get(self, path):
        u = self.get_user()
        if not u:
            self.redirect("/wiki/login")
        if len(path) == 0:
            self.redirect('/wiki/')
        q = db.GqlQuery("SELECT * FROM WikiPage WHERE name=:n", n=path)
        p = q.get()
        if not p:
            self.render('wikiedit.html', user=u, current_page=path)
        else:
            self.render('wikiedit.html', user=u, current_page=path, page=p)

    def post(self, path):
        u = self.get_user()
        if not u:
            self.redirect("/wiki/login")
        content = self.request.get('content')
        q = db.GqlQuery("SELECT * FROM WikiPage WHERE name=:n", n=path)
        p = q.get()
        if not p:
            history = json.dumps([content])
            p = WikiPage(name=path, content=content, history=history)
            p.put()
            self.redirect('/wiki/%s' % path)
        else:
            history = json.loads(p.history)
            p.content = content
            history.append(p.content)
            p.history = json.dumps(history)
            p.put()
            self.redirect('/wiki/%s' % path)


class HistoryPage(Handler):
    def get(self, path):
        u = self.get_user()
        if not u:
            self.redirect("/wiki/login")
        if len(path) == 0:
            self.redirect('/wiki/')
        q = db.GqlQuery("SELECT * FROM WikiPage WHERE name=:n", n=path)
        p = q.get()
        if not p:
            self.redirect('/wiki/')
        else:
            h = json.loads(p.history)
            self.render('wikihist.html', user=u, history=h, current_page=path)


class Redirect2Main(Handler):
    def get(self):
        self.redirect("/wiki/")


app = webapp2.WSGIApplication([
    ('/wiki', Redirect2Main),
    ('/wiki/signup/?', SignUp),
    ('/wiki/login/?', LogIn),
    ('/wiki/logout/?', LogOut),
    ('/wiki/welcome/?', WelcomePage),
    ('/wiki/_edit/(.*)', EditPage),
    ('/wiki/_?history/(.*)', HistoryPage),
    ('/wiki/(.*)', MainPage),
], debug=DEBUG)
