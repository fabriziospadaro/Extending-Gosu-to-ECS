require_relative "component"
require_relative 'input'
class Behaviour < Component

  def initialize()
    super
    @enabled = false
  end

  def update
  end

  def deep_clone
    return self.class.new
  end
end
