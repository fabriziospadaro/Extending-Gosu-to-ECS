require_relative 'belva2d'

#define the game
game = Belva2D.new(640,480,"First Game")
#-------------------------------------------------------


GameObject.SetGameReference(game)

#put game logic there

test_object = GameObject.new("Snake",Vector2D.new(200,200),Vector2D.one,90,Sprite.new("images1.jpg",128))
test_object.AddComponent(TestBH.new)


test_object2 = GameObject.new("Camera",Vector2D.new(0,0),Vector2D.zero,0,Camera.new(1))
test_object2.AddComponent(Scripting.new)


game.Instantiate([test_object2,test_object])

#test_object.RemoveComponent(test_object.GetComponent(:Sprite))




#end the game logic
#--------------------------------------------------------
game.show
#run the game

