# Patterns store a series of frame information, this module is mostly to save/load them to/from files
class Pattern
  def self.new_from_frames(frames)
    self.new frames
  end
  
  def initialize(frames)
    @cmds = Array.new
    
    last_frame = nil
    frames.each do |frame|
      @cmds.push Command::LoadPlaneData.new(:zy, frame.zy_plane) if !last_frame or (last_frame and last_frame.zy_plane != frame.zy_plane)
      @cmds.push Command::LoadPlaneData.new(:xy, frame.xy_plane) if !last_frame or (last_frame and last_frame.xy_plane != frame.xy_plane)
      @cmds.push Command::RefreshAllPlanes.new
      @cmds.push Command::Delay.new(250)
      last_frame = frame
    end
  end
  
  def save(filename)
    File.open(filename, 'w') do |file|
      # file starts with magic
      file.write 'PATv2'
      @cmds.each do |cmd|
        case cmd
          when Command::LoadPlaneData
            file.write [0x02].pack('C') # load plane
            file.write [cmd.which_plane == :zy ? 0x00 : 0x01].pack('C') # which plane are we loading
            file.write cmd.plane_data.to_binary.pack('C*')
          when Command::RefreshAllPlanes
            file.write [0x04].pack('C') # refresh all planes
          when Command::Delay
            file.write [0x01].pack('C') # delay
            file.write [cmd.delay_ms / 10].pack('C')
        end
      end
    end
  end
      
  class Command
    class LoadPlaneData
      attr_reader :which_plane, :plane_data
      
      def initialize(which_plane, plane_data)
        @which_plane = which_plane
        @plane_data = plane_data
      end
    end

    class RefreshAllPlanes
    end

    class Delay
      attr_reader :delay_ms
      
      def initialize(delay_ms)
        @delay_ms = delay_ms
      end
    end
  end
end

