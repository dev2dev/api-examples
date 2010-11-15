#!/usr/bin/env python2.7

import argparse
import hashlib
import json
import sys
import time
import urllib

BASE_URL = 'http://hyperlocal-api.outside.in/v1.1'

class StoryFinder:
  def __init__(self, key, secret):
    self.key = key
    self.secret = secret

  def find_stories(self, name):
    response = self.request("/locations/named/%s" % urllib.quote(name))
    locations = json.loads(response.read())['locations']
    response.close()
    if len(locations) == 0:
      raise Exception("No location named %s" % (name))
    else:
      response = self.request("/locations/%s/stories" % (urllib.quote(locations[0]['uuid'])))
      stories = json.loads(response.read())['stories']
      response.close()
      return stories

  def request(self, path):
    url = self.sign("%s%s" % (BASE_URL, path))
    print "Requesting %s" % url
    response = urllib.urlopen(url)
    if response.getcode() == 200:
      return response
    else:
      raise Exception("Request failed with code %s" % (response.getcode()))

  def sign(self, url):
    sig = hashlib.md5(self.key + self.secret + str(int(time.time()))).hexdigest()
    return "%s?dev_key=%s&sig=%s" % (url, self.key, sig)

parser = argparse.ArgumentParser()
parser.add_argument('key')
parser.add_argument('secret')
parser.add_argument('location')
args = parser.parse_args()

try:
  stories = StoryFinder(args.key, args.secret).find_stories(args.location)
  if len(stories) == 0:
    print "Found 0 stories"
  else:
    print "Found %s stories:" % len(stories)
    for story in stories:
      print "  %s" % (story['title'])
except Exception as e:
  print e
  sys.exit(2)
