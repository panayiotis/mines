# coding: utf-8

require 'logger'

# Configuration
require_relative 'configuration'

#require_relative 'application' # needed by config/application

# ./config/application may not have been created yet
#begin
#  require './config/application'
#rescue Exception => e  
#  require_relative '../config/application'
#end


# Check if log directory exists
log_dir = "log"
unless File.exists?(log_dir) && File.directory?(log_dir)
  log_dir="."
end

unless defined?(Application.logname).nil?
  @log ||= Logger.new "#{log_dir}/#{Application.logname}"
else
  @log ||= Logger.new '#{log_dir}/mines.log'
end

@log.datetime_format= "%H:%M:%S"
@log.formatter = proc do |severity, datetime, progname, msg|
  "#{severity} #{datetime} #{msg}\n"
end

def log_name name
  @log ||=  Logger.new '#{log_dir}/#{name}.log'
  @log.datetime_format= "%H:%M:%S"
  @log.formatter = proc do |severity, datetime, progname, msg|
    "#{severity} #{datetime} #{msg}\n"
  end  
end

=begin

module Mines

  # Use this module by including it in a class,
  # it defines the log method that instantiates a logger if it does not already exist
  # Reads the global configuration for options
  module Logging

    # instantiates a logger if it does not already exist or
    # it returns the existing logger
    def log
      if defined?(@log).nil?
        log_device = ""
        if not defined?(Application.log).nil?
          log_device = Application.log
        elsif Dir.exists?('log')
          log_device ='log/mines.log'
        else
          log_device = STDOUT
        end
        @log = Logger.new log_device
        @log.datetime_format= "%H:%M:%S"
        @log.formatter = proc do |severity, datetime, progname, msg|
          "#{msg}\n".yellow
        end
      end
      @log
    end # end def
  end # end module
end # end module

=end

