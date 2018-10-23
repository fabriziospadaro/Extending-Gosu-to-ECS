require_relative "color"
require_relative "screen"
require_relative "frame_time"
class ControllerSystem < System
	attr_accessor :direction
	def start
		@transform = @entity.get_component(TransformComponent)
		@direction = Point.zero
	end

	def update
		@transform.position += @direction * FrameTime.delta_time
	end
end