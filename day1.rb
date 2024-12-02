# Part 1: calculate total distance between location ids lists
totalDistance = 0
leftList, rightList = [], []

File.foreach("day1-input.txt") do |line| 
  numbers = line.split.map(&:to_i)
  leftList << numbers[0]
  rightList << numbers[1]
end

leftList.sort!
rightList.sort!

for i in 0..leftList.length-1 do 
  totalDistance += (leftList[i] - rightList[i]).abs
end

p totalDistance

# Part 2: calculate similarity score between location ids lists
similarityScore = 0
frequencyById = Hash.new(0)

rightList.each do |id|
  frequencyById[id] += 1
end

leftList.each do |id|
  similarityScore += frequencyById[id] * id
end

p similarityScore