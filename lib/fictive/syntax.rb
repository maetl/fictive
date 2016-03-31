require 'strscan'

module Fictive
  module Syntax
    class Element
      attr_reader :type, :text
      attr_accessor :children

      def initialize(type, text = nil)
        @type = type
        @text = text
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
        reset_parser

        document = Element.new(:document)

        while !@scanner.eos?
          document.children << parse_block_level
        end

        document
      end

      private

      def reset_parser
        @scanner = StringScanner.new(@input)
      end

      def parse_block_level
        return parse_atx_header if @scanner.scan(/#/)
        return parse_blank_line if @scanner.scan(/#{EOL}/)
        return parse_list_item if @scanner.scan(/-/)

        parse_paragraph
      end

      def parse_blank_line
        Element.new(:blank_line)
      end

      def parse_atx_header
        level = 1
        level += 1 while @scanner.scan(/#/)

        if @scanner.scan(/\s/)
          Element.new("h#{level}".to_sym, scan_to_eol)
        else
          Element.new(:id, scan_to_eol)
        end
      end

      def parse_list_item
        if @scanner.scan(/\s/)
          Element.new(:list_item, scan_to_eol)
        else
          parse_paragraph
        end
      end

      def parse_paragraph
        text = scan_to_eol
        Element.new(:paragraph, text)
      end

      def scan_to_eol
        @scanner.scan_until(/#{EOL}/).rstrip
      end

      def clean_input(input)
        input.gsub(/\r\n?/, EOL).chomp + EOL
      end
    end
  end
end
