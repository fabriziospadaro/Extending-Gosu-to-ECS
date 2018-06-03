require 'gosu'
require_relative 'gameobject'
require_relative 'vector2d'
require_relative 'sprite'
require_relative 'behaviour'
require_relative 'testbh.rb'
require_relative 'component.rb'
require_relative 'scripting'
require_relative 'camera'
require 'pry'

#aggiungere il camera component che n pratica crea un offsett delle posizioni di tutti gli oggetti
#gestire gli input

class Belva2D < Gosu::Window

  def initialize(width,height,app_name)
    super width, height
    self.caption = app_name
    @active_object_list = []
    @deactive_object_list = []
    @camera = nil
    self
  end

  def update
    @active_object_list.each do |object|
      behaviours = object.GetComponent(:Behaviour)

      behaviours.each { |behaviour| behaviour.update() if behaviour.enable } if behaviours
    end
  end

  def draw
      @active_object_list.each do |object|
        object.components.each do |component_hash|
          component = component_hash.values[0]
          component_type = component_hash.keys[0]

          if(component_type == :Sprite)
            cameraOffSet_position = @camera != nil ? @camera.gameobject.position : Vector2D.zero
            cameraOffSet_angle = @camera != nil ? @camera.gameobject.angle : 0
            cameraOffSet_scale = @camera != nil ? @camera.size : 1

            cameraOffSet_position = object.position - cameraOffSet_position
            cameraOffSet_angle += object.angle

            scale_in_pixel = ((object.scale * component.pixel_per_unit)/1000.to_f) * (cameraOffSet_scale*cameraOffSet_scale)
            component.sprite.draw_rot(cameraOffSet_position.x,cameraOffSet_position.y,component.layer,cameraOffSet_angle,0.5,0.5,scale_in_pixel.x,scale_in_pixel.y,component.color)
          end
        end
      end
  end

  def SetCamera(camera)
    @camera = camera
  end
  def ActiveObjectPool
    return @active_object_list
  end

  def DeActiveObjectPool
    return @deactive_object_list
  end

  def Instantiate(go)
    if(go.class != Array)
      @active_object_list << go
    else
      go.each { |obj| @active_object_list << obj}
    end
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


