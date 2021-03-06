# --- Part Two ---

# Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.

# For example:

# ) causes him to enter the basement at character position 1.
# ()()) causes him to enter the basement at character position 5.
# What is the position of the character that causes Santa to first enter the basement?

floor = 0

File.open('input.txt', 'r') do |input|
  input.gets.chomp.each_char.with_index do |char, index|
    floor += char == '(' ? 1 : -1

    if floor == -1
      puts index + 1
      break
    end
  end
end
