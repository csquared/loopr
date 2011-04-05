#LoopR

## An Arduino-Based Loop Pedal

Yes, that's right: and Arduino-based loop pedal.

Why?  Not merely being cheap, but just basically being unsatisfied with having to make an investment just to be
able to loop some sounds and play a combination rhythm and guitar part!

TL;DR
If you have an itch, scratch it.

## Software:

- Arduino control program (two buttons with delay-based debouncing)
  - sends button presses to Serial Port
- Ruby control program
  - listens to button presses and runs SoX
  - using [ruby-serialport](http://ruby-serialport.rubyforge.org/)
- [SoX](http://sox.sourceforge.net/)
  - provides cmd line interface to record and loop

## Hardware:

<img src="http://www.chriscontinanza.com/images/loop_pedal_buttons.jpg" />
<br/>
*Circuit for two buttons (those are 10K ohm resistors)*

## To Run:

- open arduino project (Buttons.pde) in /arduino/Buttons and upload to board
- run <code>$ ruby listener/run.rb &lt;tty of arduino&gt; </code>
- button 1 starts and stops recording a loop
- button 2 starts and stops the loop

## To Do

- get this in a project box
- hook it up to my guitar and ROCK OUT!


Thanks to the awesome folks at the [Austin Hackerspace](http:/www.atxhackerspace.org) and MicroController Monday I was able to get my Arduino-based Loop pedal off the ground... or maybe closer to the ground!  So much thanks to Danny and Tim for showing me the way.

Or as they like to say:
### Don't let the software guys touch the hardware!!!! 

