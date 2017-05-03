# O(n!)
def first_anagram?(word1, word2)
  combinations = permutation(word1.split(""))
  combinations.map(&:join).include?(word2)

end

def permutation(str_array)
  return [str_array, str_array.reverse] if str_array.length == 2
  final_result = []
  str_array.each_with_index do |char, index|
    duplicate_array = str_array.dup
    duplicate_array.delete_at(index)
    result = permutation(duplicate_array)
    result.map{|str| str.unshift(char)}
    final_result += result
  end
  final_result
end

#O(n**2)
def second_anagram?(word1, word2)
  array1 = word1.split("")
  array2 = word2.split("")

  array1.each_with_index do |letter, i|
    array2.each_with_index do |letter2, i2|
      if letter == letter2
        array1[i] = nil
        array2[i2] = nil
        break
      end
    end
  end

  return true if array1.compact.empty? && array2.compact.empty?
  false
end

#O(nlogn)
def third_anagram?(word1, word2)
  word1.split("").sort == word2.split("").sort
end

#O(n)
def fourth_anagram?(word1, word2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)

  word1.each_char do |char|
    hash1[char] += 1
  end

  word2.each_char do |char|
    hash2[char] += 1
  end

  hash1 == hash2
end

#O(n)
def bonus_anagram?(word1, word2)
  hash = Hash.new(0)

  word1.each_char do |char|
    hash[char] += 1
  end

  word2.each_char do |char|
    hash[char] -= 1
  end

  hash.values.all? { |val| val == 0 }
end

p bonus_anagram?("sally", "yllas")
