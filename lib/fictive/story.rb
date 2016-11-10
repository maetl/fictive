module Fictive
  class Story
    def self._demo
      self.new([
        Passage.new({id: 'hello', choices: [Choice.new({id: 'goodbye'})]}, 'Hello world'),
        Passage.new({id: 'goodbye'}, 'Goodbye world')
      ])
    end

    def self.demo
      self.new(Mementus::Graph.new do
        create_node do |node|
          node.id = 'hello'
          node[:text] = 'Hello world'
          node.label = :passage
        end

        create_node do |node|
          node.id = 'goodbye'
          node[:text] = 'Goodbye world'
          node.label = :passage
        end

        create_edge do |edge|
          edge.id = 'say_goodbye'
          edge.from = 'hello'
          edge.to = 'goodbye'
          edge.label = :choice
        end
      end, 'hello')
    end

    def initialize(graph, start_id)
      # @passages = passages
      # @passages_index = {}
      # @passages.each_with_index do |passage, id|
      #   @passages_index[passage.id] = id
      # end
      #
      # @index = 0
      @graph = graph
      @current = graph.n(start_id)
    end

    # Initiate a new story graph traversal from the starting point.
    def start
      # TODO
    end

    # Resume a story graph traversal from a bookmarked place in the story.
    def resume
      # TODO
    end

    def has_next?
      #!@passages.at(@index).nil? && !@passages.at(@index + 1).nil?
      @current.out_e.all.count > 0
    end

    def next
      Passage.new(@current)
    end

    def choose_path(id)
      @current = @graph.edge(id).to
      Passage.new(@current)
    end
  end
end
