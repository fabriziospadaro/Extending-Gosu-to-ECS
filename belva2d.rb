require 'gosu'
require_relative 'gameobject'
require_relative 'vector2d'
require_relative 'sprite'
require_relative 'behaviour'
require_relative 'component.rb'
require_relative 'camera'
require_relative 'frame_time'
require_relative 'color'
require_relative 'screen'
require_relative 'transform'
#put there additionl component
require_relative 'platform_controller.rb'
require 'pry'

#fixare il fatto che i component devono essere dumpati prima di essere instanziati con un go
#dubbio ARDUO.... CREARE UN'OGGETTO OGNI VOLTA CHE VIENE FATTO GAMEOBJECT.NEW? E SE POI SI VUOLE ISTANZIARE UNA COPIA DI QUEL GO BISOGNA UASRE ISTANZIATE?
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
    if(Input.key_down?(Gosu::KB_P))
      binding.pry
    end
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
          cameraOffSet_position = @camera != nil ? @camera.transform.position : Vector2D.zero
          cameraOffSet_angle = @camera != nil ? @camera.transform.angle : 0
          cameraOffSet_scale = @camera != nil ? @camera.size : 1

          cameraOffSet_position = object.transform.position - (Vector2D.new(-@width/2,-@height/2)-cameraOffSet_position)
          cameraOffSet_angle += object.transform.angle

          scale_in_pixel = ((object.transform.scale * component.pixel_per_unit)/1000.to_f) * (cameraOffSet_scale*cameraOffSet_scale)
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

  def self.Instantiate(gos,position = Vector2D.zero)
      #deve creare una nuova istanza dell oggetto passato
      #per poi ritornarlo alla fine
      new_list = []
      gos.each do |go|
        new_instance = go.dup.deep_clone
        #start the components
        new_instance.components.each do |component_hash|
          if (component_hash.keys[0] == :Behaviour)
            upper_bound2 = component_hash.values[0].size
            upper_bound2 = 2 if (component_hash.values[0].size == 1)
            for b in 0...upper_bound2
              if(component_hash.values[0][b] != nil)
                component_hash.values[0][b].start
              end
            end
          end
        end
        @@game_reference.active_object_list << new_instance
        if(position != Vector2D.zero)
          new_instance.position = position
        end

        new_list << new_instance
      end

      return new_list
    end

    def self.Destroy(go)
      if(@@game_reference.active_object_list.include?(go))        
        @@game_reference.active_object_list.delete(go)
      else
        @@game_reference.deactive_object_list.delete(go)
      end
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


