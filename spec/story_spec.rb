require 'spec_helper'

describe Fictive::Story do
  let(:story) do
    Fictive::Story.demo
  end

  specify '#has_next?' do
    expect(story.has_next?).to be true
  end

  specify '#next' do
    passage = story.next
    expect(passage.path).to eq('hello')
    expect(passage.choices.count).to eq(1)
  end

  specify '#choose_path' do
    path = story.next.choices.first.path
    story.choose_path(path)
    expect(story.next.path).to eq('goodbye')
    expect(story.has_next?).to be false
  end
end
