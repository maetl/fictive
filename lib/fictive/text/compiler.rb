require 'strscan'

module Fictive
  module Text
    class Compiler
      def initialize(input)
        @input = input
      end

      def process
        @scanner = StringScanner.new(@input)

        Fictive::Text::Node.new(*parse_fragment)
      end

      private

      attr_reader :scanner

      def parse_fragment
        concat_fragment = scanner.scan_until(/{/)

        if concat_fragment
          [Fictive::Text::TextNode.new(concat_fragment.gsub(/{/, '')), parse_delimiter]
        else
          fragment = scanner.scan(/.+/)
          Fictive::Text::TextNode.new(fragment)
        end
      end

      def parse_delimiter
        if scanner.scan(/{/)
          parse_tag
        else
          parse_substitution
        end
      end

      def parse_tag
        scanner.skip(/\s+/)

        parse_conditional if scanner.scan(/if/)
      end

      def parse_conditional
        raise 'missing whitespace in conditional tag' unless scanner.scan(/\s+/)

        expression = parse_expression
        scanner.skip(/}}/)
        consequent = scanner.scan_until(/{{\/if}}/).gsub(/{{\/if}}/, '')

        Fictive::Text::ConditionalNode.new(
          Fictive::Text::ExpressionNode.new(
            expression
          ),
          Fictive::Text::TextNode.new(consequent)
        )
      end

      def parse_expression
        Fictive::Text::TrueNode.new if scanner.scan(/true/)
      end

      def parse_substitution

      end
    end

    class Node
      def initialize(*nodes)
        @nodes = nodes
      end

      def evaluate
        @nodes.map do |node|
          result = node.evaluate
        end.join
      end
    end

    class TextNode
      def initialize(text)
        @text = text
      end

      def evaluate
        @text
      end
    end

    class ConditionalNode
      # TODO: decide on array or explicit parameter convention
      #       eg: initialize(condition, consequent, alternative)
      def initialize(condition, consequent)
        @condition = condition
        @consequent = consequent
      end

      def evaluate
        @consequent.evaluate if @condition.evaluate_boolean
      end
    end

    class ExpressionNode
      def initialize(expression)
        @expression = expression
      end

      def evaluate_boolean
        @expression.evaluate_boolean
      end
    end

    class TrueNode
      def evaluate_boolean
        true
      end
    end

    class FalseNode
      def evaluate_boolean
        false
      end
    end
  end
end
