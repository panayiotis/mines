# This file provides some default config options

Application.config do
  parameter :logname
  parameter :var
end

Application.config do
  logname  "mines.log"
  var  'default var'
end
