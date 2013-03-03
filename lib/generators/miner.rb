# coding: utf-8

require 'thor'
require_relative '../logging'

module Mines::Generator

  class Miner < Thor::Group
    include Thor::Actions
    include Mines::Logging

    # Define arguments and options
    argument :name, :desc => "The name of the miner", :required => true
    class_option :evented, :type => :boolean, :default => false, :lazy_default => true
    
    # Define the source template root
    def self.source_root
      File.dirname(__FILE__)
    end
    
    def create_miner_file
      puts "copy miner template"
      puts options[:evented]
      #template "templates/miner.erb", "miners/#{name}.rb"
    end
    
  end # class

end # module
