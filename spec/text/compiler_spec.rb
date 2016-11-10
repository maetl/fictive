require 'spec_helper'

describe Fictive::Text::Compiler do

  describe '#process' do
    it 'should evaluate node from literal text' do
      node = Fictive::Text::Compiler.new("literal text").process
      expect(node.evaluate).to eq("literal text")
    end

    it 'should evaluate text substitution with concatenation' do
      node = Fictive::Text::Compiler.new("Hello {world}.").process(world: "World")
      expect(node.evaluate).to eq("Hello World.")
    end

    it 'should evaluate text substitution over whole string' do
      node = Fictive::Text::Compiler.new("{world}").process(world: "Hello World.")
      expect(node.evaluate).to eq("Hello World.")
    end

    it 'should evaluate multiple text substitutions with concatenation' do
      compiler = Fictive::Text::Compiler.new("{ hello } {world}.")
      node = compiler.process(hello: "Hello", world: "World")
      expect(node.evaluate).to eq("Hello World.")
    end

    it 'should evaluate conditional node from directive' do
      node = Fictive::Text::Compiler.new("[if true: hello]").process
      expect(node.evaluate).to eq("hello")
    end

    it 'should concatenate conditional node from directive' do
      node = Fictive::Text::Compiler.new("Colorless [if true: green ideas.]").process
      expect(node.evaluate).to eq("Colorless green ideas.")
    end

    it 'should concatenate head and tails around conditional node from directive' do
      node = Fictive::Text::Compiler.new("Colorless [if true: green ideas] sleep furiously.").process
      expect(node.evaluate).to eq("Colorless green ideas sleep furiously.")
    end

    xit 'should evaluate a substitution inside a conditional directive' do
      compiler = Fictive::Text::Compiler.new("Colorless [if true: {colored} ideas] sleep furiously.")
      node = compiler.process(colored: "green")
      expect(node.evaluate).to eq("Colorless green ideas sleep furiously.")
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
