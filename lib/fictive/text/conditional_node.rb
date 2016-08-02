module Fictive
  module Text
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
  end
end
