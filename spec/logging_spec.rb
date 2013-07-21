#!/usr/bin/ruby
# http://mattsears.com/articles/2011/12/10/minitest-quick-reference
require_relative "../lib/logging.rb"
require "minitest/autorun"

describe "Logging" do
include Mines::Logging
  before do
    
  end

  after do
  
  end 

  it "instantiates a logger" do
   log.must_be_instance_of Logger
  end
end
