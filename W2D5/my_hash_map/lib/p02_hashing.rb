class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      result = result ^ (el.hash + idx.hash)
    end
    result
  end
end

class String
  def hash

    result = 0
    self.chars.each_with_index do |char, idx|
      result = result ^ (char.ord.hash + idx.hash)
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.each do |key, value|
      result = result ^ (key.hash + value.hash)
    end
    result
  end
end
