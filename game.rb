require_relative 'belva2d'

#define the game
game = Belva2D.new(640,480,"First Game")
#-------------------------------------------------------
#put game logic there
go_list = []
snake = GameObject.new(name: "Platform")
snake.AddComponent(Sprite.new("ball.png"))
snake.AddComponent(PlatformController.new())
#a.destroy!
go_list << snake


Belva2D.Instantiate(go_list)

#end the game logic
#--------------------------------------------------------
game.show
#run the game

