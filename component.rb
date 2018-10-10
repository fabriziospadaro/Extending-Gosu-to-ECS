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
  def destroy(obj)
    if(obj.class == self.class)
      @gameobject.components.delete!(obj)
    else  
      Belva2D.destroy(@gameobject)
    end
  end
end
