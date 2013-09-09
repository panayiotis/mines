# coding: utf-8

require 'thor'
require 'colored'
require_relative '../logging'

# The Generator module is the namespace of all generators
# Namely:
# - Application
# - Miner
module Mines::Generator

  # Application Generator creates the default file structure.
  # Accepts as an argument the name of the new application. A new directory with this name will be created
  class Application < Thor::Group
    include Thor::Actions
    #include Mines::Logging

    # Define arguments and options
    argument :name
    
    # This is needed by thor. Returns the source root directory.
    def self.source_root
      File.dirname(__FILE__)
    end

    # Create the default directory structure
    # - Directories: miners, lib, log, config
    # - Files: TODO
    # also prints appropriate messages
    def create_directory_structure
      #@log.info "Creating directory structure in dir: " + name
      empty_directory name
      empty_directory name + "/miners"
      empty_directory name + "/lib"
      empty_directory name + "/log"
      empty_directory name + "/config"
      template "templates/application_config.erb", "#{name}/config/application.rb"
      template "templates/Gemfile.erb", "#{name}/Gemfile"      
      puts "Application created successfully! ".green
      print "Type "
      print "'cd #{name}' ".yellow
      print "to go to the applications root directory, and then "
      print "'mines help' ".yellow
      puts "to see all available commands and options."
    end
    
  end # class

end # module
