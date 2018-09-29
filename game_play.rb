require_relative 'behaviour'

class GamePlay < Behaviour
  attr_reader :food_prefab
  def initialize()
    super
    @direction = Vector2D.right
    @food_prefab
  end

  def start
    @food_prefab = GameObject.new("Block")
    @food_prefab.AddComponent(Sprite.new("block.png"))
    SpawnFood()
  end

  def update
  end

  def SpawnBlock(position)
    Belva2D.Instantiate([@food_prefab],position)[0].SetTag("Block")
  end
end
