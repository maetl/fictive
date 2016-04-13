module Fictive
  class Choice
    def initialize(metadata)
      @metadata = metadata
    end

    def id
      @metadata.fetch(:id)
    end
  end
end
