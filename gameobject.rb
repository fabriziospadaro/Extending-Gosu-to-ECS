require_relative 'belva2d'

class GameObject
  attr_accessor :position, :scale, :components, :name
  attr_reader :enable
  @@game_reference

  def initialize(name, position = Vector2D.zero, scale = Vector2D.zero, components = nil)
    @position = position
    @scale = scale

    @name = name
    @components = []
    @enable = true
    AddComponent(components) if (components != nil)
  end

  def AddComponent(new_component)
    new_component.SetOwner(self)
    if(new_component.class.superclass.to_s == "Behaviour")
      #controlla se non esistono behavuoir se non esistono crea la hash
      #se esiste aggiungi dentro l'array value dell hash con chiave behaviour il component
      @components << {Behaviour: new_component}
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
    components.each do |cmp_hash|
      if(cmp_hash.values[0].class.superclass.to_s != "Behaviour")
        return cmp_hash.values[0] if cmp_hash.keys[0] == symbol
      else
        return cmp_hash.values[0] if (cmp_hash.values[0].class.to_s == symbol.to_s || (cmp_hash.keys[0] == symbol))
      end
    end
    return false
  end

  def SetActive(flag)
    @enable = flag
  end

  def self.FindObjectOfType(component)
    @@game_reference.object_list.each do |obj|
      return obj.GetComponent(component).gameobject if obj.GetComponent(component) != false
    end
    return false
  end

  def self.FindObjectsOfType(component)
    obj_list = []
    @@game_reference.object_list.each do |obj|
      obj_list << obj.GetComponent(component).gameobject if obj.GetComponent(component) != false
    end
    return obj_list.size > 0 ? obj_list : false
  end

  def self.Find(name)
    @@game_reference.object_list.each do |obj|
      return obj if obj.name == name
    end
    return false
  end

  def self.SetGameReference(ref)
    @@game_reference = ref
  end

end
