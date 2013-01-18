# coding: utf-8
require 'nokogiri'

require "disher/version"

module Disher
  @@punctuations = ['、', '。', '！', '？']
  @@extract_tags = ['div', 'td', 'section', 'article']
  @@punctuations_count_weight = 0.8
  @@children_count_weight = 2

  module_function
  def extract(body)
    doc = Nokogiri::HTML(body)
    elements = []
    @@extract_tags.each do |tag|
      elements << doc.xpath("//#{tag}")
    end
    score = 0
    content = ''
    elements.flatten.each do |elm|
      c = calculate_score(elm)
      if c > score
        content = elm.inner_html
        score = c
      end
    end
    content
  end

  def calculate_score(element)
    body = element.inner_html
    punctuations_count = body.count(@@punctuations.join)
    children_count = element.children.count
    punctuations_count * @@punctuations_count_weight - children_count * @@children_count_weight
  end
end
