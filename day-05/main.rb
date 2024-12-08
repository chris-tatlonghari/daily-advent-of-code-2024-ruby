# Calculate the sum of middle page numbers for correctly ordered updates
sum = 0
updates, badUpdates, badPageNums  = [], [], {}
doneReadingInstructions = false

File.foreach('day-05/input.txt') do |l|
  if l == "\n"
    doneReadingInstructions = true
    next
  end
  
  if doneReadingInstructions
    updates << l.chomp.split(',').map(&:to_i)
  else
    num1, num2 = l[0].to_i * 10 + l[1].to_i, l[3].to_i * 10 + l[4].to_i
    
    badPageNums[num2] = badPageNums.fetch(num2, []) << num1
  end
end


updates.each do |update|
  #p update
  seenNums = []
  badUpdate = false
  
  update.each do |pageNum|
    
    seenNums << pageNum
    seenNums.each do |seenNum|
      if !badPageNums[seenNum].nil? && badPageNums[seenNum].include?(pageNum)
        badUpdate = true
        #puts "bad update because of #{pageNum} and #{seenNum}"
        break
      end
    end

    break if badUpdate
  end

  if badUpdate
    badUpdates << update
    next
  end

  sum += update[update.length / 2]
end

#p badPageNums
puts sum


# Calculate the sum of middle page numbers for incorrectly ordered updates
sumFixedNums = 0

while badUpdates.any?
  update = badUpdates.pop
  p update

  seenNums = []
  badUpdate = false
  badIndex = 0

  update.each.with_index do |pageNum, index|

    seenNums << pageNum
    seenNums.each do |seenNum|
      if !badPageNums[seenNum].nil? && badPageNums[seenNum].include?(pageNum)
        badUpdate = true
        puts "bad update because of #{pageNum} and #{seenNum}"
        puts "badIndex = #{index}"
        badIndex = index
        break
      end
    end

    break if badUpdate
  end

  if badUpdate
    temp = update[badIndex - 1]
    update[badIndex - 1] = update[badIndex]
    update[badIndex] = temp
    badUpdates << update
    next
  end

  sumFixedNums += update[update.length / 2]
end

puts sumFixedNums