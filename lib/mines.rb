# coding: utf-8

require 'bundler/setup'
require 'json'
require 'colored' # TODO Remove dep
require_relative 'redis_store'
require_relative 'utilities'

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
