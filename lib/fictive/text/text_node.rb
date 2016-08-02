module Fictive
  module Text
    class TextNode
      def initialize(text)
        @text = text
      end

      def evaluate
        @text
      end
    end
  end
end
