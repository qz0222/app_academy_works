require_relative "min_max_stack"

require "benchmark"

#O(n**2)

def windowed_max_range(array, window_size)
  current_max_range = nil
  i = 0
  while i + (window_size - 1) < array.length
    max = nil
    min = nil

    array[i..i + window_size - 1].each do |el|
      max = el if max.nil? || el > max
      min = el if min.nil? || el < min
    end

    current_max_range = max - min if current_max_range.nil? || current_max_range < max - min
    i += 1
  end

  current_max_range
end


def optimized_windowed_max_range(array, window_size)
  queue = MinMaxStackQueue.new
  until queue.size == window_size
    queue.enqueue(array.shift)
  end
  max_range = queue.max - queue.min
  until array.empty?
    queue.dequeue
    queue.enqueue(array.shift)
    current_max_range = queue.max - queue.min
    max_range = current_max_range if current_max_range > max_range
  end
  max_range
end


test_array = (1..20000).to_a.shuffle

puts Benchmark.measure { windowed_max_range(test_array, 400) }
puts Benchmark.measure { optimized_windowed_max_range(test_array, 400) }


# p optimized_windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p optimized_windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p optimized_windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p optimized_windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
