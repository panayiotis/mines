#!/bin/ruby
# coding: utf-8

## Gem dependencies are managed by Bundler inside project's Gemfile
require 'bundler'
Bundler.require :process

@log.info "Process miner pid: #{Process.pid}"

## Connect to an Object Queue
## elementes are pushed to this queue by the network miner
queue = ObjectQueue.new "publicstream"

counter = Counter.new "original"

channel = MessageChannel.new("web") # example channel

## Create a timeseries metrics store to
## save the occurence rate for each tag for each minute
ts = TimeSeries.new("hashtags")

## Create a timeseries metrics store to
## save the total number of tweets each minute
tweets_rate = TimeSeries.new("tweets_rate")

## Start the process loop
loop {
  ## Get en element from the queue
  status = queue.pop
  tweets_rate.push "all"
  
  ## Filter out Retweets and Replies
  unless status.text =~ /^RT/ or
         status.retweet_count > 0 or
         status.text =~ /^@/
         
    print_tweet(status.user.screen_name, status.text)
    
    status.hashtags.each do |hashtag|
      ts.push (hashtag.text)
    end
    counter.incr
    channel.publish({:user => status.user.screen_name, :text => status.text}.to_json)
    #web.publish({:user => status.user.screen_name, :text => status.text.gsub(/(https?:\/\/\S+)/, '<a href="\1" target="_blank">\1</a> ').to_s}.to_json)
  end
} # end loop
