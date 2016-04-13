module Fictive
  class Story
    def self.demo
      self.new([
        Passage.new({path: 'hello', choices: [Choice.new({path: 'goodbye'})]}, 'Hello world'),
        Passage.new({path: 'goodbye'}, 'Goodbye world')
      ])
    end

    def initialize(passages)
      @passages = passages
      @passages_index = {}
      @passages.each_with_index do |passage, id|
        @passages_index[passage.path] = id
      end

      @index = 0
    end

    def has_next?
      !@passages.at(@index).nil? && !@passages.at(@index + 1).nil?
    end

    def next
      @passages.at(@index)
    end

    def choose_path(path)
      @index = @passages_index[path]
    end
  end
end
