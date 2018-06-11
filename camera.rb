require_relative 'component'
require_relative 'gameobject'

class Camera < Component
  #rendering layer? per filtrare solo determinati oggetti?
  attr_accessor :size
  def initialize(size = 1)
    super()
    @size = size
    Belva2D.SetCamera(self)
  end

end
