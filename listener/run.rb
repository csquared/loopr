require 'rubygems'
require 'serialport'

class Button
  
  def initilize
    @on = false
  end

  def toggle!
    @on = !@on
  end

  def on?; @on; end
  def off?; !@on; end
end

class Pedal
  def initialize
    @record_button = Button.new
    @loop_button = Button.new
  end

  def run!(tty = nil)
    unless tty 
      puts "need to specify tty of arduino (usually /dev/ttyUSB*)"
      exit 1
    end

    puts "Opening #{tty}"
    @serial = SerialPort.open(tty, 9600)

    loop do
      cmd = @serial.gets
     
      puts "Got #{cmd}" if cmd
      @record_button.toggle! if cmd == '1' 
      @loop_button.toggle! if cmd == '2'

      if @record_button.on? && !@record && !@loop 
        puts "Recording"
        @record = fork{ exec("rec loop.wav") }
      end

      if @record_button.off? && @record
	      puts "Killing"
        Process.kill 'TERM', @record
	      @record = nil
      end

      if @loop_button.on? && !@loop && !@record
        puts "Looping"
        # let SoX do the looping - we're going to kill it anyways
        @loop = fork { exec("play loop.wav repeat 100000") } 
      end

      if @loop_button.off? && @loop
        Process.kill 'TERM', @loop
        @loop = nil
      end
    end
  end
end


Pedal.new.run!(ARGV[0]) if __FILE__ == $0
