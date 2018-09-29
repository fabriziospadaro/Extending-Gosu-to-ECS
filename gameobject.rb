class GameObject

  attr_accessor :position, :scale, :angle, :components, :name, :tag
  attr_reader :enabled

  def deep_clone
    new_obj = GameObject.new(self.name,self.position,self.scale,self.tag,self.angle)
    self.components.each do |component_hash|
      if (component_hash.keys[0] != :Behaviour)
        new_obj.AddComponent(component_hash.values[0].dup.deep_clone)
      else
        upper_bound2 = component_hash.values[0].size
        upper_bound2 = 2 if (component_hash.values[0].size == 1)
        for b in 0...upper_bound2
          if(component_hash.values[0][b] != nil)
            new_obj.AddComponent(component_hash.values[0][b].dup.deep_clone)
          end
        end
      end
    end
    return new_obj
  end


  def initialize(name, position = Vector2D.zero, scale = Vector2D.one,tag = "default" ,angle = 0)
    #transform of the object
    @position = position
    @scale = scale
    @angle = angle
    @tag = tag
    @name = name

    @components = []
    @enabled = true
  end

  def AddComponent(new_component)
    new_component.SetOwner(self)
    if(new_component.class.superclass.to_s == "Behaviour")
      #controlla se non esistono behavuoir se non esistono crea la hash
      #se esiste aggiungi dentro l'array value dell hash con chiave behaviour il component
      @components.each_with_index do |cmp_hash,i|
        if(cmp_hash.keys[0] == :Behaviour)
          @components[i][:Behaviour] << new_component
          return new_component
        else
          @components << {Behaviour: [new_component]}
          return new_component
        end
      end
      @components << {Behaviour: [new_component]}
    else
      @components << {new_component.class.to_s.to_sym => new_component}
    end
    return new_component
  end

  def GetComponent(symbol)
    #decidi se quando  chiami get component ritorna solo se sono attivati
    @components.each do |cmp_hash|
      if(symbol != :Behaviour && cmp_hash.keys[0] != :Behaviour)
        return cmp_hash.values[0] if cmp_hash.keys[0] == symbol
      else
        if(cmp_hash.keys[0] == symbol)
          return cmp_hash.values[0]
        elsif cmp_hash.values[0].class == Array
          cmp_hash.values[0].each { |component| return component if component.class.to_s == symbol.to_s}
        end
      end
    end
    return false
  end

  def RemoveComponent(instance)
    @components.each_with_index do |cmp_hash,index|
      if(cmp_hash.keys[0] == :Behaviour)
        cmp_hash.values[0].each do |component|
          if(component == instance)
            @components[index][:Behaviour].delete(component)
            return self
          end
        end
      elsif(cmp_hash.values[0] == instance)
        @components.delete_at(index)
        return self
      end
    end
  end

  def SetActive(flag)
    return self if flag == self

    if(!flag)
      Belva2D.Disable(self)
    else
      Belva2D.enabled(self)
    end
    @enabled = flag
    return self
  end

  def SetTag(tag)
    @tag = tag
    return self
  end

  def self.FindObjectOfType(component)
    Belva2D.ActiveObjectPool.each do |obj|
      return obj.GetComponent(component) if obj.GetComponent(component) != false
    end
    return false
  end

  def self.FindObjectsOfType(component)
    obj_list = []
    Belva2D.ActiveObjectPool.each do |obj|
      obj_list << obj.GetComponent(component) if obj.GetComponent(component) != false
    end
    return obj_list.size > 0 ? obj_list : false
  end

  def self.FindObjectsOfTag(tag)
    obj_list = []
    Belva2D.ActiveObjectPool.each do |obj|
      obj_list << obj if obj.tag == tag
    end
    return obj_list.size > 0 ? obj_list : false
  end

  def self.Find(name)
    Belva2D.ActiveObjectPool.each do |obj|
      return obj if obj.name == name
    end
    return false
  end
end
