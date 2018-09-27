require_relative "component"
require_relative 'input'
class Behaviour < Component

  def initialize()
    super
    start()
  end

  #called after intialization
  def start

  end
  #called once per frame
  def update
  end
end
