#!/usr/bin/env python

import hashlib
import hmac
import jinja2
import json
import logging
import os
import random
import re
import time
import webapp2

from string import letters
from google.appengine.api import memcache
from google.appengine.ext import db

template_dir = os.path.join(os.path.dirname(__file__), 'templates')
jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(template_dir),
                               autoescape=True)


class Handler(webapp2.RequestHandler):
    def write(self, *a, **kw):
        self.response.out.write(*a, **kw)

    def render_str(self, template, **params):
        t = jinja_env.get_template(template)
        return t.render(params)

    def render(self, template, **kw):
        self.write(self.render_str(template, **kw))


SUBJECT_RE = re.compile(r"^[a-zA-Z0-9_\s\!\.\?]{3,40}$")


def valid_subject(subject):
    return subject and SUBJECT_RE.match(subject)


class BlogPost(db.Model):
    subject = db.StringProperty(required=True)
    content = db.TextProperty(required=True)
    created = db.DateTimeProperty(auto_now_add=True)
    modified = db.DateTimeProperty(auto_now=True)


class BlogRender(Handler):
    def get(self, id=None):
        if id:
            posts = [memcache.get(id)]
            if not posts[0]:
                # query the database and cache the query
                posts = [BlogPost.get_by_id(int(id))]
                memcache.set(id, posts[0])
                # note the time when query occured
                t = time.time()
                memcache.set("lqt" + id, t)
            # retrieve the time when db was queried
            lqt = memcache.get("lqt" + id)
        else:
            key = "blogposts"
            posts = memcache.get(key)
            if not posts:
                logging.error("QUERYING DATABASEEEE NOOOOOO!!")
                posts = db.GqlQuery("SELECT * FROM BlogPost \
                                    ORDER BY created DESC")
                posts = list(posts)
                memcache.set(key, posts)
                lq = time.time()
                memcache.set("lqtBlog", lq)
            lqt = memcache.get("lqtBlog")

        self.render('blog.html', posts=posts, generated=
                    time.time() - lqt)


class SinglePostJSON(Handler):
    def post2JSON(self, post):
        firstCreated = str(post.created)
        lastModified = str(post.modified)
        jsonString = {'content': post.content,
                      'created': firstCreated, 'last_modified':
                      lastModified, 'subject': post.subject}
        return json.dumps(jsonString)

    def get(self, id):
        post = BlogPost.get_by_id(int(id))
        self.response.headers.add_header("Content-Type", "application/json; \
                                         charset=UTF-8")
        self.write(self.post2JSON(post))


class BlogJSON(SinglePostJSON):
    def get(self):
        posts = db.GqlQuery("SELECT * FROM BlogPost ORDER BY created DESC")
        self.response.headers.add_header("Content-Type", "application/json; \
                                         charset=UTF-8")
        JSONdposts = [json.loads(self.post2JSON(post)) for post in posts]
        self.write(json.dumps(JSONdposts))


class FlushCache(Handler):
    def get(self):
        memcache.flush_all()
        self.redirect("/blog")


class NewPost(Handler):
    def get(self):
        self.render('post.html')

    def post(self):
        have_error = False
        subject = self.request.get('subject')
        content = self.request.get('content')

        params = dict(subject=subject, content=content)

        if not len(content) > 0:
            params['error_content'] = "Title AND Content please!"
            have_error = True

        # if not valid_subject(subject):
        #     params['error_subject'] = "That's not a valid subject! \
        #                                Use only letters and numbers."
        #     have_error = True

        if have_error:
            self.render('post.html', **params)
        else:
            ## save to db, record ID and redirect to a permalink
            bp = BlogPost(subject=subject, content=content)
            bp.put()
            memcache.delete("blogposts")
            self.redirect("/blog/%s" % str(bp.key().id()))


def render_str(template, **params):
    t = jinja_env.get_template(template)
    return t.render(params)


class BaseHandler(webapp2.RequestHandler):
    def render(self, template, **kw):
        self.response.out.write(render_str(template, **kw))

    def write(self, *a, **kw):
        self.response.out.write(*a, **kw)


