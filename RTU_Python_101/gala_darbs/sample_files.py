#!/usr/bin/env python

import os
import random
import requests

# ASSUMES THE SUBFOLDERS ARE IN THE
# CURRENT WORKING DIRECTORY OF THE SCRIPT FILE
DIR_PATH = os.getcwd()
POOL_DIR = DIR_PATH + "/pool/"
SAMPLE_DIR = DIR_PATH + "/samples/"
SAMPLE_SIZE = int(input("How many samples? "))
FAIL_DIR = DIR_PATH + '/failure/'
COMPLETE_DIR = DIR_PATH + '/success/'

file_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(POOL_DIR)
    for name in files
]
sample_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(SAMPLE_DIR)
    for name in files
]

if len(sample_list) > 0:
    print("Sample list is not empty, moving all samples back to pool...")
    for file in sample_list:
        filename = os.path.basename(file)
        target = POOL_DIR + filename
        os.rename(file, target)

print("Drawing {} new files for sample pool...".format(SAMPLE_SIZE))
sample_list = random.sample(file_list, SAMPLE_SIZE)

for i, file in enumerate(sample_list):
    # filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    print("File #{} is {}".format(i, filename))
    target = SAMPLE_DIR + filename
    os.rename(file, target)

print("Collect your files and proceed.")

sample_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(SAMPLE_DIR)
    for name in files
]


def scrape_response(tag):
    # url =
    pass


for file in sample_list:
    target = None
    filename = os.path.basename(file)
    picked = input("Did you pick file {}? (Y/N)".format(filename))
    if picked.lower().startswith("y"):
        success = input("Were you successful? (Y/N)")
        if success.lower().startswith("y"):
            print("********** SUCCESS!!! ***********")
            print("Moving the file to the success folder....")
            r = requests.get('http://api.quotable.io/random')
            print(r.json()["content"])
            giphy_url = giphy_url.format("win")
            target = COMPLETE_DIR + filename
        else:
            print("********** WEAK!!! ***********")
            print("Adding the file to the list of your failures...")
            r = requests.get('https://api.adviceslip.com/advice')
            print(r.json()["slip"]["advice"])
            giphy_url = giphy_url.format("fail")
            target = FAIL_DIR + filename
    else:
        print("**********  SCARED???  ***********")
        print("Moving {} back to pool..".format(filename))
        target = POOL_DIR + filename
        r = requests.get('http://api.quotable.io/random')
        print(r.json()["content"])
        giphy_url = giphy_url.format("pussy")
    if target:
        os.rename(file, target)
        response = requests.request(
            "GET", url).json()["data"]["images"]["original"]["url"]
        print(response)
