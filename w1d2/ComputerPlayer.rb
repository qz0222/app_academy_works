class ComputerPlayer
  attr_accessor :name, :guessed_pos, :size, :revealed_pos, :value_hash, :unknown_pos

    def initialize(name)
      @name = name
      @guessed_pos = []
      @size = 0
      @revealed_pos = []
      @value_hash = Hash.new{[]}
      @unknown_pos = []
    end

    def full_pos(size)
      ans = []
      i = 0
      while i < size
        j = 0
        while j < size
          ans << [i,j]
          j += 1
        end
        i += 1
      end
      ans
    end

    def update_pos(full_pos)
      new_pos= full_pos.select do |pos|
        revealed_pos.include?(pos) == false
      end
      return new_pos.select do |pos|
        value_hash.values.each do |value|
          value.include?(pos) == false
        end
      end
    end


    def take_position
      self.unknown_pos = update_pos(full_pos(self.size))
      ("A".."Z").each do |key|
        if self.value_hash.has_key?(key) && self.value_hash[key].length == 2
          if self.value_hash[key][0] != self.guessed_pos
            return self.value_hash[key][0]
          else
            return self.value_hash[key][1]
          end
        end
      end
      position = self.unknown_pos.sample
      until valid_move?(position)
        position = self.unknown_pos.sample
      end
      return position

    end

    def valid_move?(position)
      return false if self.guessed_pos == position
      true
    end



end

{ "A" => [[1,1][0,1]], }
