# coding: utf-8

module Mines::Help
  class << self
    attr_accessor :new, :generate
    def configure
      yield self
    end
  end
end
