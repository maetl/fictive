require 'spec_helper'

describe Fictive::Bundle do
  describe '#import' do
    it 'imports a bundle from a single file' do
      bundle = Fictive::Bundle.import('./spec/bundle/1.txt')

      expect(bundle).to be_a(Fictive::Bundle)
      expect(bundle.documents.count).to eq(1)
    end

    it 'imports a bundle from a directory' do
      bundle = Fictive::Bundle.import('./spec/bundle/')

      expect(bundle).to be_a(Fictive::Bundle)
      expect(bundle.documents.count).to eq(3)
    end
  end

  describe '#new' do
    it 'constructs a bundle from a list of files' do
      bundle = Fictive::Bundle.new([
        Pathname.new('./spec/bundle/1.txt'),
        Pathname.new('./spec/bundle/2.txt')
      ])

      expect(bundle).to be_a(Fictive::Bundle)
      expect(bundle.documents.count).to eq(2)
      expect(bundle.passages.count).to eq(2)
    end
  end
end
