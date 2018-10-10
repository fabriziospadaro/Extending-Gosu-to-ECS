class Vector2D
  attr_accessor :x,:y

  def initialize(_x=0, _y=0)
    @x = _x
    @y = _y
  end

  def Set(_x, _y)
    @x = _x
    @y = _y
  end

  def Constrain_1x(lim_x,lim_y)
    if(@x >= lim_x)
      @x = lim_x
    elsif(@x < 1)
      @x = 1
    end
    if(@y >= lim_y)
      @y = lim_y
    elsif(@y < 1)
      @y = 1
    end
  end

  def ==(b)
   (@x == b.x && @y == b.y)
  end

  def -(b)
    return Vector2D.new(@x - b.x,@y - b.y)
  end

  def +(b)
    return Vector2D.new(@x + b.x,@y + b.y)
  end

  def /(b)
    return Vector2D.new(@x / b ,@y / b)
  end

  def *(b)
    return Vector2D.new(@x * b ,@y * b)
  end

  def self.zero
    return Vector2D.new(0,0)
  end

  def self.one
    return Vector2D.new(1,1)
  end

  def self.right
    return Vector2D.new(1,0)
  end

  def self.up
    return Vector2D.new(0,-1)
  end

  def dot(f)
    return Vector2D.new(@x*f,@y*f)
  end

  def self.random
    return Vector2D.new(rand(0.to_f..1),rand(0.to_f..1))
  end

  def self.Learp(a,b,time)
    return a +((b - a).dot(time));
  end

  def self.Distance(a,b)
    return Math.sqrt((a.x - b.x)**2 + (a.y - b.y)**2 )
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
