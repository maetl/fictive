require 'strscan'

module Syntax
  class Element
    attr_accessor :content, :children

    def initialize(content = nil)
      @content = content
      @children = []
    end

    def empty?
      @children.empty?
    end
  end

  EOL = "\n".freeze

  class Parser
    def initialize(input)
      @input = clean_input(input)
    end

    def parse
      @scanner = StringScanner.new(@input)
      @root = Element.new
      parse_block_level(@root)
      @root
    end

    private

    def parse_block_level(element)
      text = @scanner.scan_until(/#{EOL}/).rstrip

      if text.empty?
        element.children << Element.new
      else
        element.children << Element.new(text)
      end

      parse_block_level(element) unless @scanner.eos?

      element
    end

    def clean_input(input)
      input.gsub(/\r\n?/, EOL).chomp + EOL
    end
  end
end
