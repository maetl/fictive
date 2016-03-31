require 'spec_helper'

describe Fictive::Syntax do
  describe '#parse' do
    def parser_test_case(case_id)
      Fictive::Syntax::Parser.new(File.read("./spec/cases/#{case_id}.txt"))
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
      expect(parser.parse.children.first.type).to eq(:id)
      expect(parser.parse.children.first.text).to eq('hello')
      expect(parser.parse.children.last.type).to eq(:paragraph)
      expect(parser.parse.children.last.text).to eq('Hello world.')
    end

    it 'parses multiple heading levels' do
      parser = parser_test_case(4)
      expect(parser.parse.children[0].type).to eq(:h1)
      expect(parser.parse.children[0].text).to eq('Heading 1')
      expect(parser.parse.children[2].type).to eq(:h2)
      expect(parser.parse.children[2].text).to eq('Heading 2')
      expect(parser.parse.children[4].type).to eq(:h3)
      expect(parser.parse.children[4].text).to eq('Heading 3')
    end

    it 'parses list items' do
      parser = parser_test_case(5)
      expect(parser.parse.children[0].type).to eq(:paragraph)
      expect(parser.parse.children[0].text).to eq('This is a paragraph.')
      expect(parser.parse.children[2].type).to eq(:list_item)
      expect(parser.parse.children[2].text).to eq('This is a list item')
      expect(parser.parse.children[3].type).to eq(:list_item)
      expect(parser.parse.children[3].text).to eq('This is also a list item')
    end
  end
end
