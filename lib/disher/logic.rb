module Disher
  class Logic
    @@default_options = {}

    def initialize(options)
      @options = @@default_options.merge(options)
    end

    def extract(body)
      raise NotImplementedError
    end

    def calculate_score(element)
      raise NotImplementedError
    end
  end
end

require 'disher/logic/punctuation_logic'