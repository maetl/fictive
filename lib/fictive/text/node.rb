module Fictive
  module Text
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
  end
end
