# coding: utf-8

require 'thor'
require 'colored'
require_relative '../logging'

module Mines::Generator

  class Application < Thor::Group
    include Thor::Actions
    include Mines::Logging

    # Define arguments and options
    argument :name

    def self.source_root
      File.dirname(__FILE__)
    end

    def create_directory_structure
      log.info "Creating directory structure in dir: " + name
      empty_directory name
      empty_directory name + "/miners"
      empty_directory name + "/lib"
      empty_directory name + "/log"
      empty_directory name + "/config"
      template "templates/application_config.erb", "#{name}/config/application.rb"
      puts "Application created successfully! ".green
      print "Type "
      print "'cd #{name}' ".yellow
      print "to go to the applications root directory, and then "
      print "'mines help' ".yellow
      puts "to see all available commands and options."
    end
    
  end # class

end # module
