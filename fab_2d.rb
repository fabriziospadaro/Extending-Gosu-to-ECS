require 'gosu'
require_relative 'point'
require_relative 'ecs_manager'

require_relative 'frame_time'
require_relative 'color'
require_relative 'screen'

require_relative "entity"
require_relative "component"
require_relative "system"

require_relative "sprite_component"
require_relative "transform_component"
require_relative "sprite_render_system"
require_relative "controller_system"
require_relative "input"
#put there additionl component
require 'pry'

class Fab2D < Gosu::Window
  @@game_reference
  attr_reader :ecs_manager, :width, :height
  def initialize(width,height,app_name)
    super width, height
    @width = width
    @height = height

    self.caption = app_name

    @@game_reference = self
    @ecs_manager = ECSManager.new()
    @time = FrameTime.new()
    return self
  end

  def self.instance
    return @@game_reference 
  end

  def self.ecs
    return @@game_reference.ecs_manager
  end

  def update
    @time.update
    @ecs_manager.update
  end

  def draw
    @ecs_manager.draw
  end
end


