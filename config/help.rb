# coding: utf-8

Mines::Help.configure do |config|
  config.new = { sum: "new APP_NAME" , 
                desc: "Create Application APP_NAME" , 
                help: ""
               }
  config.generate = { sum: "generate [twitter|network|process|metrics] NAME" , 
                     desc: "Create a twitter or network or process or metrics miner" , 
                     help: ""
                    }
end

