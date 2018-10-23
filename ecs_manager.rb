class ECSManager
	attr_reader :entities
	def initialize
		@entities = []
	end
	
	def update
		@entities.each do |entity| entity.update 
			entity.get_component(TransformComponent).position
		end
	end

	def draw
		@entities.each { |entity| entity.draw }
	end

	def add_entity(entity)
		entity_clone = Entity.new()

		entity.dirty_components.each do |component|
			entity_clone.set_component(component.keys[0]).set(component.values[0])
		end
		entity.dirty_system.each do |system|
			entity_clone.set_system(system.keys[0])
		end

		entity_clone.components.each { |component| component.solve_dependency} 

		@entities << entity_clone
		return entity_clone
	end

end