class Rot13(BaseHandler):
    def get(self):
        self.render('rot13_form.html')

    def post(self):
        rot13 = ''
        text = self.request.get('text')
        if text:
            rot13 = text.encode('rot13')
        self.render('rot13_form.html', text=rot13)


# REGEX
# =====
USER_RE = re.compile(r"^[a-zA-Z0-0_-]{3,20}$")
PASSWORD_RE = re.compile(r"^.{3,20}$")
EMAIL_RE = re.compile(r"^[\S]+@[\S]+\.[\S]+$")


def valid_username(username):
    return username and USER_RE.match(username)


def valid_password(password):
    return password and PASSWORD_RE.match(password)


def valid_email(email):
    return email and EMAIL_RE.match(email)


class User(db.Model):
    username = db.StringProperty(required=True)
    password = db.StringProperty(required=True)
    salt = db.StringProperty(required=True)
    email = db.StringProperty()


class SignUp(BaseHandler):
    def get(self):
        self.render('signup.html')

    def post(self):
        have_error = False
        username = self.request.get('username')
        password = self.request.get('password')
        verify = self.request.get('verify')
        email = self.request.get('email')

        params = dict(username=username, email=email)

        if not valid_username(username):
            params['error_username'] = "That's not a valid username"
            have_error = True

        if not valid_password(password):
            params['error_password'] = "That's not a valid password!"
            have_error = True

        if password != verify:
            params['error_verify'] = "Your passwords didn't match!"
            have_error = True

        if email:
            if not valid_email(email):
                params['error_email'] = "That's not a valid e-mail address!"
                have_error = True

        if have_error:
            self.render('signup.html', **params)
        else:
            q = User.gql("WHERE username=:u LIMIT 1", u=username)
            u = q.get()
            if not u:
                salt = "".join(random.sample(letters, 5))
                pwhash = hmac.new(salt, password, hashlib.sha256).hexdigest()
                user = User(username=username, password=pwhash, salt=salt,
                            email=email)
                user.put()
                self.response.headers.add_header("Set-Cookie", "name=%s, \
                                                 Path=/ " % str(username))
                self.redirect('/blog/welcome')
            else:
                have_error = True
                params['error_username'] = 'Such username already exists!'
                self.render('signup.html', **params)


class LogIn(BaseHandler):
    def get(self):
        self.render('login.html')

    def post(self):
        have_error = False
        username = self.request.get('username')
        password = self.request.get('password')

        errors = dict()

        q = User.gql("WHERE username=:u LIMIT 1", u=username)
        user = q.get()

        if not user:
            errors['error_login'] = "Username or password was wrong"
            have_error = True
        else:
            if hmac.new(str(user.salt), password, hashlib.sha256).hexdigest()\
                    == user.password:
                self.response.headers.add_header("Set-Cookie", "name=%s, \
                                                 Path=/ " % str(username))
                self.response.headers.add_header("Set-Cookie",
                                                 "password=%s|%s, \ Path=/ "
                                                 % (str(user.salt),
                                                 str(user.password)))
                self.redirect('/welcome')

            else:
                errors['error_login'] = "Username or password was wrong"
                have_error = True

        if have_error:
            self.render('login.html', **errors)


class LogOut(BaseHandler):
    def get(self):
        self.response.headers.add_header("Set-Cookie", "password=; , Path=/")
        self.response.headers.add_header("Set-Cookie", "name=;  Path=/")
        self.redirect('/signup')


class WelcomeHandler(BaseHandler):
    def get(self):
        username = self.request.cookies.get('name')
        if username and valid_username(username):
            self.render('welcome.html', username=username)
        else:
            self.redirect('/signup')


app = webapp2.WSGIApplication([
    ('/blog/newpost/?', NewPost),
    ('/blog/flush', FlushCache),
    ('/blog/?(?:(\d+)(?:\.json)?/?)?', BlogRender),
    ('/blog/?\.json/?', BlogJSON),
    ('(?:/blog)?/login/?', LogIn),
    ('(?:/blog)?/logout/?', LogOut),
    ('(?:/blog)?/(?:welcome/?)?', WelcomeHandler),
    ('(?:/blog)?/signup/?', SignUp)], debug=True)
