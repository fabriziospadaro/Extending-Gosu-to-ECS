require_relative 'behaviour'

class Scripting < Behaviour

  def initialize()
    super
  end

  def start
    puts "Object created"
  end

  def update
    puts "Object updating 2 "
    gameobject.position -= Vector2D.up
  end
end
