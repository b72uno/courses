#!/usr/bin/env python

import os
import random
import requests

# ASSUMES THE SUBFOLDERS ARE IN THE
# CURRENT WORKING DIRECTORY OF THE SCRIPT FILE
DIR_PATH = os.getcwd()
POOL_DIR = DIR_PATH + "/Library/"
CHALLENGE_DIR = DIR_PATH + "/Challenges/"
# SAMPLE_SIZE = int(input("How many samples? "))
SAMPLE_SIZE = 10
FAIL_DIR = DIR_PATH + '/Failures/'
COMPLETE_DIR = DIR_PATH + '/Complete/'
REWARD_DIR = DIR_PATH + '/Rewards/'

file_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(POOL_DIR)
    for name in files
]

challenge_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(CHALLENGE_DIR)
    for name in files
]

fail_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(FAIL_DIR)
    for name in files
]

reward_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(REWARD_DIR)
    for name in files
]


def get_filename(file):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    return filename


def move_to_challenges(file):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    target = CHALLENGE_DIR + filename
    os.rename(file, target)


def move_to_complete(file):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    target = COMPLETE_DIR + filename
    os.rename(file, target)


def move_to_fail(file):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    target = FAIL_DIR + filename
    os.rename(file, target)


def move_to_rewards(file):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    target = REWARD_DIR + filename
    os.rename(file, target)


def move_to_library(file):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    target = POOL_DIR + filename
    os.rename(file, target)


if len(challenge_list) > 0:
    print("Challenge list is not empty, moving all files back to pool...")
    for file in challenge_list:
        move_to_library(file)
if len(reward_list) > 0:
    print("Reward list is not empty, moving all files back to pool...")
    for file in reward_list:
        move_to_library(file)

print("Drawing {} new files for sample pool...".format(SAMPLE_SIZE))
sample_list = random.sample(file_list, SAMPLE_SIZE)

for i, file in enumerate(sample_list):
    filename, extension = os.path.splitext(file)
    filename = os.path.basename(file)
    print("#{} is {}".format(i, filename))

ans = input("Pick a number: ")

target = sample_list[int(ans)]
print("You have chosen {} as your reward.".format(get_filename(target)))
move_to_rewards(target)

print("To be rewarded, you have to pass a challenge.")

if len(fail_list) > 0:
    print("Fail list is not empty, picking from fail pool...")
    cond = random.choice(fail_list)
else:
    print("Picking conditional test from the library...")
    cond = random.choice(file_list)

print("Your challenge is: {}".format(get_filename(cond)))

move_to_challenges(cond)

challenge_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(CHALLENGE_DIR)
    for name in files
]

reward_list = [
    os.path.join(path, name) for path, subdirs, files in os.walk(REWARD_DIR)
    for name in files
]

print("Procceed with your challenge.")
input("Press Enter to continue...")


def success(file):
    f = get_filename(file)
    stat = input("Did you succeed with {}? (Y/N)".format(f))
    if stat.lower().startswith("y"):
        print("********** SUCCESS!!! ***********")
        print("Moving {} to the success folder....".format(f))
        r = requests.get('http://api.quotable.io/random')
        print(r.json()["content"])
        move_to_complete(file)
        return True
    else:
        print("********** WEAK!!! ***********")
        print("Adding {} to the list of your failures...".format(f))
        r = requests.get('https://api.adviceslip.com/advice')
        print(r.json()["slip"]["advice"])
        move_to_fail(file)
    return False


for file in challenge_list:
    if success(file):
        for f in reward_list:
            success(f)
