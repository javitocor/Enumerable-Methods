module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
      for x in self
        yield x
      end    
    self
  end
  
  def my_each_with_index
    return Enumerator if !block_given?
      idx = 0
      for x in self
        yield(x, idx)
        idx += 1
      end
    self
  end

  def my_select
    return Enumerator unless block_given?

    array = []
    my_each do |x|
      array.push(self[x]) if yield(self[x]) == true
    end
    array
  end

  def my_all? (arg=nil)    
    return true if !block_given? && arg == nil && self.include?(nil) == false
    return false unless block_given? || arg != nil 
    if block_given?
      self.my_each { |x| return false if yield(x) == false }
      true
    elsif arg.class == Regexp
      self.my_each { |x| return false if arg.match(x) == false }
      true
    else
      self.my_each { |x| return false if x != arg }
      true
    end
  end

  def my_any? (arg=nil) 
    return true if !block_given? && arg == nil && self.include?(nil) != false
    return false unless block_given? || arg != nil 
    if block_given?
      my_each { |x| return true if yield(x) == true }
      false
    elsif arg.class == Regexp
      my_each { |x| return true if arg.match(x) == true }
      false
    else
      my_each { |x| return true if x == arg }
      false
    end
    
  end

  def my_none? (arg=nil) 
    return true if !block_given? && arg == nil && self.include?(true) == false
    return false unless block_given? || arg != nil 
    if block_given?
      my_each { |x| return false if yield(x) == true }
      true
    elsif arg.class == Regexp
      my_each { |x| return false if arg.match(x) == true }
      true
    else
      my_each { |x| return false if x == arg }
      true
    end
    
  end

  def my_count(par = nil)
    number = 0
    if block_given?
      my_each do |x|
        number += 1 if yield(x) == true
      end
    elsif !par.nil?
      my_each do |x|
        number += 1 if x == par
      end
    else
      number = length
    end
    number
  end

  def my_map(proc=nil)
    return to_enum(:my_map) if !block_given? && proc == nil
    arr = []
    if  proc != nil 
      self.my_each do |x|
        arr.push(proc.call(x))
      end
    else
      self.my_each do |x|
        arr.push(yield(x))
      end
    end
    arr
  end

  def my_inject(par = nil)
    if par.nil? 
      array = self.to_a     
      acc = array[0]
      for x in array[1...array.length]
        acc = yield(acc, x)
      end
      acc
    else
      array = self.to_a
      acc = par
      array.my_each do |x| 
        acc = yield(acc, x)
      end
      acc
    end
  end
end

def multiply_els(array)
  array.my_inject { |product, n| product * n }
end