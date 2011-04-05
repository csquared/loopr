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

  def run!(tty = ARGV[0])
    puts "Opening #{tty}"
    @serial = SerialPort.open(tty, 9600)

    loop do
      cmd = @serial.gets
     
      puts "Got #{cmd}" if cmd
      @record_button.toggle! if cmd == '1' 
      @loop_button.toggle! if cmd == '2'

      if @record_button.on? && !@sox && !@loop 
	puts "Recording"
        @sox = fork{ exec("rec loop.wav") } 
	puts "@sox: \n #{@sox.inspect}"
      end

      if @record_button.off? && @sox
	puts "Killing"
        Process.kill 'TERM', @sox
	@sox = nil
      end

      if @loop_button.on? && !@loop
	puts "Looping"
        @loop = fork { exec("play loop.wav repeat 100000") } 
      end

      if @loop_button.off? && @loop
        Process.kill 'TERM', @loop
        @loop = nil
      end
    end
  end
end


Pedal.new.run! if __FILE__ == $0
