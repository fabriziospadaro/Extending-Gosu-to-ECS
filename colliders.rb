require_relative 'component'


class BoxCollider < Component

  def initialize(min, max)
    super()
    @min = min
    @max = max
  end

  def self.collide?(a,b)##only box v box
    return false if(a.max.x < b.min.x || a.min.x > b.max.x)
    return false if(a.max.y < b.min.y || a.min.y > b.max.y)

    return true
  end
end

class CircleCollider < Component

  def initialize(origin, radius)
    super()
    @radius = radius
    @origin = origin
  end
  def self.collide?(a,b)##only circle v circle
    r = a.radius + b.radius
    r *= r
    return r < ((a.x + b.x)**2 + (a.y + b.y)**2)
  end
end

