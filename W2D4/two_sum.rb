# O(n**2) time

def bad_two_sum?(arr, sum)
  arr.each_with_index do |el, i|
    arr.each_with_index do |el2, i2|
      return true if el + el2 == sum && i != i2
    end
  end
  false
end

# O(nlogn)
def okay_two_sum?(arr, sum)
  arr.sort!
  arr.each_with_index do |el , i|
    test_arr = arr.dup
    test_arr.delete_at(i)
    result = b_search?(test_arr, sum-el)
    return true if result
  end
  false
end

def b_search?(arr, target)
  return false if arr.empty?
  mid = arr.length / 2
  return true if arr[mid] == target
  left = arr[0...mid]
  right = arr[mid+1..-1]
  if arr[mid] > target
    b_search?(left, target)
  else
    b_search?(right, target)
  end
end

# O(n)
def two_sum?(arr, sum)
  hash = Hash.new

  arr.each do |el|
    return true if hash[sum - el] == true
    hash[el] = true
  end

  false
end


# BONUS 
# O(n**3)
def four_sum?(arr, sum)
  arr.each_with_index do |el1, idx1|
    arr.each_with_index do |el2, idx2|
      if idx1 < idx2
        duplicate_array = arr.dup
        duplicate_array.delete(idx1)
        duplicate_array.delete(idx2-1)
        result = two_sum?(duplicate_array, (sum - el1 - el2))
        return true if result
      end
    end
  end
  false
end

test_array = [1, 5, 8, 20, 5, 7, 200, 3]
p four_sum?(test_array, 217)
