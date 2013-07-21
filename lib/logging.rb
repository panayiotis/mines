# coding: utf-8

require 'logger'
require 'colored' # TODO: Remove maybe
require_relative 'application' # needed by config/application
require './config/application'

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

