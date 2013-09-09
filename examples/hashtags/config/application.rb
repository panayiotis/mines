# coding: utf-8
## Configuration file for your app

## Declare the configuration parameters you want to use
Application.config do
  parameter :var1
  parameter :var2
  parameter :var3
  parameter :logname
  parameter :app_prefix  
end

## Change their values
Application.config do
  var1  "value"
  var2  ['one','two','three']
  var3  { :one=>1, :two=>2 }
  logname  "hashtags.log"
  app_prefix "app"
end


## Initializer
## e.g. initialize a global variable
## $app_prefix variable needs to be global
$app_prefix = Application.app_prefix


## Usage example
# puts Application.var1
