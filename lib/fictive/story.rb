module Fictive
  class Story
    def self.demo
      self.new([
        Passage.new({id: 'hello', choices: [Choice.new({id: 'goodbye'})]}, 'Hello world'),
        Passage.new({id: 'goodbye'}, 'Goodbye world')
      ])
    end

    def initialize(passages)
      @passages = passages
      @passages_index = {}
      @passages.each_with_index do |passage, id|
        @passages_index[passage.id] = id
      end

      @index = 0
    end

    def has_next?
      !@passages.at(@index).nil? && !@passages.at(@index + 1).nil?
    end

    def next
      @passages.at(@index)
    end

    def choose_path(id)
      @index = @passages_index[id]
    end
  end
end
