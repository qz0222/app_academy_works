require "byebug"
require "benchmark"
#O(n**2)

def my_min_phaseone(array, target)
  array.each_with_index do |el, i1|
    array.each_with_index do |el2, i2|
      next if el2 <= el
      return el if i == array.length - 1 && i1 != i2
    end
  end
end

#O(n)
def my_min_phasetwo(array, target)
  minimum = nil

  array.each do |el|
    minimum = el if minimum.nil? || minimum > el
  end

  minimum
end

#total for sub sum phase one = O(n**2)
def sub_sum_phaseone(array)
  sub_sets = []

  #section below is O(n**2)
  i = 0
  while i < array.length
    j = 0
    while i + j < array.length
      sub_sets << array[i..i+j]
      j += 1
    end
    i += 1
  end

  #section below is O(n**2)
  result = nil
  sub_sets.each do |set|
    sum = 0
    set.each do |el|
      sum += el
    end
    result = sum if result.nil? || sum > result
  end

  result
end

# O(n) - time ;  O(1) - space
# def sub_sum_phasetwo(array)
#   minimum_left = 0
#   minimum_left_idx = -1
#   left_sum = 0
#   biggest = nil
#
#   array.each_with_index do |el, idx|
#     biggest = el if biggest.nil? || el > biggest
#
#     left_sum += el
#     if left_sum  < minimum_left
#       minimum_left = left_sum
#       minimum_left_idx = idx
#     end
#   end
#
#   minimum_right = 0
#   minimum_right_idx = 0
#   right_sum = 0
#
#   (array.length-1).downto(0) do |i|
#     if right_sum + array[i] < minimum_right
#       right_sum += array[i]
#       minimum_right = right_sum
#       minimum_right_idx = i
#     else
#       right_sum += array[i]
#     end
#   end
#
#   answer = array[minimum_left_idx + 1..minimum_right_idx - 1]
#   answer.empty? ? biggest : answer.inject(&:+)
# end

def sub_sum_phasetwo(array)
  current_sum = 0
  max_sum = nil

  array.each_with_index do |el, idx|
    current_sum += el
    max_sum = current_sum if max_sum.nil? || current_sum > max_sum
    if current_sum < 0
      current_sum = 0
    end
  end

  max_sum
end

test_array = (1..500).to_a.shuffle

puts sub_sum_phasetwo([-5, -1, -3])

puts Benchmark.measure { sub_sum_phasetwo(test_array) }
puts Benchmark.measure { sub_sum_phaseone(test_array) }
