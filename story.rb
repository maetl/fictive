class Scene
  attr_reader :passage

  def initialize(metadata, passage)
    @metadata = metadata
    @passage = passage
  end

  def path
    @metadata.fetch(:path)
  end

  def choices
    @metadata.fetch(:choices, [])
  end
end

class Choice
  def initialize(metadata)
    @metadata = metadata
  end

  def path
    @metadata.fetch(:path)
  end
end

class Story
  def self.demo
    self.new([
      Scene.new({path: 'hello', choices: [Choice.new({path: 'goodbye'})]}, 'Hello world'),
      Scene.new({path: 'goodbye'}, 'Goodbye world')
    ])
  end

  def initialize(scenes)
    @scenes = scenes
    @scenes_index = {}
    @scenes.each_with_index do |scene, id|
      @scenes_index[scene.path] = id
    end

    @index = 0
  end

  def has_next?
    !@scenes.at(@index).nil? && !@scenes.at(@index + 1).nil?
  end

  def next
    @scenes.at(@index)
  end

  def choose_path(path)
    @index = @scenes_index[path]
  end
end
