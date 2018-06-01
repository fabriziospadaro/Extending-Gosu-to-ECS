require_relative 'belva2d'

#define the game
game = Belva2D.new(640,480,"First Game")
GameObject.SetGameReference(game)

#put game logic there
test_object = GameObject.new("Test GO",Vector2D.new(100,100),Vector2D.one,Sprite.new("images1.jpg",128))
game.Instantiate(test_object)
test_object.AddComponent(TestBH.new)

puts GameObject.FindObjectOfType(:TestBH)
#end the game logic

#run the game
game.show

