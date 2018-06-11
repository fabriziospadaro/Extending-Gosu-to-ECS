require_relative 'behaviour'

class FollowCamera < Behaviour

  def initialize()
    super
      @startpos = Vector2D.zero
  end

  def update
    if(@startpos ==  Vector2D.zero && GameObject.Find("Game Camera") != nil)
     @startpos = GameObject.Find("Game Camera").position
    end

    gameobject.position = Vector2D.new(GameObject.Find("Game Camera").position.x - @startpos.x + 120,0)
  end
end
