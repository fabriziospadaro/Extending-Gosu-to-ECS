require 'gosu'
require_relative 'gameobject'
require_relative 'vector2d'
require_relative 'sprite'
require_relative 'behaviour'
require_relative 'component.rb'
require_relative 'camera'
require_relative 'frame_time'
#put there additionl component

require_relative 'test_behaviour.rb'

require 'pry'

#aggiungere il camera component che n pratica crea un offsett delle posizioni di tutti gli oggetti
#gestire gli input

class Belva2D < Gosu::Window
  @@game_reference
  attr_accessor :camera, :active_object_list, :deactive_object_list
  attr_reader :game_reference
  def initialize(width,height,app_name)
    super width, height
    @width = width
    @height = height

    self.caption = app_name
    @active_object_list = []
    @deactive_object_list = []
    @camera = nil
    @@game_reference = self
    @time = FrameTime.new()
    return self
  end

  def self.Reference
    return @@game_reference
  end

  def update
    @time.update

    @active_object_list.each do |object| behaviours = object.GetComponent(:Behaviour)
      behaviours.each { |behaviour| behaviour.update } if behaviours
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

            cameraOffSet_position = object.position - (Vector2D.new(-@width/2,-@height/2)-cameraOffSet_position)
            cameraOffSet_angle += object.angle

            scale_in_pixel = ((object.scale * component.pixel_per_unit)/1000.to_f) * (cameraOffSet_scale*cameraOffSet_scale)
            component.sprite.draw_rot(cameraOffSet_position.x,cameraOffSet_position.y,component.layer,cameraOffSet_angle,0.5,0.5,scale_in_pixel.x,scale_in_pixel.y,component.color)
          end
        end
      end
  end

  def self.SetCamera(camera)
    @@game_reference.camera = camera
  end
  def self.ActiveObjectPool
    @@game_reference.active_object_list
  end

  def self.DeActiveObjectPool
    @@game_reference.deactive_object_list
  end

  def self.Instantiate(go,position = Vector2D.zero)
      #deve creare una nuova istanza dell oggetto passato
      #per poi ritornarlo alla fine
      new_instance = go.dup

      upper_bound = new_instance.components.size
      upper_bound = 1 if (new_instance.components.size == 1)
      for i in 0...upper_bound
          if (new_instance.components[i].keys[0] != :Behaviour)
            new_instance.components[i].values[0].SetOwner(new_instance)
          else
          upper_bound2 = new_instance.components[i].values[0].size
          upper_bound2 = 2 if (new_instance.components[i].values[0].size == 1)
          for b in 0...upper_bound2
            new_instance.components[i].values[0][b].SetOwner(new_instance) if new_instance.components[i].values[0][b] != nil
          end
        end
      end

      @@game_reference.active_object_list << new_instance
      if(position != Vector2D.zero)
        new_instance.position = position
      end

      return new_instance
  end

  def self.Destroy(go)
    @@game_reference.deactive_object_list.delete(go)
  end

  def self.Disable(go)
    @@game_reference.active_object_list.delete(go)
    @@game_reference.deactive_object_list << go
  end

  def self.Enable(go)
    @@game_reference.active_object_list << go
    @@game_reference.deactive_object_list.delete(go)
  end

end


