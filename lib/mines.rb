# coding: utf-8

require 'colored' # TODO Remove dep

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
      puts "Error:".red
      print "It seems your current directory: "
      print File.expand_path('.').yellow
      puts " does not contain a Mines application."
      puts "You can create one by invoking: " + "mines new APPNAME".blue.bold
      exit 0
    end
  end
end
