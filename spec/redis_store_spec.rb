#!/bin/ruby
# coding: utf-8

# http://mattsears.com/articles/2011/12/10/minitest-quick-reference
require_relative "../lib/redis_store"
require 'redis'
require "minitest/autorun"
require 'minitest/pride'

describe "MessageQueue" do

  before do
    @redis ||= Redis.new(:path => "/tmp/redis.sock")
    @redis.del "test_queue"
    @redis.rpush "test_queue", ["one", "two", "three"]
    @q = MessageQueue.new("test_queue")
  end
  
  it "gets created" do
    @q.key.must_equal "test_queue"
  end

  it "has size" do
    @q.size.must_be_instance_of Fixnum
  end
  
  it "can push" do
   s = @q.size
   @q.push "four"
   @q.size.must_equal s+=1
  end
  
  it "can pop" do
   s = @q.size
   @q.pop.must_equal "one"
   @q.pop.must_equal "two"
   @q.pop.must_equal "three"
   @q.size.must_equal s-=3
  end  

end

describe "ObjectQueue" do

  before do
    @redis ||= Redis.new(:path => "/tmp/redis.sock")
    @redis.del "test_queue"
    @q = ObjectQueue.new("test_queue")
  end
  
  it "can push" do
   s = @q.size
   @q.push({ :a=>"a", :b => "b" })
   @q.size.must_equal s+=1
  end
  
  it "can pop" do
   @q.push({ :a=>"a", :b => "b" })
   s = @q.size
   @q.pop.must_equal({ :a=>"a", :b => "b" })
   @q.size.must_equal s-=1
  end  

end
