# --- Part Two ---

# After getting the first capsule (it contained a star! what great fortune!), the machine detects your success and begins to rearrange itself.

# When it's done, the discs are back in their original configuration as if it were time=0 again, but a new disc with 11 positions and starting at position 0 has appeared exactly one second below the previously-bottom disc.

# With this new disc, and counting again starting from time=0 with the configuration in your puzzle input, what is the first time you can press the button to get another capsule?

discs = []

File.readlines('input.txt').each_with_index do |line, i|
  positions, position = line.scan(/has (\d+).+position (\d+)/).flatten.map(&:to_i)
  position = (position + i + 1) % positions
  discs << { positions: positions, position: position }
end

discs << { positions: 11, position: (discs.length + 1) }

counter = 0

loop do
  break if discs.reject{ |d| (d[:position] + counter) % d[:positions] == 0}.empty?

  counter += 1
end

p counter
