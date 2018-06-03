require_relative 'behaviour'

class Scripting < Behaviour

  def initialize()
    super
  end

  def start
    puts "Object created"
  end

  def update
    if Gosu.button_down? Gosu::KB_D
       gameobject.position += Vector2D.right
    end
    if Gosu.button_down? Gosu::KB_A
       gameobject.position -= Vector2D.right
    end
    if Gosu.button_down? Gosu::KB_W
       gameobject.GetComponent(:Camera).size += 0.01
    end
    if Gosu.button_down? Gosu::KB_S
       gameobject.GetComponent(:Camera).size -= 0.01
    end
  end
end
