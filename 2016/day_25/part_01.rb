# --- Day 25: Clock Signal ---

# You open the door and find yourself on the roof. The city sprawls away from you for miles and miles.

# There's not much time now - it's already Christmas, but you're nowhere near the North Pole, much too far to deliver these stars to the sleigh in time.

# However, maybe the huge antenna up here can offer a solution. After all, the sleigh doesn't need the stars, exactly; it needs the timing data they provide, and you happen to have a massive signal generator right here.

# You connect the stars you have to your prototype computer, connect that to the antenna, and begin the transmission.

# Nothing happens.

# You call the service number printed on the side of the antenna and quickly explain the situation. "I'm not sure what kind of equipment you have connected over there," he says, "but you need a clock signal." You try to explain that this is a signal for a clock.

# "No, no, a clock signal - timing information so the antenna computer knows how to read the data you're sending it. An endless, alternating pattern of 0, 1, 0, 1, 0, 1, 0, 1, 0, 1...." He trails off.

# You ask if the antenna can handle a clock signal at the frequency you would need to use for the data from the stars. "There's no way it can! The only antenna we've installed capable of that is on top of a top-secret Easter Bunny installation, and you're definitely not-" You hang up the phone.

# You've extracted the antenna's clock signal generation assembunny code (your puzzle input); it looks mostly compatible with code you worked on just recently.

# This antenna code, being a signal generator, uses one extra instruction:

# out x transmits x (either an integer or the value of a register) as the next value for the clock signal.
# The code takes a value (via register a) that describes the signal to generate, but you're not sure how it's used. You'll have to find the input to produce the right signal through experimentation.

# What is the lowest positive integer that can be used to initialize register a and cause the code to output a clock signal of 0, 1, 0, 1... repeating forever?

@position = 0
@instructions = []
@previous = 1
@start = 0
@registers = { a: @start, b: 0, c: 0, d: 0 }

def number?(arg)
  arg.scan(/(\d+)/).any?
end

def inc(args)
  @registers[args[0].to_sym] += 1
  @position += 1
end

def dec(args)
  @registers[args[0].to_sym] -= 1
  @position += 1
end

def cpy(args)
  @registers[args[1].to_sym] = number?(args[0]) ? args[0].to_i : @registers[args[0].to_sym]
  @position += 1
end

def jnz(args)
  if (number?(args[0]) && args[0].to_i != 0) || (!number?(args[0]) && @registers[args[0].to_sym] != 0)
    @position += number?(args[1]) ? args[1].to_i : @registers[args[1].to_sym]
  else
    @position += 1
  end
end

def out(args)
  value = @registers[args[0].to_sym]
  if [0, 1].include?(value) && ((value == 0 && @previous == 1) || (value == 1 && @previous == 0) )
    print value
    @position += 1
    @previous = value
  else
    @position = 0
    @start += 1
    @previous = 1
    print "\n"
    p "start: #{@start}"
    @registers = { a: @start, b: 0, c: 0, d: 0 }
  end
end

File.readlines('input.txt').each do |line|
  args = line.chomp.split
  cmd = args.shift
  @instructions << { instruction: cmd, args: args }
end

while @position < @instructions.length
  send(@instructions[@position][:instruction], @instructions[@position][:args])
end

p @registers[:a]
