# coding: utf-8

require 'colored'

def green(text); "\033[32m#{text}\033[0m" end
def blue(text); "\033[34m#{text}\033[0m" end
def red(text); "\033[31m#{text}\033[0m" end
def yellow(text); "\033[33m#{text}\033[0m" end

def print_tweet(user, text)
  width = Integer(`tput cols`) - 18
  sum = 0
  print user.center(16).blue.bold
  text.split.each do |word|
    if (sum + word.size >= width)
      puts ""
      print "".ljust 16
      sum=0
    end   
    sum+=word.size+1
    if word.include?("http")
      print word.cyan.underline
    elsif word.start_with? "@"
      print word.blue.bold
    elsif word.start_with? "#"
      print yellow word
    else
      print word
    end
    print " "  
  end
  puts ""
end

# TODO Is this still needed?
def ago_time(time)
  ago = Time.now - time
  if  ago < 3600
    return "#{ago.div(1)} minutes ago"
  elsif ago < 3600 * 12
    return "#{ago.div(3600)} hours ago"
  elsif ago < 3600 * 24
    return "Yesterday"
  elsif ago < 3600 * 24 * 7
    return "#{time.strftime('%A')}"
  else 
    return "#{time.strftime('%A %-d %B %Y')}"
  end       
end

module Mines
  module Utilities
    extend self

    def print_command(command, text)
      width = Integer(`tput cols`) - 22
      sum = 0
      print "  "+command.ljust(20).blue.bold
      text.split.each do |word|
        if (sum + word.size >= width)
          puts ""
          print "".ljust 22
          sum=0
        end   
        sum+=word.size+1
        print " "
        print word  
      end # end text.split
      puts ""
    end # end def

  end # end module
end # end module
