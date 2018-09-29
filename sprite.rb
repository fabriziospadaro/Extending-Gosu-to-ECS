require_relative 'component'

class Sprite < Component
  attr_reader :sprite, :color, :pixel_per_unit,:img_path
  attr_accessor :layer

  def initialize(img_path,pixel_per_unit=64,layer=0,color=Color.white)
    super()
    @img_path = img_path
    @sprite = Gosu::Image.new(img_path)
    @color = color
    @pixel_per_unit = pixel_per_unit
    @layer = layer
  end

  def set_color(color)
    @color = color
  end

  def set_sprite(img_path)
    @sprite = Gosu::Image.new(img_path)
  end

  def deep_clone
    return Sprite.new(self.img_path,self.pixel_per_unit,self.layer,self.color)
  end

end
