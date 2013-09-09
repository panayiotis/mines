#!/bin/ruby
# coding: utf-8

## Gem dependencies are managed by Bundler inside project's Gemfile
require 'bundler'
Bundler.require :metrics
#require 'active_support/core_ext/date/calculations.rb'

## Initialize TimeSeries
## Data is been pushed constantly to the timeseries by
## the process miner
@ts = TimeSeries.new("hashtags")
@tweets_rate = TimeSeries.new("tweets_rate")


## Print strings in columns in the terminal
## the terminal needs to have the 'tput' command  
def columnize *args
 columns = args.size
 width = Integer(`tput cols`) / columns
  args.each{|a| print a.to_s.slice(0,width).ljust(width)}
  puts ""
end

## Print strings in columns in the terminal
## the terminal needs to have the 'tput' command  
def columnize_arrays *args
 columns = args.size
 width = Integer(`tput cols`) / columns
 lines = 0
 args.each { |a| lines = a.size - 1 if (a.size - 1 > lines)}
 line = 0
 lines.times do
   args.each do |a|
     unless a[line].nil?
       print a[line][0].to_s.slice(0,width).ljust(width)
     else
       print '-'.ljust(width)
     end
   end
   puts ""
   line+=1
 end
 
end

## Print info and results to the terminal
def refresh_terminal
  `reset`
  
  ## General info
  puts Time.now.to_s
  info = @ts.redis.info
  print "Redis: "
  puts info["db0"]
  print "Redis Memory: "
  puts info["used_memory_human"]
  
  ## Timeseries info
  print "TimeSeries Keys: "
  puts @ts.keys.size
  print "TimeSeries resolution: "
  puts @ts.resolution  
  puts ""
  print "Tweets per minute: "
  puts @tweets_rate.last["all"]
  
  
  ## Print a table about hashtags popularity during the
  ## last minute
  width = Integer(`tput cols`)
  puts "Trending hashtags during the last minute".center(width)
  puts '-'*width
  columnize "Hashtag","Last Minute", "Prev Minute","Last Hour", "Prev Hour", "Today", "Yesterday"
  puts '-'*width
  last = @ts.last_key.get 
  previous = @ts.previous_key.get
  last_hour = @ts.hour(Time.now)
  previous_hour = @ts.hour(Time.now - 1.hour)
  today = @ts.day(Date.today)
  yesterday = @ts.day(Date.yesterday)  

  if @ts.last_key.persistant?
    last.each do |hashtag,value|
      if previous.has_key? hashtag
        previous_value = '%.2f' % previous[hashtag]
      else
        previous_value = "-"
      end
  
      if last_hour.has_key? hashtag
        last_hour_value = '%.2f' % last_hour[hashtag]
      else
        last_hour_value = "-"
      end
    
      if previous_hour.has_key? hashtag
        previous_hour_value = '%.2f' % previous_hour[hashtag]
      else
        previous_hour_value = "-"
      end   
      
      if today.has_key? hashtag
        today_value = '%.2f' % today[hashtag]
      else
        today_value = "-"
      end
      
      if yesterday.has_key? hashtag
        yesterday_value = '%.2f' % yesterday[hashtag]
      else
        yesterday_value = "-"
      end    
      columnize( hashtag, '%.2f' % value,
                 previous_value,
                 last_hour_value,
                 previous_hour_value,
                 today_value,
                 yesterday_value
               )
    end
  else
    puts "(no hashtags during the last minute)".center(width)
  end
  
  
  
  ## Print a table about hashtags popularity during the
  ## various time periods
  puts "\n\n"
  puts "Popular Hashtags".center(width)
  puts '-'*width
  columnize "Last Minute", "Prev Minute","Last Hour",
            "Prev Hour", "Today", "Yesterday"
  puts '-'*width
  last = last.sort_by { |k, v| v }.reverse.slice(0,15)
  previous = previous.sort_by { |k, v| v }.reverse.slice(0,15)
  last_hour = last_hour.sort_by { |k, v| v }.reverse.slice(0,15)
  previous_hour = previous_hour.sort_by { |k, v| v }.reverse.slice(0,15)
  today = today.sort_by { |k, v| v }.reverse.slice(0,15)
  yesterday = yesterday.sort_by { |k, v| v }.reverse.slice(0,15)
  
  columnize_arrays last, previous, last_hour, 
                   previous_hour, today, yesterday
end


refresh_terminal

## Start Event Machine
EM.run do
  
  ## Periodic execution
  EM::PeriodicTimer.new(10){
    refresh_terminal
  }
end # end EM
