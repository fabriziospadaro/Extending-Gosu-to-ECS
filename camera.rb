require_relative 'component'

class Camera < Component
  #rendering layer? per filtrare solo determinati oggetti?
  attr_accessor :size
  def initialize(size = 1)
    super()
    @size = size
    Belva2D.SetCamera(self)
  end

  def deep_clone
    super()
    return Camera.new(self.size)
  end

end
