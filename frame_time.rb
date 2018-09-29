class FrameTime
  attr_reader :this, :last, :delta
  def initialize
    @last = Gosu::milliseconds
    @@time_reference = self
  end

  def update
    @this = Gosu::milliseconds
    @delta = (@this - @last) / 100.0
    @last = @this
  end

  def self.deltaTime
    return @@time_reference.delta
  end
end
