class Entity
	attr_reader :components, :system, :dirty_components, :dirty_system

	def initialize
		@dirty_components = []
		@dirty_system = []
		@components = []
		@systems = []
		@active = true
	end
	
	def self.configure
		entity = Entity.new
		yield(entity)
		return entity
	end

	def update
		@systems.each{ |system| system.update }
	end 

	def draw
		@systems.each{ |system| system.draw }
	end

	def active?
		return @active
	end

	def destroy!
		@active = false
	end

	def has_component?(cmp_name)
		return @components.any? { |component| component.class == Object.const_get("#{cmp_name}")}
	end

	def add_component(cmp_name,cmp_values = nil)
		@dirty_components << {cmp_name => cmp_values}
	end

	def set_component(cmp_name)
		@components << Object.const_get("#{cmp_name}").new(self)
		return @components[-1]
	end


	def get_component(cmp_name)
		@components.each do |component| 
			return component if component.class == Object.const_get("#{cmp_name}")
		end
	end

	def has_system?(syst_name)
		return @systems.any? { |system| system.class == Object.const_get("#{syst_name}")}
	end

	def add_system(syst_name,syst_values = nil)
		@dirty_system << {syst_name => syst_values}
	end

	def set_system(syst)
		@systems << Object.const_get("#{syst}").new(self)
		return @components[-1]
	end

	def get_system(syst_name)
		@systems.each do |system| 
			return system if system.class == Object.const_get("#{syst_name}")
		end
	end
end