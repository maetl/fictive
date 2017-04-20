require 'spec_helper'

describe Fictive::Syntax do
  describe '#parse' do
    def parse_document(case_id)
      parser = Fictive::Syntax::Parser.new(File.read("./spec/cases/#{case_id}.txt"))
      parser.parse
    end

    specify 'single_paragraph' do |spec|
      document = parse_document(spec.description)
      expect(document.children.first.type).to eq(:paragraph)
      expect(document.children.first.text).to eq('Hello world.')
    end

    specify 'multiple_paragraphs' do |spec|
      document = parse_document(spec.description)
      expect(document.children.first.type).to eq(:paragraph)
      expect(document.children.first.text).to eq('Hello world.')
      expect(document.children.last.type).to eq(:paragraph)
      expect(document.children.last.text).to eq('Goodbye world.')
    end

    specify 'id_heading' do |spec|
      document = parse_document(spec.description)
      expect(document.children.first.type).to eq(:id)
      expect(document.children.first.text).to eq('hello')
      expect(document.children.last.type).to eq(:paragraph)
      expect(document.children.last.text).to eq('Hello world.')
    end

    specify 'multiple_heading_levels' do |spec|
      document = parse_document(spec.description)
      expect(document.children[0].type).to eq(:h1)
      expect(document.children[0].text).to eq('Heading 1')
      expect(document.children[2].type).to eq(:h2)
      expect(document.children[2].text).to eq('Heading 2')
      expect(document.children[4].type).to eq(:h3)
      expect(document.children[4].text).to eq('Heading 3')
    end

    specify 'list_items' do |spec|
      document = parse_document(spec.description)
      expect(document.children[0].type).to eq(:paragraph)
      expect(document.children[0].text).to eq('This is a paragraph.')
      expect(document.children[2].type).to eq(:list_item)
      expect(document.children[2].text).to eq('This is a list item')
      expect(document.children[3].type).to eq(:list_item)
      expect(document.children[3].text).to eq('This is also a list item')
    end

    specify 'multiline_paragraph' do |spec|
      document = parse_document(spec.description)
      expect(document.children.first.type).to eq(:paragraph)
      expect(document.children.first.text).to eq('This is a paragraph which breaks over multiple lines.')
      expect(document.children.first.type).to eq(:paragraph)
      expect(document.children.last.text).to eq('This is also a paragraph which breaks over multiple lines.')
    end

    specify 'multiple_passages' do |spec|
      document = parse_document(spec.description)
      children = document.children.reject { |el| el.type == :blank_line }
      expect(children[0].type).to eq(:paragraph)
      expect(children[1].type).to eq(:paragraph)
      expect(children[2].type).to eq(:passage_break)
      expect(children[3].type).to eq(:paragraph)
      expect(children[4].type).to eq(:paragraph)
      expect(children[5].type).to eq(:passage_break)
      expect(children[6].type).to eq(:paragraph)
    end
  end
end
