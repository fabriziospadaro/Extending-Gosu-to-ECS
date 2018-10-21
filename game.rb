require_relative 'belva2d'

#define the game
game = Belva2D.new(640,480,"First Game")
#-------------------------------------------------------

player = Entity.new()

player.add_component(TransformComponent).set(position: Point::Data.new(0,0))
player.add_component(SpriteComponent).set(path: "Penguin.png",layer: 1).load_sprite
player.add_system(SpriteRenderSystem)

Belva2D.ecs.add_entity(player)
#end the game logic
#--------------------------------------------------------
game.show
#run the game

