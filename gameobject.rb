require_relative 'belva2d'

class GameObject
  attr_accessor :position, :scale, :angle, :components, :name
  attr_reader :enabled

  @@game_reference

  def initialize(name, position = Vector2D.zero, scale = Vector2D.zero,angle = 0, components = nil)
    #transform of the object
    @position = position
    @scale = scale
    @angle = angle

    @name = name

    @components = []

    @enabled = true

    AddComponent(components) if (components != nil)
  end

  def AddComponent(new_component)
    new_component.SetOwner(self)
    if(new_component.class.superclass.to_s == "Behaviour")
      #controlla se non esistono behavuoir se non esistono crea la hash
      #se esiste aggiungi dentro l'array value dell hash con chiave behaviour il component
      id = 0
      @components.each do |cmp_hash|
        if(cmp_hash.keys[0] == :Behaviour)
          @components[id][:Behaviour] << new_component
          return self
        else
          @components << {Behaviour: [new_component]}
          return self
        end
        id += 1
      end
      @components << {Behaviour: [new_component]}
    else
      case new_component.class.to_s
        when "Sprite"
          @components << {Sprite: new_component}
        when "Sound"
          @components << {Sound: new_component}
      end
    end
    return self
  end

  def GetComponent(symbol)
    @components.each do |cmp_hash|
      if(symbol != :Behaviour && cmp_hash.keys[0] != :Behaviour)
        return cmp_hash.values[0] if cmp_hash.keys[0] == symbol
      else
        if(cmp_hash.keys[0] == symbol)
          return cmp_hash.values[0]
        else
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
    return if flag == self

    if(!flag)
      @@game_reference.Disable(self)
    else
      @@game_reference.enabled(self)
    end
    @enabled = flag
    return self
  end

  def self.FindObjectOfType(component)
    @@game_reference.ActiveObjectPool.each do |obj|
      return obj.GetComponent(component).gameobject if obj.GetComponent(component) != false
    end
    return false
  end

  def self.FindObjectsOfType(component)
    obj_list = []
    @@game_reference.ActiveObjectPool.each do |obj|
      obj_list << obj.GetComponent(component).gameobject if obj.GetComponent(component) != false
    end
    return obj_list.size > 0 ? obj_list : false
  end

  def self.Find(name)
    @@game_reference.ActiveObjectPool.each do |obj|
      return obj if obj.name == name
    end
    return false
  end

  def self.SetGameReference(ref)
    @@game_reference = ref
  end

  def self.Destroy(go)
    @@game_reference.Destroy(go)
  end
end
