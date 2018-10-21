require "pry"
class Component
  attr_reader :entity
  def initialize(entity)
    @entity = entity
    start
  end

  def start
  	warn("Start not implemented for #{@entity}")
  end

  def set(params)
    params.each_with_index do |param|
      instance_variable_set("@#{param[0].to_s}",param[1])
    end
    return self
  end
end
