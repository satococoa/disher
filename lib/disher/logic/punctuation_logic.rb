# coding: utf-8
module Disher
  class PunctuationLogic < Logic
    @@default_options = {
      :punctuations => %w(、 。 ！ ？),
      :extract_tags => %w(div td section article),
      :punctuations_count_weight => 0.8,
      :children_count_weight => 2
    }

    def extract(body)
      doc = Nokogiri::HTML(
        body.encode("UTF-8",
          :invalid => :replace, :undef => :replace, :replace => ""))
      elements = []
      @options[:extract_tags].each do |tag|
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
      punctuations_count = body.count(@options[:punctuations].join)
      children_count = element.children.count
      punctuations_count * @options[:punctuations_count_weight] - children_count * @options[:children_count_weight]
    end
  end
end