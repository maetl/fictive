module Fictive
  class Scene
    attr_reader :passage

    def initialize(metadata, passage)
      @metadata = metadata
      @passage = passage
    end

    def path
      @metadata.fetch(:path)
    end

    def choices
      @metadata.fetch(:choices, [])
    end
  end
end
