require_relative 'belva2d'

class Component
  attr_reader :gameobject,:unique_id
  attr_accessor :enable
  def initialize()
    @gameobject = nil
    @enable = true
    @unique_id = self.object_id
  end
  def SetOwner(go)
    @gameobject = go
  end

end
