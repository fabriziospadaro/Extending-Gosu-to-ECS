class TransformComponent < Component

	attr_accessor :position,:rotation,:scale
	def start
		@position = Point.zero
		@rotation = 0
		@scale = Point.one
	end
end