module Fictive
  module Text
    class ExpressionNode
      def initialize(expression)
        @expression = expression
      end

      def evaluate_boolean
        @expression.evaluate_boolean
      end
    end
  end
end
