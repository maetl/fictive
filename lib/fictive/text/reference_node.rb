module Fictive
  module Text
    class ReferenceNode
      def initialize(reference, symbol_table)
        @reference = reference.to_sym
        @symbol_table = symbol_table
      end

      def evaluate
        @symbol_table.fetch(@reference)
      end
    end
  end
end
