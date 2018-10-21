require_relative 'fab_2d'

#define the game
game = Fab2D.new(640,480,"First Game")
#-------------------------------------------------------

player = Entity.new()

player.add_component(TransformComponent).set(position: Point::Data.new(0,0))
player.add_component(SpriteComponent).set(path: "ball.png",layer: 1).load_sprite
player.add_system(SpriteRenderSystem)

Fab2D.ecs.add_entity(player)
#end the game logic
#--------------------------------------------------------
game.show
#run the game

