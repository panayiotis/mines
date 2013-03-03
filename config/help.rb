# coding: utf-8

Mines::Help.configure do |config|
  config.new = { sum: "new APP_NAME" , 
                desc: "Create Application APP_NAME" , 
                help: ""
               }
  config.generate = { sum: "generate model|miner NAME" , 
                     desc: "Create a miner or model with NAME" , 
                     help: ""
                    }
end

