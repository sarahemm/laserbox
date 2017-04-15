require 'rubyserial'

class LaserBoxLive
  def initialize(port)
    @port = Serial.new(port, 115200)
    throw "failed to initialize serial port" if @port.nil?
    sleep 3
    @port.write "live\n"
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
    send_cmd [0x02, plane_nbr] + plane.to_binary
  end
end