# coding: utf-8
module Disher
  class CssLogic < Logic
    @@default_options = {
      :css => '#content'
    }

    def extract(body)
      if @options[:debug]
        puts "css: #{@options}"
        puts "=========================================="
      end
      doc = Nokogiri::HTML(
        body.encode("UTF-8",
          :invalid => :replace, :undef => :replace, :replace => ""))
      doc.css(@options[:css]).inner_html
    end
  end
end