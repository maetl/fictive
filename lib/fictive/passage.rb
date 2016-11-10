module Fictive
  class Passage
    def initialize(node)
      @node = node
    end

    def id
      @node.id
    end

    def choices
      @node.out_e.all.map { |e| Choice.new(e) }
    end
  end
end
