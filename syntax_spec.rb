require './syntax'

describe Syntax do
  describe '#parse' do
    def parser_test_case(case_id)
      Syntax::Parser.new(File.read("./spec/cases/#{case_id}.txt"))
    end

    it 'parses single paragraph' do
      parser = parser_test_case(1)
      expect(parser.parse.children.first.content).to eq('Hello world.')
    end

    it 'parses multiple paragraphs' do
      parser = parser_test_case(2)
      expect(parser.parse.children.first.content).to eq('Hello world.')
      expect(parser.parse.children.last.content).to eq('Goodbye world.')
    end
  end
end
