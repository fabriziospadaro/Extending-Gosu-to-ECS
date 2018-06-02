require 'gosu'
require_relative 'gameobject'
require_relative 'vector2d'
require_relative 'sprite'
require_relative 'behaviour'
require_relative 'testbh.rb'
require_relative 'component.rb'
require_relative 'scripting'
require 'pry'

class Belva2D < Gosu::Window

  def initialize(width,height,app_name)
    super width, height
    self.caption = app_name
    @active_object_list = []
    @deactive_object_list = []
    self
  end

  def update
    @active_object_list.each do |object|
      behaviours = object.GetComponent(:Behaviour)

      behaviours.each { |behaviour| behaviour.update() } if behaviours
    end
  end

  def draw
      @active_object_list.each do |object|
        object.components.each do |component_hash|
          component = component_hash.values[0]
          component_type = component_hash.keys[0]

          if(component_type == :Sprite)
            scale_in_pixel = (object.scale * component.pixel_per_unit)/1000.001
            component.sprite.draw_rot(object.position.x,object.position.y,component.layer,object.angle,0.5,0.5,scale_in_pixel.x,scale_in_pixel.y,component.color)
          end
        end
      end
  end

  def ActiveObjectPool
    return @active_object_list
  end

  def DeActiveObjectPool
    return @deactive_object_list
  end

  def Instantiate(go)
    @active_object_list << go
  end

  def Destroy(go)
    @deactive_object_list.delete(go)
  end

  def Disable(go)
    @active_object_list.delete(go)
    @deactive_object_list << go
  end

  def Enable(go)
    @active_object_list << go
    @deactive_object_list.delete(go)
  end

end


