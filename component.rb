class Component
  attr_reader :gameobject, :unique_id
  attr_accessor :enable

  def initialize()
    @gameobject = nil
    @transform = nil
    @enable = true
    @unique_id = self.object_id
  end
  
  def SetOwner(go)
    @gameobject = go
    @transform = go.transform
  end
  
  def destroy!()
    @gameobject.DeleteComponent(self)
  end

  def ==(b)
    return @unique_id == b&.unique_id
  end

end
