class Transform
	attr_accessor :position,:scale,:angle
	attr_reader :gameobject
	
	def initialize(args)
		@position = args[:position] || Vector2D.zero
		@angle = args[:angle] || 0
		@scale = args[:scale] || Vector2D.one
		@gameobject = args[:gameobject]
	end

end