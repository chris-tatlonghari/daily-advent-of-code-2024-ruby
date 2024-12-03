# Part 1: calculate number of safe reports
numberOfSafeReports = 0

File.foreach('day-02/input.txt') do |report|
  numbers = report.split.map(&:to_i)
  unsafe = false

  increasing = numbers[0] < numbers[1] ? true : (numbers[0] > numbers[1] ? false : nil)
  next if increasing.nil?

  prev = numbers[0]
  for num in numbers[1..-1] do
    difference = (num - prev).abs

    changedDirection = (increasing && prev > num) || (!increasing && prev < num)
    isNonGradualChange = (difference < 1) || (difference > 3)

    if changedDirection || isNonGradualChange
      unsafe = true
      break
    end

    prev = num
  end

  next if unsafe

  numberOfSafeReports += 1
end

p numberOfSafeReports

# Part 2: calculate number of safe reports allowing 1 bad level
def unsafe?(numbers)
  prev = numbers[0]
  increasing = numbers[0] < numbers[1] ? true : (numbers[0] > numbers[1] ? false : nil)

  numbers.each_with_index do |num, i|
    next if i == 0

    repeatedNumbers = increasing.nil?

    changedDirection = (increasing && prev > num) || (!increasing && prev < num)

    difference = (num - prev).abs
    isNonGradualChange = (difference < 1) || (difference > 3)

    if changedDirection || isNonGradualChange || repeatedNumbers
      return true
    end

    prev = num
  end

  false
end

numberOfSafeReports = 0

File.foreach('day-02/input.txt') do |report|
  numbers = report.split.map(&:to_i)
  unsafe = unsafe? numbers

  if unsafe
    for i in 0..numbers.length - 1 do
      numbersAfterDampened = numbers[0...i] + numbers[(i+1)..-1]
      if !unsafe? numbersAfterDampened
        unsafe = false
        break
      end
    end
  end

  next if unsafe
    
  numberOfSafeReports += 1
end

p numberOfSafeReports


