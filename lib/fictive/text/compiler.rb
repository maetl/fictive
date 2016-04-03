module Fictive
  module Text
    class Compiler
      def initialize(source)
        @source = source
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
