class Behaviour
  attr_accessor :gameobject
  def initialize()
    @gameobject = nil
    start
  end
  def SetOwner(go)
    @gameobject = go
  end
  #called at the start of the initialaiaztion
  def start
  end
  #called once per frame
  def update
  end
end
