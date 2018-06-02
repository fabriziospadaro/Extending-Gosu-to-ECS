require_relative 'component'

class Sprite < Component
  attr_reader :sprite, :color, :pixel_per_unit
  attr_accessor :layer

  def initialize(img_path,pixel_per_unit,layer=0)
    super()
    @sprite = Gosu::Image.new(img_path)
    @color = Gosu::Color.argb(0xff_ffffff)
    @pixel_per_unit = pixel_per_unit
    @layer = layer
  end

  def set_color(r,g,b,a)
    @color = Gosu::Color.rgb(r,g,b,a)
  end

  def set_sprite(img_path)
    @sprite = Gosu::Image.new(img_path)
  end

end
