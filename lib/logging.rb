# coding: utf-8

require 'logger'

module Mines
  class << self
    attr_accessor :log
  end
  
  # Create Logger
  @log ||= Logger.new 'log/mines.log'
  @log.datetime_format= "%H:%M:%S"
  @log.formatter = proc do |severity, datetime, progname, msg|
  "#{severity} #{datetime.strftime("%H:%M:%S")}: -- #{msg}\n"
end
end

