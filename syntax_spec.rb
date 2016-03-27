require './syntax'

describe Syntax do
  describe '#parse' do
    def parser_test_case(case_id)
      Syntax::Parser.new(File.read("./spec/cases/#{case_id}.txt"))
    end

    it 'parses single paragraph' do
      parser = parser_test_case(1)
      expect(parser.parse.children.first.type).to eq(:paragraph)
      expect(parser.parse.children.first.text).to eq('Hello world.')
    end

    it 'parses multiple paragraphs' do
      parser = parser_test_case(2)
      expect(parser.parse.children.first.type).to eq(:paragraph)
      expect(parser.parse.children.first.text).to eq('Hello world.')
      expect(parser.parse.children.last.type).to eq(:paragraph)
      expect(parser.parse.children.last.text).to eq('Goodbye world.')
    end

    it 'parses an id heading' do
      parser = parser_test_case(3)
      expect(parser.parse.children.first.type).to eq(:header)
      expect(parser.parse.children.first.text).to eq('hello')
      expect(parser.parse.children.last.type).to eq(:paragraph)
      expect(parser.parse.children.last.text).to eq('Hello world.')
    end
  end
end
