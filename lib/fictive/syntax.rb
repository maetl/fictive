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
        return parse_blockquote if @scanner.scan(/>\s+/)
        return parse_atx_header if @scanner.scan(/#/)
        return parse_passage_break if @scanner.scan(/§|\*/)
        return parse_blank_line if @scanner.scan(/#{EOL}/)
        return parse_list_item if @scanner.scan(/-/)

        parse_paragraph
      end

      def parse_blockquote
        parse_multiline_block(:blockquote, />\s+/)
      end

      def parse_paragraph
        parse_multiline_block(:paragraph)
      end

      def parse_multiline_block(element_type, skip_indent=false)
        parts = []
        text = scan_line(skip_indent)

        if text
          parts << text.rstrip

          while !@scanner.match?(/#{EOL}/)
            next_text = scan_line(skip_indent)
            break unless next_text
            parts << next_text.rstrip
          end

          Element.new(element_type, parts.join(' '))
        end
      end

      def scan_line(skip_indent)
        @scanner.skip(skip_indent) if skip_indent
        @scanner.scan_until(/#{EOL}/)
      end

      def parse_blank_line
        Element.new(:blank_line)
      end

      def parse_passage_break
        Element.new(:passage_break)
      end

      def parse_atx_header
        return parse_passage_break if @scanner.scan(/#{EOL}/)

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

      def scan_to_eol
        @scanner.scan_until(/#{EOL}/).rstrip
      end

      def clean_input(input)
        input.gsub(/\r\n?/, EOL).chomp + EOL
      end
    end
  end
end
