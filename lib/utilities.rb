# coding: utf-8

require 'colored'

def green(text); "\033[32m#{text}\033[0m" end
def blue(text); "\033[34m#{text}\033[0m" end
def red(text); "\033[31m#{text}\033[0m" end
def yellow(text); "\033[33m#{text}\033[0m" end

module Mines
  extend self

  # Check if mines is executed inside a mines application directory
  def in_app_root?
    # simply check if basic dirs exist
    %w{ miners lib log config config/application.rb}.each do |file|
      return false if not File.exists?(file)
    end
    return true
  end
  
  # Exit if mines is invokated outside application root
  def mines_app_check
    if not in_app_root?
      print "It seems your current directory: "
      puts File.expand_path('.').yellow
      puts "does not contains a Mines application."
      puts "You can create one by invoking: " + "mines new APPNAME".blue.bold
      exit 0
    end
  end
end


module Mines
  extend self
  
  # Examines if a gem axists
  #
  # @param gem [String] the gem's name
  # @return [Boolean] If gem exists or not
  def gem_exists? gem
    ! Gem::Specification.find_all_by_name(gem).empty?
  end

end

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
