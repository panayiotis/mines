# coding: utf-8

require 'logger'

# Use this module by including it in a class
module Mines::Logging
  def log
    if defined?(@log).nil?
      if Dir.exists?('log')
        @log = Logger.new 'log/mines.log'
      else
        @log = Logger.new 'mines.log'
      end
      @log.datetime_format= "%H:%M:%S"
      @log.formatter = proc do |severity, datetime, progname, msg|
        "#{severity} #{datetime.strftime("%H:%M:%S")}: -- #{msg}\n"
      end
    end
    @log
  end # end def
end # end module

##
## Old version

#module Mines
#  class << self
#    attr_accessor :log
#  end
#  
#  # Create Logger
#  @log ||= Logger.new 'log/mines.log'
#  @log.datetime_format= "%H:%M:%S"
#  @log.formatter = proc do |severity, datetime, progname, msg|
#    "#{severity} #{datetime.strftime("%H:%M:%S")}: -- #{msg}\n"
#  end
#end
