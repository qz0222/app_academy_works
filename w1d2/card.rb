class Card

attr_accessor :value, :reveal_status

  def initialize
    @value = value
    @reveal_status = false
  end

  def hide
    @reveal_status = false
  end

  def reveal
    @reveal_status = true
  end

  def revealed?
    @reveal_status
  end

  def display
    if revealed?
      print "|#{self.value}|"
    else
      print "| |"
    end
  end

end
