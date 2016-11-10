module Fictive
  class Choice
    def initialize(edge)
      @edge = edge
    end

    def id
      @edge.id
    end
  end
end
