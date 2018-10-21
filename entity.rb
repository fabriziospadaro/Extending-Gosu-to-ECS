class Entity
	attr_reader :components 

	def initialize
		@components = []
		@systems = []
		@active = true
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

	def add_component(cmp_name)
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

	def add_system(syst_name)
		@systems << Object.const_get("#{syst_name}").new(self)
		return @systems[-1]
	end

	def get_system(syst_name)
		@systems.each do |system| 
			return system if system.class == Object.const_get("#{syst_name}")
		end
	end
end