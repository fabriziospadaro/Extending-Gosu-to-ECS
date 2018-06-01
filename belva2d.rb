require 'gosu'
require_relative 'gameobject'
require_relative 'vector2d'
require_relative 'sprite_component'
require_relative 'behaviour'
require_relative 'testbh.rb'
require 'pry'

class Belva2D < Gosu::Window
  attr_accessor :object_list

  def initialize(width,height,app_name)
    super width, height
    self.caption = app_name
    @object_list = []
    self
  end

  def update
    object_list.each do |object|
      if(object.GetComponent(:Behaviour))
        object.GetComponent(:Behaviour).update()
      end
    end
  end

  def draw
      object_list.each do |object|
        object.components.each do |component_hash|
          component = component_hash.values[0]
          component_type = component_hash.keys[0]

          if(component_type == :Sprite)
            scale_in_pixel = (object.scale * component.pixel_per_unit)/1000.001
            component.sprite.draw(object.position.x,object.position.y,component.layer,scale_in_pixel.x,scale_in_pixel.y,component.color)
          end
        end
      end
  end

  def Instantiate(go)
    @object_list << go
  end

end


