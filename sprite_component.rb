require_relative 'component'

class SpriteComponent < Component
  
  attr_accessor :path, :layer
  attr_reader :sprite

  def start
  	@path = nil
  	@layer = 0
  end

  def load_sprite
    @sprite = Gosu::Image.new(@path)
  end
end
