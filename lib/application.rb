# coding: utf-8

# This module is providing the configuration DSL
module Application
  class << self
    attr_accessor :log
    def configure
      yield self
    end
  end

end

