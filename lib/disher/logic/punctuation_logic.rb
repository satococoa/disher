# coding: utf-8
module Disher
  class PunctuationLogic < Logic
    @@default_options = {
      :punctuations => %w(、 。 ！ ？),
      :extract_tags => %w(div td section article),
      :plus_words => [/main/],
      :minus_words => [/comment/, /side/, /menu/],
      :punctuations_weight => 1.8,
      :children_weight => -0.5,
      :links_weight => -1,
      :plus_words_weight => 2,
      :minus_words_weight => -1.5
    }

    def extract(body)
      doc = Nokogiri::HTML(
        body.encode("UTF-8",
          :invalid => :replace, :undef => :replace, :replace => ""))
      survey(doc)
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

    private
    def survey(doc)
      @punctuations_count = doc.text.count(@options[:punctuations].join)
      @children_count     = doc.xpath(".//*").count
      @links_count        = doc.xpath(".//a['href']").count
      @plus_words_count   = @options[:plus_words].inject(0) {|count, word| count += doc.text.scan(word).count }
      @minus_words_count  = @options[:minus_words].inject(0) {|count, word| count += doc.text.scan(word).count }
    end

    def calculate_score(element)
      punctuations_rate = element.text.count(@options[:punctuations].join).to_f / @punctuations_count
      children_rate     = element.xpath(".//*").count.to_f / @children_count
      links_rate        = element.xpath(".//a['href']").count.to_f / @links_count
      plus_words_rate   = @options[:plus_words].inject(0) {|count, word| count += element.text.scan(word).count }.to_f / @plus_words_count
      minus_words_rate  = @options[:minus_words].inject(0) {|count, word| count += element.text.scan(word).count }.to_f / @minus_words_count

      score = punctuations_rate * @options[:punctuations_weight] +
        children_rate * @options[:children_weight] +
        links_rate * @options[:links_weight] +
        plus_words_rate * @options[:plus_words_weight] +
        minus_words_rate * @options[:minus_words_weight]

      if @options[:debug]
        puts element.inspect
        puts "score: #{score}"
        puts "punctuations: #{punctuations_rate}"
        puts "children: #{children_rate}"
        puts "links: #{links_rate}"
        puts "plus_words: #{plus_words_rate}"
        puts "minus_words: #{minus_words_rate}"
        puts "=========================================="
      end

      score
    end
  end
end