# Planes are groups of 6x6 laser pixels aiming in the same direction
class Plane
  attr_reader :lit_image, :dim_image, :base_x, :base_y, :pixels
  
  def initialize(base_x, base_y, lit_image, dim_image)
    @lit_image = lit_image
    @dim_image = dim_image
    @base_x = base_x
    @base_y = base_y
    @pixels = Array.new
    (0..5).each do |x|
      (0..5).each do |y|
        @pixels[x] = Array.new if !@pixels[x]
        @pixels[x][y] = Pixel.new(self, x, y)
      end
    end
  end
  
  def ==(other_plane)
    (0..5).each do |x|
      (0..5).each do |y|
        return false if @pixels[x][y].lit? != other_plane.pixels[x][y].lit?
      end
    end
    return true
  end
  
  def redraw
    @pixels.each do |row|
      row.each do |pixel|
        pixel.redraw
      end
    end
  end

  def find_pixel_by_coords(x, y)
    # return which pixel contains the coords given
    @pixels.each do |row|
      row.each do |pixel|
        return pixel if pixel.coords_contain?(x, y)
      end
    end
    nil
  end
  
  def to_binary
    # output the data from this plane as one byte per row, the format LaserBox wants
    # (there are two 'junk'/status bits per row because it makes the hardware easier)
    bits = Array.new
    (0..5).each do |x|
      row_byte = 0
      (0..5).each do |y|
        row_byte = row_byte << 1
        row_byte |= 0x01 if @pixels[x][y].lit?
      end
      bits << row_byte
    end
    
    bits
  end
  
  def load_from_binary(binary_data)
    # load the plane information from binary data provided
    binary_data.each_index do |x_idx|
      5.downto(0).each do |y_idx|
        @pixels[x_idx][y_idx].lit = (binary_data[x_idx] & 0x01 != 0x00 ? true : false)
        binary_data[x_idx] = binary_data[x_idx] >> 1
      end
    end
  end
  
  def clear!
    # set all the pixels in this plane to off
    @pixels.each do |row|
      row.each do |pixel|
        pixel.lit = false
      end
    end
  end
end