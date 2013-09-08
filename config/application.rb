# This file provides some default config options
# It should be copied to every app's config folder


Application.config do
  parameter :logname
  parameter :var
end

Application.config do
  logname  "hashtags.log"
  var  'default var'
end
