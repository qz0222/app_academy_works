class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
  end

  def my_select(&prc)
    answer = []

    self.my_each{|el|
      answer << el if prc.call(el) == true
    }

    answer
  end

  def my_reject(&prc)
    answer = []

    self.my_each{|el|
      answer << el unless prc.call(el) == true
    }

    answer
  end

  def my_any?(&prc)
    self.my_each{|el|
      return true if prc.call(el)
    }
    return false
  end

  def my_flatten
    answer=[]
    self.my_each{|el|
      if el.is_a?(Array)
        el.my_flatten.my_each{|el|
          answer << el

        }
      else
        answer << el
      end
    }
    print answer
    answer
  end

  def my_zip(*arg)
    #arg is array of all inputs
    answer = []
    i = 0
    while i < self.length
      holder = []
      holder << self[i]
      arg.my_each{|y|
        holder << y[i]
      }
      answer << holder
      i+=1
    end

    answer
  end

  def my_rotate(num=1)
    answer = []
    i = 0
    while i < self.length
      j = (i - num) % self.length
      answer[j] = self[i]
      i += 1
    end
    answer
  end

  def my_rotate_2(num=1)
    (num%self.length).times do
      self.push(self.shift)
    end

    self
  end

  def my_join(joiner="")
    ans = ""
    i = 0
    while i < self.length - 1
      ans << self[i]
      ans << joiner
      i += 1
    end
    ans << self.last
    ans
  end

  def my_reverse
    answer = []
    i = self.length - 1
    while i >= 0
      answer << self[i]

      i -= 1
    end

    answer
  end



end
