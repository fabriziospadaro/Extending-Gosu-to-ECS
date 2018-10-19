require_relative 'behaviour'

class PlatformController < Behaviour

  def initialize()
    super
  end

  def start

  end

  def update
  	@gameobject.transform.position.x += FrameTime.deltaTime*2
  	@gameobject.transform.angle += FrameTime.deltaTime*5
  end
end
