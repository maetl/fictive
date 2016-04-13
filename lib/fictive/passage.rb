module Fictive
  class Passage
    attr_reader :text

    def initialize(metadata, text)
      @metadata = metadata
      @text = text
    end

    def id
      @metadata.fetch(:id)
    end

    def choices
      @metadata.fetch(:choices, [])
    end
  end
end
