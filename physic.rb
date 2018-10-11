require_relative 'component'

module Physic


  class BaseCollider < Component
    attr_accessor :scale
    attr_reader :vertices
    
    def intialize(scale)
      super()
      @scale = scale
      @vertices = []
    end

    def set_vertices
      raise "Not Implemented"
    end

    def space_vertices
      return @vertices.map do |vertex|
        vertex *= scale
        vertex += @gameobject.position  
      end
    end

    #https://www.codeproject.com/Articles/15573/2D-Polygon-Collision-Detection
    def collide?(collider)
      vertex_count_A = self.vertices.Count
      vertex_count_B = collider.vertices.Count
      vertex = nil
      
      for i in 0..(vertex_count_B+vertex_count_A)
        if(i < vertex_count_A)
          vertex = self.vertices[i]
        else
          vertex = collider.vertices[i - vertex_count_A]
        end
        axis = Vector2.new(-vertex.y, vertex.x)
        axis.Normalize!

        minA = minB = maxA = maxB = 0

        project_polygon(axis, self, minA, maxA)
        project_polygon(axis, collider, minB, maxB)

        if(interval_distance(minA, maxA, minB, maxB) > 0)
            return false
        end
      end
      return true

    end

    def project_polygon(axis, polygon, min, max)
      dot_product = axis.DotProduct(polygon.vertices[0])
      min = dot_product
      max = dot_product

      for i in 0..polygon.vertices.size
        dot_product = polygon.vertices[i].DotProduct(axis))
        if(dot_product < min)
          min = dot_product
        elsif(dot_product > max)
          max = dot_product
        end
      end
    end

    def interval_distance(min_a,max_a,min_b,max_b)
      if(min_a < min_b)
        return min_b - max_a
      else
        return min_a - max_b
      end
    end

  end

  class BoxCollider < BaseCollider

    def initialize(width,height,scale = 1)
      super(scale)
      @width = width
      @height = height
      set_vertices()
    end

    def set_vertices()
      @vertices << Vector2.new(-width/2,height/2) #top left
      @vertices << Vector2.new(-width/2,height/2) #top right

      @vertices << Vector2.new(-width/2,-height/2) #bottom left
      @vertices << Vector2.new(-width/2,-height/2) #bottom left
      @vertices.freeze
    end

  end

  class CircleCollider < BaseCollider

    def initialize(radius = 1,scale = 1)#only c2c
      super(scale)
      @radius = radius
      set_vertices()
    end

    def set_vertices()
      step = 3
      
      for angle in 0..360
        @vertices << Vector2.new(Math.cos(angle),Math.sin(angle))*@radius 
        angle += step
      end
      @vertices.freeze
    end

  end

  class PolygonCollider < BaseCollider

    def initialize(vertices,scale)#only c2c
      super(scale)
      set_vertices(vertices)
    end

    def set_vertices(vertices)
      @vertices = vertices
      @vertices.freeze
    end
    
  end

end


