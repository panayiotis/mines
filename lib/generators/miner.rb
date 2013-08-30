# coding: utf-8

require 'thor'
require_relative '../logging'

module Mines::Generator
  
  # Miner Generator generates files with boilerblate code 
  # in the miners directory. According to arguments it generates the
  # following types of miners:
  # - Network
  # - Process
  # - Metrics
  class Miner < Thor::Group
    include Thor::Actions
    include Mines::Logging

    # Define arguments and options
    argument :type, :desc => "The type of the miner, [Network,Process,Metrics]", :required => true
    argument :name, :desc => "The name of the miner", :required => true
    #class_option :evented, :type => :boolean, :default => false, :lazy_default => true
    
    # Define the source template root
    def self.source_root
      File.dirname(__FILE__)
    end
    
    # Use the appropriate template file according to type
    # and put the generated file in miners directory
    def create_miner_file
      puts "Copy miner template"
      #puts options[:evented]
      template "templates/#{type}_miner.erb", "miners/#{name}.rb"
    end
    
  end # class

end # module
