# Patterns store a series of frame information, this module is mostly to save/load them to/from files
class Pattern
  def self.new_from_frames(frames)
    cmds = Array.new
    last_frame = nil
    frames.each do |frame|
      cmds.push Command::LoadPlaneData.new(:zy, frame.zy_plane) if !last_frame or (last_frame and last_frame.zy_plane != frame.zy_plane)
      cmds.push Command::LoadPlaneData.new(:xy, frame.xy_plane) if !last_frame or (last_frame and last_frame.xy_plane != frame.xy_plane)
      cmds.push Command::RefreshAllPlanes.new
      cmds.push Command::Delay.new(250)
      last_frame = frame
    end
    
    self.new cmds
  end
  
  def self.new_from_file(filename, base_frame)
    cmds = Array.new
    
    File.open(filename, 'r') do |file|
      magic = file.read(5)
      raise Exception::IOError if magic != 'PATv2'
      while(!file.eof?)
        case file.readbyte
          when 0x02 # load plane
            if(file.readbyte == 0) then
              # zy plane
              which_plane = :zy
              base_plane = base_frame.zy_plane
            else
              # xy plane
              which_plane = :xy
              base_plane = base_frame.xy_plane
            end
            new_plane = Plane.new(base_plane.base_x, base_plane.base_y, base_plane.lit_image, base_plane.dim_image)
            new_plane.load_from_binary(file.read(6).unpack('C*'))
            cmds.push Command::LoadPlaneData.new(which_plane, new_plane)
          when 0x04 # refresh all planes
            cmds.push Command::RefreshAllPlanes.new
          when 0x01 # delay
            cmds.push Command::Delay.new(file.readbyte * 10)
          else
            puts "else"
        end
      end
    end
    
    self.new cmds
  end
  
  def initialize(cmds)
    @cmds = cmds
  end
  
  def each
    @cmds.each do |cmd|
      yield cmd
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
  
  def to_frames
    # output the contents of the pattern as a series of frames
    # this is somewhat limited by the editor's design, assumes each refresh is
    # a new frame using the most recent loaded patterns on each plane
    
    frames = Array.new
    zy_buf = nil
    xy_buf = nil
    frames.clear
    @cmds.each do |cmd|
      case cmd
        when Pattern::Command::LoadPlaneData
          puts " Load plane data into #{cmd.which_plane}"
          if(cmd.which_plane == :zy) then
            zy_buf = cmd.plane_data
          else
            xy_buf = cmd.plane_data
          end
        when Pattern::Command::RefreshAllPlanes
          puts " Refresh all planes"
          # turn the buffers into a new frame
          frames << Frame.new(nil, nil, zy_buf, xy_buf)
        when Pattern::Command::Delay
          puts " Delay"
          # currently ignored as the editor doesn't yet support per-frame delay specification
          # TODO: support per-frame delay specification
      end
    end
    
    frames
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

