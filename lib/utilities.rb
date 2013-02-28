# coding: utf-8

require 'colored'

module Mines
module Utilities
extend self

def print_command(command, text)

  width = Integer(`tput cols`) - 22
  sum = 0
  print "  "+command.ljust(20).blue.bold
  text.split.each do |word|
    if (sum + word.size >= width)
      puts ""
      print "".ljust 22
      sum=0
    end   
    sum+=word.size+1
    print " "
    print word  
  end # end text.split
  puts ""
end

end
end
