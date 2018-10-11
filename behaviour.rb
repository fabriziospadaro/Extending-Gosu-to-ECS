require_relative 'component'
require_relative 'input'

class Behaviour < Component

  def initialize()
    super
    @enabled = false
  end

  ##called once per frame
  def update
  
  end

  def deep_clone
    return self.class.new
  end
end
