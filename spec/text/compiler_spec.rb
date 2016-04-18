require 'spec_helper'

describe Fictive::Text::Compiler do

  describe '#process' do
    it 'should evaluate node from literal text' do
      node = Fictive::Text::Compiler.new("literal text").process
      expect(node.evaluate).to eq("literal text")
    end

    it 'should evaluate conditional node from directive' do
      node = Fictive::Text::Compiler.new("*if true: hello*").process
      expect(node.evaluate).to eq("hello")
    end

    it 'should concatenate conditional node from directive' do
      node = Fictive::Text::Compiler.new("Colorless *if true: green ideas.*").process
      expect(node.evaluate).to eq("Colorless green ideas.")
    end
  end

  specify Fictive::Text::TextNode do
    expr = Fictive::Text::TextNode.new("literal")
    expect(expr.evaluate).to eq("literal")
  end

  specify Fictive::Text::Node do
    expr = Fictive::Text::Node.new(
      Fictive::Text::TextNode.new("concatenate"),
      Fictive::Text::TextNode.new(" "),
      Fictive::Text::TextNode.new("literal text")
    )
    expect(expr.evaluate).to eq("concatenate literal text")
  end

  specify Fictive::Text::ConditionalNode do
    expr = Fictive::Text::Node.new(
      Fictive::Text::ConditionalNode.new(
        Fictive::Text::ExpressionNode.new(
          Fictive::Text::TrueNode.new
        ),
        Fictive::Text::TextNode.new("should display")
      )
    )
    expect(expr.evaluate).to eq("should display")
  end

  specify Fictive::Text::ConditionalNode do
    expr = Fictive::Text::Node.new(
      Fictive::Text::ConditionalNode.new(
        Fictive::Text::ExpressionNode.new(
          Fictive::Text::FalseNode.new
        ),
        Fictive::Text::TextNode.new("should display")
      )
    )
    expect(expr.evaluate).to eq("")
  end
end
