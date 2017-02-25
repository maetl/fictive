module Fictive
  class Bundle
    def self.import(path, options={})
      bundle_path = Pathname.new(path)

      if bundle_path.directory?
        files = bundle_path.children.select { |file| file.extname == '.txt' }
      elsif bundle_path.exist?
        files = [bundle_path] if bundle_path.extname == '.txt'
      else
        # File not found
      end

      self.new(files)
    end

    attr_reader :documents

    def initialize(files)
      @documents = files.map { |file| Document.new(file.read) }.freeze
    end
  end
end
