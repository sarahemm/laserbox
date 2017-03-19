# Pixels represent one laser beam
class Pixel
  attr_reader :x, :y, :plane

  def initialize(plane, x, y)
    @plane = plane
    @x = x
    @y = y
    @x_coord = @plane.base_x + @x * (@plane.lit_image.width + 10)
    @y_coord = @plane.base_y + @y * (@plane.lit_image.height + 10)
    @value = false
  end
  
  def toggle!
    @value = !@value
  end
  
  def lit?
    @value
  end
  
  def lit=(value)
    @value = value
  end
  
  def redraw
    pixel_image = @value ? @plane.lit_image : @plane.dim_image
    pixel_image.draw(@x_coord, @y_coord, 0);
  end
  
  def coords_contain?(x, y)
    # return true if the x/y coords given are within this pixel
    return true if x > @x_coord and x < @x_coord + @plane.lit_image.width and y > @y_coord and y < @y_coord + @plane.lit_image.height
    return false
  end
end