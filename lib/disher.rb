require 'nokogiri'

require "disher/version"
require "disher/logic"

module Disher
  @@logics = {
    :punctuation => PunctuationLogic,
    :css => CssLogic,
    # :xpath => XpathLogic # TODO: not implemented
  }
  @@default_logic = :punctuation

  module_function
  def extract(body, options = {})
    logic_name = @@logics[(options.delete(:logic) || @@default_logic).intern]
    raise Logic::NotImplementedError if logic_name.nil?
    logic = logic_name.new(options)
    logic.extract(body)
  end
end
