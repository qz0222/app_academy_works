require 'byebug'

def exp1(n,e)
  return n if n == 0 || n == 1
  return 1 if e == 0
  (n * exp1(n, e - 1))
end

#This version of exponent save time by dividing an even exponent by two,
#processing once and mulitplying the result by itself. This ensures that
#we are performing fewer steps. This is "fast_power" algorithm.
def exp2(n,e)
  return n if n == 0 || n == 1 || e == 1
  return 1 if e == 0
  if e % 2 == 0
    temp = exp2(n,(e / 2))
    return temp * temp
  else
    temp = exp2(n,((e - 1) / 2))
    return n * temp * temp
  end
end

def deep_dup(arr)
  dup_arr = []
  return arr if arr.length == 1
  if arr[0].is_a?(Array)
    dup_arr << deep_dup(arr[0])
  else
    dup_arr << arr[0]
  end
  dup_arr + deep_dup(arr[1 .. -1])
end

def fib(n)
  return [1] if n == 1
  return [1, 1] if n == 2
  prev_fib = fib(n-1)
  prev_fib + [prev_fib[-2] + prev_fib[-1]]
end

def subsets(arr)
  return [[]] if arr.empty?
  sub1 = subsets(arr[1..-1])
  sub2 = sub1.map { |el| el + [arr[0]] }
  (sub1 + sub2).uniq
end

def permutations(arr)
  return [arr] if arr.length <= 1
  res = []
  prev = permutations(arr[1 .. -1])
  prev.each do |arr_el|
    i = 0
    while i < arr.length
      res << arr_el.take(i) + [arr[0]] + arr_el.drop(i)
      i += 1
    end
  end
  res
end


def bsearch(arr, target)
  return nil if arr.empty?
  mid_index = arr.length / 2
  if arr[mid_index] == target
      return mid_index
  elsif arr[mid_index] > target
     return bsearch(arr[0...mid_index], target)
  else
    right_side_bsearch_result = bsearch(arr[(mid_index + 1)..-1], target)
    return nil if right_side_bsearch_result.nil?
    return right_side_bsearch_result + mid_index + 1
  end
end


def merge(arr1, arr2)
  result = []
  until arr1.empty? || arr2.empty?
    #debugger
    compare = (arr1.first <=> arr2.first)
    if compare == 1
      result << arr2.shift
    else
      result << arr1.shift
    end
  end

  return result + arr1 + arr2
end

def merge_sort(arr)
  return arr if arr.length <= 1
  left = arr.take(arr.length/2)
  right = arr.drop(arr.length/2)
  merge(merge_sort(left), merge_sort(right))
end


def greedy_make_change(total, coins = [25, 10, 5, 1])
  result = []
  return [] if total == 0
  coins.each do |coin|
    if total >= coin
      result << coin
      total = total - coin
      break
    end
  end
  result + greedy_make_change(total, coins)
end

def make_better_change(total, coins = [25, 10, 5, 1])
  best_solution = []
  num_of_coins = nil
  coins.each do |coin|
    next if coin > total
    return [] if total == 0
    current_solution = [coin] + make_better_change(total - coin, coins)
    if num_of_coins == nil || current_solution.length < num_of_coins
      best_solution = current_solution
      num_of_coins = best_solution.length
    end
  end
  best_solution
end

p make_better_change(24, [10,7,1])
