require_relative 'behaviour'

class TestBH < Behaviour

  def initialize()
    super
  end

  def start
    puts "Object created"
  end

  def update
    gameobject.position += Vector2D.right/2.to_f
  end
end
