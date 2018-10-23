require_relative 'component'

class SpriteComponent < Component
  
  attr_accessor :path, :layer, :pixel_per_unit
  attr_reader :sprite

  def start
  	@path = nil
  	@layer = 0
  	@pixel_per_unit = 64
  end

  def solve_dependency
    load_sprite
  end
  
  def load_sprite
    @sprite = Gosu::Image.new(@path)
  end
end
