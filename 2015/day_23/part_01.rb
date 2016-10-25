# --- Day 23: Opening the Turing Lock ---

# Little Jane Marie just got her very first computer for Christmas from some unknown benefactor. It comes with instructions and an example program, but the computer itself seems to be malfunctioning. She's curious what the program does, and would like you to help her run it.

# The manual explains that the computer supports two registers and six instructions (truly, it goes on to remind the reader, a state-of-the-art technology). The registers are named a and b, can hold any non-negative integer, and begin with a value of 0. The instructions are as follows:

# hlf r sets register r to half its current value, then continues with the next instruction.
# tpl r sets register r to triple its current value, then continues with the next instruction.
# inc r increments register r, adding 1 to it, then continues with the next instruction.
# jmp offset is a jump; it continues with the instruction offset away relative to itself.
# jie r, offset is like jmp, but only jumps if register r is even ("jump if even").
# jio r, offset is like jmp, but only jumps if register r is 1 ("jump if one", not odd).
# All three jump instructions work with an offset relative to that instruction. The offset is always written with a prefix + or - to indicate the direction of the jump (forward or backward, respectively). For example, jmp +1 would simply continue with the next instruction, while jmp +0 would continuously jump back to itself forever.

# The program exits when it tries to run an instruction beyond the ones defined.

# For example, this program sets a to 2, because the jio instruction causes it to skip the tpl instruction:

# inc a
# jio a, +2
# tpl a
# inc a
# What is the value in register b when the program in your puzzle input is finished executing?

@a = 0
@b = 0
@position = 0
instructions = []

def inc(args)
  eval "@#{args[:register]} += 1"
  @position += 1
end

def jio(args)
  eval "@position += @#{args[:register]} == 1 ? #{args[:offset]} : 1"
end

def jie(args)
  eval "@position += @#{args[:register]} % 2 == 0 ? #{args[:offset]} : 1"
end

def hlf(args)
  eval "@#{args[:register]} /= 2"
  @position += 1
end

def tpl(args)
  eval "@#{args[:register]} *= 3"
  @position += 1
end

def jmp(args)
  eval "@position += #{args[:register]}"
end

File.open('input.txt', 'r').each_line do |line|
  command, offset = line.chomp.split ', '
  instruction, register = command.split ' '
  instructions << { instruction: instruction, register: register, offset: offset.to_i }
end

while @position < instructions.length
  send(instructions[@position][:instruction], instructions[@position])
end

puts @b
