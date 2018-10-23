class FrameTime
  attr_reader :this, :last, :delta
  def initialize
    @last = Gosu::milliseconds
    @@time_reference = self
    @frames = 0
    @currentTime = 0
  end

  def update
    @this = Gosu::milliseconds
    @delta = (@this - @last) / 1000.0
    @last = @this

    @currentTime += @delta
    @frames += 1;
    if(@currentTime >= 1.0 )
      p (@frames)
      @frames = 0;
      @currentTime = 0
    end
  end

  def self.delta_time
    return @@time_reference.delta
  end
end
