require_relative 'belva2d'

#define the game
game = Belva2D.new(640,480,"First Game")
#-------------------------------------------------------


GameObject.SetGameReference(game)

#put game logic there
test_object = GameObject.new("Snake",Vector2D.new(200,200),Vector2D.one,90)
game.Instantiate(test_object)
test_object.AddComponent(TestBH.new)
test_object.AddComponent(Scripting.new)
test_object.AddComponent(Sprite.new("images1.jpg",128))
#test_object.RemoveComponent(test_object.GetComponent(:Sprite))
#puts GameObject.FindObjectOfType(:TestBH)




#end the game logic
#--------------------------------------------------------
game.show
#run the game

