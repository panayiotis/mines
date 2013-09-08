#!/usr/bin/ruby
# http://mattsears.com/articles/2011/12/10/minitest-quick-reference

require "minitest/autorun"

require_relative '../lib/utilities'


describe "Mines::gem_exists? method" do

  before do
    
  end

  after do
  
  end 

  it "returns true for gem mines" do
    Mines::gem_exists?('mines').must_equal true
  end

  it "returns false for gem vgbo145o" do
    Mines::gem_exists?('vgbo145o').must_equal false
  end  
end
