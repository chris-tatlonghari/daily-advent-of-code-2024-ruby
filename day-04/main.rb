# Part 1: calculate sum of xmas occurences
def checkNumXmasMatches(crossword, r, c)
  sum = 0
  directions = [
    [-1, 0],  # up
    [0, 1],   # right
    [1, 0],   # down
    [0, -1],  # left
    [-1, 1],  # upright
    [1, 1],   # downright
    [1, -1],  # downleft
    [-1, -1]  # upleft
  ]

  directions.each do |dr, dc|
    valid = (0...crossword.length).cover?(r + 3 * dr) &&
            (0...crossword[0].length).cover?(c + 3 * dc) &&
            crossword[r + dr][c + dc] == 'M' &&
            crossword[r + 2 * dr][c + 2 * dc] == 'A' &&
            crossword[r + 3 * dr][c + 3 * dc] == 'S'
    sum += 1 if valid
  end

  sum
end

sum = 0
crossword = []

File.foreach('day-04/input.txt') do |line|
  crossword << line.chomp
end

crossword.each.with_index do |row, r|
  row.each_char.with_index do |char, c|
    next unless char == 'X'

    sum += checkNumXmasMatches(crossword, r, c)
  end
end

p sum

# Part 2: calculate sum of x-mas occurences
def checkNumCrossMasMatches(crossword, r, c)
  return 0 if r == 0 || c == 0 || r == crossword.length - 1 || c == crossword[0].length - 1
  
  return 1 if crossword[r-1][c-1] == 'M' && crossword[r-1][c+1] == 'M' && crossword[r+1][c-1] == 'S' && crossword[r+1][c+1] == 'S'

  return 1 if crossword[r-1][c-1] == 'M' && crossword[r-1][c+1] == 'S' && crossword[r+1][c-1] == 'M' && crossword[r+1][c+1] == 'S'

  return 1 if crossword[r-1][c-1] == 'S' && crossword[r-1][c+1] == 'S' && crossword[r+1][c-1] == 'M' && crossword[r+1][c+1] == 'M'
  
  return 1 if crossword[r-1][c-1] == 'S' && crossword[r-1][c+1] == 'M' && crossword[r+1][c-1] == 'S' && crossword[r+1][c+1] == 'M'
  
  0
end

sumCrosses = 0

crossword.each.with_index do |row, r|
  row.each_char.with_index do |char, c|
    next unless char == 'A'

    sumCrosses += checkNumCrossMasMatches(crossword, r, c)
  end
end

p sumCrosses