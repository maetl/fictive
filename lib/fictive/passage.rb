module Fictive
  class Passage
    attr_reader :text

    def initialize(metadata, text)
      @metadata = metadata
      @text = text
    end

    def path
      @metadata.fetch(:path)
    end

    def choices
      @metadata.fetch(:choices, [])
    end
  end
end
