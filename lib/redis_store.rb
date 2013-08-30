# coding: utf-8

require 'redis'
require 'hiredis'

def keygen
  Time.now.strftime("ts:%Y:%m:%d:%H:%M")
end
  
class RedisConnection
  attr_reader :redis
  def initialize *args
    #@key= key
    $redis ||= Redis.new(:path => "/tmp/redis.sock",:driver => :hiredis)
    @redis = $redis
    # puts "Connected to Redis"
  end # end initialize
  
  def counters
    @redis.hgetall "counters"
  end
end

class MessageQueue < RedisConnection
  attr_reader :key
  
  def initialize key
    @key = key
    super
  end
  
  def pop()
    @redis.blpop(@key)[1]
  end # end pop
  
  def push(item)
    redis.pipelined do
      @redis.hincrby "counters", @key, 1
      #@redis.hincrby "ts:counters", keygen+"_count", 1      
      @redis.rpush(@key, item )
    end
  end # end push

  def del
    @redis.del @key
  end
  
  def size
    @redis.llen @key
  end

  def info
    out = "items in list:".ljust(25) + size.to_s + "\n"
    out += "number of keys:".ljust(25) + @redis.dbsize.to_s + "\n"
    %w{ used_memory_human used_memory_peak_human total_commands_processed}.each do |w|
      out += "#{w.gsub("_", " ")}:".ljust(25)
      out += @redis.info[w]
      out += "\n"
    end
    return out
  end
        
  def to_s
    @key
  end
    
end


class ObjectQueue < MessageQueue
  
  def pop()
    Marshal.load(@redis.blpop(@key)[1])
  end # end pop
  
  def push(item)
    redis.pipelined do
      @redis.hincrby "counters", @key, 1
      #@redis.incr(@key+"_count")
      #@redis.incr(keygen+"_count")
      @redis.rpush(@key, Marshal.dump(item) )
    end
  end # end push
end


class Counter < RedisConnection
  attr_reader :key
  
  def initialize key
    @key = key
    super  
  end
  
  def incr
    @redis.hincrby "counters", @key, 1
  end
  
  def del
    @redis.hdel "counters", @key
  end
  
  def to_s
    @redis.hget "counters", @key
  end  
end

class MessageChannel < RedisConnection
  attr_reader :channel
  
  def initialize channel
    @channel = channel
    super
  end
  
  def subscribe &proc
    @redis.subscribe @channel do |on|
    on.message &proc
    end
  end
  
  def publish message
    redis.pipelined do
      @redis.hincrby "counters", @channel, 1
      #@redis.hincrby "ts:counters", keygen+"_count", 1      
      @redis.publish(@channel, message )
    end
  end
       
  def to_s
    @channel
  end
    
end

