module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    my_each do |x|
      yield x
    end
    self
  end

  def my_each_with_index
    return to_enum __method__ unless block_given?

    idx = 0
    my_each do |x|
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

  def my_all?(arg = nil)
    return true if !block_given? && arg.nil? && include?(nil) == false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |x| return false if yield(x) == false }
    elsif arg.class == Regexp
      my_each { |x| return false if arg.match(x).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |x| return false if x != arg }
    else
      my_each { |x| return false if (x.is_a? arg) == false }
    end
    true
  end

  def my_any?(arg = nil)
    return true if !block_given? && arg.nil? && include?(nil) != false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |x| return true if yield(x) == true }
    elsif arg.class == Regexp
      my_each { |x| return true unless arg.match(x).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |x| return true if x == arg }
    else my_each { |x| return true if x.class <= arg }
    end
    false
  end

  def my_none?(arg = nil)
    return true if !block_given? && arg.nil? && include?(true) == false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |x| return false if yield(x) == true }
    elsif arg.class == Regexp
      my_each { |x| return false unless arg.match(x).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |x| return false if x == arg }
    else
      my_each { |x| return false if x.class <= arg }
    end
    true
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

  def my_map(proc = nil)
    return to_enum(:my_map) if !block_given? && proc.nil?

    arr = []
    if !proc.nil?
      my_each do |x|
        arr.push(proc.call(x))
      end
    else
      my_each do |x|
        arr.push(yield(x))
      end
    end
    arr
  end

  def my_inject(par = nil)
    array = to_a
    if par.nil?
      acc = array[0]
      array[1...array.length].my_each do |x|
        acc = yield(acc, x)
      end
    else
      acc = par
      array.my_each do |x|
        acc = yield(acc, x)
      end
    end
    acc
  end
end
def multiply_els(array)
  array.my_inject { |product, n| product * n }
end
