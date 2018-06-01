require_relative 'behaviour'

class TestBH < Behaviour

  def initialize()
    super
  end

  def start
    puts "Object created"
  end

  def update
    puts "Object updating"
    gameobject.position += Vector2D.right
  end
end
