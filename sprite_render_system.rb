require_relative "color"
class SpriteRenderSystem < System
		
	def start
		@sprite_component = @entity.get_component(SpriteComponent)
		@transform = @entity.get_component(TransformComponent)
	end

	def draw
		#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
		@sprite_component.sprite.draw_rot(@transform.position.x,@transform.position.x,@sprite_component.layer,@transform.rotation,0.5,0.5,@transform.scale.x,@transform.scale.y,Color.white)
	end
end
