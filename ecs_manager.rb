class ECSManager

	def initialize
		@entities = []
	end
	
	def update
		@entities.each { |entity| entity.update }
	end

	def draw
		@entities.each { |entity| entity.draw }
	end

	def add_entity(entity)
		@entities << entity
	end

end