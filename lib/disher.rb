require 'nokogiri'

require "disher/version"
require "disher/logic"

module Disher
  @@logics = {
    :punctuation => PunctuationLogic,
    # :css => CssLogic, # TODO: not implemented
    # :xpath => XpathLogic # TODO: not implemented
  }
  @@default_logic = :punctuation

  module_function
  def extract(body, options = {})
    logic = @@logics[(options.delete(:logic) || @@default_logic)].new(options)
    logic.extract(body)
  end
end
