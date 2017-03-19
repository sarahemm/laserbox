require 'rubyserial'

class LaserBoxLive
  def initialize(port)
    @port = Serial.new(port, 115200)
    throw "failed to initialize serial port" if @port.nil?
    sleep 1
    @port.write 'L'
  end
  
  def send_cmd(cmd_bytes)
    @port.write cmd_bytes.pack('C*')
  end
  
  def refresh
    send_cmd [0x04]
  end
  
  def set_pixel(plane, x, y, val)
    cmd_byte = (plane << 7) | (x << 4) | (y << 1) | val
    send_cmd [0x03, cmd_byte]
  end
  
  def set_plane(plane, data)
    send_cmd [0x02, plane] + data
  end
  
  def set_plane_from_plane(plane_nbr, plane)
    pixel_bytes = []
    (0..5).each do |x|
      pixel_bytes[x] = 0
      (0..5).each do |y|
        pixel_bytes[x] |= (plane.pixels[y][x].lit? ? 1 : 0) << 5-y
      end
    end
    
    send_cmd [0x02, plane_nbr] + pixel_bytes
  end
end