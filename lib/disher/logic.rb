module Disher
  class Logic
    class NotImplementedError < NotImplementedError; end
    @@default_options = {}

    def initialize(options)
      @options = @@default_options.merge(options)
    end

    def extract(body)
      raise NotImplementedError
    end
  end
end

require 'disher/logic/punctuation_logic'
require 'disher/logic/css_logic'