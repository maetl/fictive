require 'spec_helper'

describe Fictive::Text::Compiler do
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
