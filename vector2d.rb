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

  def self.random
    return Vector2D.new(rand(0.01..1),rand(0.01..1))
  end

  def self.Learp(a,b,time)
    return a + time * (b - a);
  end

  def self.Distance(a,b)
    return Math.sqrt((a.x - b.x)**2 + (a.y - b.y)**2 )
  end
end
