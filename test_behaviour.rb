require_relative 'behaviour'

class TestBehaviour < Behaviour

  def initialize()
    super
  end

  def start
    p Belva2D.Reference.methods
  end

  def update

  end
end
