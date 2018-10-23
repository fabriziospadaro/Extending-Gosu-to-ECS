require_relative "color"
require_relative "screen"
class SpriteRenderSystem < System
		
	def start
		@sprite_component = @entity.get_component(SpriteComponent)
		@transform = @entity.get_component(TransformComponent)
		@color = Color.white
	end

	def draw
		#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
		scale_in_pixel = ((@transform.scale * @sprite_component.pixel_per_unit)/1000.to_f)
		#y position is flipped
		position_offset = Point::Data.new(Screen.width,Screen.height)/2 + Point::Data.new(@transform.position.x,-@transform.position.y)
		@sprite_component.sprite.draw_rot(position_offset.x,position_offset.y,@sprite_component.layer,@transform.rotation,0.5,0.5,scale_in_pixel.x,scale_in_pixel.y,@color)
	end
end
