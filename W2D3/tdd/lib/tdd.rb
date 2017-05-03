class Array

  def my_uniq
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end
    result
  end

  def two_sum
    result = []
    self.each_with_index do |el, i|
      (i + 1...self.length).each do |i2|
        result << [i, i2] if el + self[i2] == 0
      end
    end
    result
  end

  def my_transpose
    result = []
    self[0].each_with_index do |el, i|
      sub_arr = [el]
      self[1..-1].each do |el2|
        sub_arr << el2[i]
      end
      result << sub_arr

    end
    result
  end

  def stock_picker
    profit = 0
    result = nil
    self.each_with_index do |buy, i|
      self[i..-1].each_with_index do |sell, j|
        if sell - buy > profit
          profit = sell - buy
          result = [i, j]
        end
      end
    end
    result
  end
end
