#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'md5'
require 'net/http'
require 'uri'

class StoryFinder
  BASE_URL = "http://hyperlocal-api.outside.in/v1.1"

  def initialize(key, secret)
    @key = key
    @secret = secret
  end

  def find_stories(name)
    request("/locations/named/#{URI.escape(name)}") do |response|
      locations = JSON[response.body]['locations']
      raise Exception.new "No location named #{name}" if locations.empty?
      request("/locations/#{URI.escape(locations.first['uuid'])}/stories") do |response|
        JSON[response.body]['stories']
      end
    end
  end

  def request(path, &block)
    url = URI.parse(sign("#{BASE_URL}#{path}"))
    puts "Requesting #{url}"
    response = Net::HTTP.get_response(url)
    if response.code.to_i == 200
      yield(response)
    else
      raise Exception.new("Request failed with code #{response.code}")
    end
  end

  def sign(url)
    "#{url}?dev_key=#{@key}&sig=#{MD5.new(@key + @secret + Time.now.to_i.to_s).hexdigest}"
  end
end

unless ARGV.length == 3
  puts "Usage: #{$0} <developer key> <shared secret> <location>"
  exit 1
end

begin
  stories = StoryFinder.new(ARGV[0], ARGV[1]).find_stories(ARGV[2])
  if stories.empty?
    puts "Found 0 stories"
  else
    puts "Found #{stories.count} stories:"
    stories.each do |story|
      puts "  #{story['title']}"
    end
  end
rescue Exception => e
  puts e.message
  exit 2
end
