# Part 1: calculate sum of products from machine instructions
sum = 0

file_contents = File.read('day-03/input.txt')
matches = file_contents.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)

matches.each do |functionCall|
  numbers = functionCall.match(/mul\((\d+),(\d+)\)/)
  sum += (numbers[1].to_i * numbers[2].to_i)
end

puts sum

# Part 2: calculate sum of products from only enabled instructions
sum = 0
enabled_instructions = ""
enabled = true
numMatchedChars = 0

file_contents.each_char do |char|
  if enabled
    enabled_instructions += char

    if numMatchedChars == 0 && char == 'd'
      numMatchedChars = 1
    elsif numMatchedChars == 1 && char == 'o'
      numMatchedChars = 2
    elsif numMatchedChars == 2 && char == 'n'
      numMatchedChars = 3
    elsif numMatchedChars == 3 && char == "'"
      numMatchedChars = 4
    elsif numMatchedChars == 4 && char == 't'
      numMatchedChars = 5
    elsif numMatchedChars == 5 && char == '('
      numMatchedChars = 6
    elsif numMatchedChars == 6 && char == ')'
      numMatchedChars = 0
      enabled = false
    else
      numMatchedChars = 0
    end
  else
    if numMatchedChars == 0 && char == 'd'
      numMatchedChars = 1
    elsif numMatchedChars == 1 && char == 'o'
      numMatchedChars = 2
    elsif numMatchedChars == 2 && char == '('
      numMatchedChars = 3
    elsif numMatchedChars == 3 && char == ')'
      numMatchedChars = 0
      enabled = true
    else
      numMatchedChars = 0
    end
  end
end

matches = enabled_instructions.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)

matches.each do |functionCall|
  numbers = functionCall.match(/mul\((\d+),(\d+)\)/)
  sum += (numbers[1].to_i * numbers[2].to_i)
end

puts sum