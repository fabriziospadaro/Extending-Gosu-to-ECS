require_relative 'fab_2d'

#define the game
game = Fab2D.new(640,480,"First Game")
#-------------------------------------------------------

player = Entity.configure do |entity|
	entity.add_component(TransformComponent, {position: Point::Data.new(0,0)})
	entity.add_component(SpriteComponent, {path: "ball.png",layer: 1})
	entity.add_system(SpriteRenderSystem)
	entity.add_system(ControllerSystem)
end

500.times do
	Fab2D.ecs.add_entity(player).get_system(ControllerSystem).set(direction: Point.random*4)
end
#--------------------------------------------------------
game.show
#run the game

