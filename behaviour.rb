require_relative "component"
class Behaviour < Component
  def initialize()
    super
    start
  end
  #called at the start of the initialaiaztion
  def start
  end
  #called once per frame
  def update
  end
end
