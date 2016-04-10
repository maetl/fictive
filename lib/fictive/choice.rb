module Fictive
  class Choice
    def initialize(metadata)
      @metadata = metadata
    end

    def path
      @metadata.fetch(:path)
    end
  end
end
