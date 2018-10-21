class System
	attr_reader :entity
	def initialize(entity)
    @entity = entity
    start()
	end

	def start
  	warn("Start not implemented for #{@entity}")
	end

	def update
		warn("Update not implemented for #{@entity}")
	end

	def draw
	  warn("Draw not implemented for #{@entity}")
	end
 
end