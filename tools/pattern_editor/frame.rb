# Frames contain two planes, one ZY and one XY
class Frame
  def initialize(lit_image, dim_image)
    @zy_plane = Plane.new(10,  10, lit_image, dim_image)
    @xy_plane = Plane.new(325, 10, lit_image, dim_image)
  end
  
  def redraw
    @zy_plane.redraw
    @xy_plane.redraw
  end
  
  def find_pixel_by_coords(x, y)
    pixel = @zy_plane.find_pixel_by_coords(x, y)
    pixel = @xy_plane.find_pixel_by_coords(x, y) if !pixel
    pixel
  end
  
  def to_binary
    @zy_plane.to_binary + @xy_plane.to_binary
  end
  
  def load_from_binary(binary_data)
    @zy_plane.load_from_binary(binary_data[0..5])
    @xy_plane.load_from_binary(binary_data[6..11])
  end
  
  def clear!
    @xy_plane.clear!
    @zy_plane.clear!
  end
end