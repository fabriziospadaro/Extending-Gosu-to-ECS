module Point

  class Data
    attr_accessor :x,:y
    def initialize(_x=0, _y=0)
      @x = _x
      @y = _y
    end

    def ==(b)
      (@x == b.x && @y == b.y)
    end

    def -(b)
      return Data.new(@x - b.x,@y - b.y)
    end

    def +(b)
      return Data.new(@x + b.x,@y + b.y)
    end

    def /(b)
      return Data.new(@x / b ,@y / b)
    end

    def *(b)
      return Data.new(@x * b ,@y * b)
    end

    def dot(f)
      return Data.new(@x*f,@y*f)
    end

    def magnitude
      return Math.sqrt((self.x ** 2) + (self.y ** 2))
    end

    def normalized
      length = magnitude
      return self/length
    end

    def Normalize!
      normalized_vector = normalize
      @x = normalized_vector.x
      @y = normalized_vector.y
    end

    def DotProduct(a,b)
      return (self.x * b.x) + (self.y * b.y)
    end
  end

  def self.zero
    return Point::Data.new(0,0)
  end

  def self.one
    return Point::Data.new(1,1)
  end

  def self.right
    return Point::Data.new(1,0)
  end

  def self.up
    return Point::Data.new(0,-1)
  end

  def self.random
    return Point::Data.new(rand(0.to_f..1),rand(0.to_f..1))
  end

  def self.Learp(a,b,time)
    return a + ((b - a).dot(time));
  end

  def self.Distance(a,b)
    return Math.sqrt((a.x - b.x)**2 + (a.y - b.y)**2 )
  end

end
