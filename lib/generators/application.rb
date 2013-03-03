# coding: utf-8

require 'thor'
module Generator
  class Application < Thor::Group
    include Thor::Actions

    desc "new APP_NAME"
    
    # Define arguments and options
    argument :name

    def self.source_root
      File.dirname(__FILE__)
      puts File.dirname(__FILE__)
    end

    def create_directory_structure
      empty_directory name
      empty_directory name + "/miners"
      empty_directory name + "/lib"
      empty_directory name + "/log"
      empty_directory name + "/config"
    end
  end
end
