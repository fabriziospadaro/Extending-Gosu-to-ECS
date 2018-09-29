require_relative 'behaviour'

class BodyPart < Behaviour
  def initialize()
    super
    @child = nil
  end

  def start
  end

  def update
    if(@child)
      @gameobject.position = Vector2D.Learp(@gameobject.position,@child.position,FrameTime.deltaTime/2)
    end
  end

  def setChild(obj)
    @child = obj
    @gameobject.position = @child.position
  end
end
