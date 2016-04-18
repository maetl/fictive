require 'strscan'

module Fictive
  module Text
    class Compiler
      def initialize(input)
        @input = input
      end

      def process
        @scanner = StringScanner.new(@input)

        Fictive::Text::Node.new(*parse_fragments)
      end

      private

      attr_reader :scanner

      def parse_fragments
        fragments = []
        fragments << parse_fragment while !scanner.eos?
        fragments
      end

      def parse_fragment
        concat_fragment = scanner.scan_until(/{/)

        if concat_fragment
          Fictive::Text::Node.new(Fictive::Text::TextNode.new(concat_fragment.gsub(/{/, '')), parse_substitution)
        else
          concat_before_directive = scanner.scan_until(/~/)

          if concat_before_directive
            Fictive::Text::Node.new(Fictive::Text::TextNode.new(concat_before_directive.gsub(/~/, '')), parse_directive)
          else
            fragment = scanner.scan(/.+/)
            Fictive::Text::TextNode.new(fragment)
          end
        end
      end

      def parse_directive
        return parse_conditional if scanner.scan(/if/)

        raise 'Invalid syntax'
      end

      def parse_substitution
        scanner.skip(/\s/)

        if reference = scanner.scan(/[A-Za-z0-9_\-!]/)
          Fictive::Text::ReferenceNode.new(reference, {})
        else
          raise 'Invalid syntax'
        end

        scanner.skip(/\s*}/)
      end

      def parse_conditional
        raise 'missing whitespace in conditional tag' unless scanner.scan(/\s+/)

        expression = parse_expression
        scanner.skip(/:/)
        scanner.skip(/\s/)
        consequent = scanner.scan_until(/~/).gsub(/~/, '')

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

    class ReferenceNode
      def initialize(reference, symbol_table)
        @reference = reference
        @symbol_table = symbol_table
      end

      def evaluate
        @symbol_table.fetch(@reference)
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
