module Enumerable
  def my_each
    if block_given?
      each do |x|
        yield x
      end
    end
    self
  end

  def my_each_with_index
    if block_given?
      idx = 0
      each do |x|
        yield(x, idx)
        idx += 1
      end
    end
    self
  end

  def my_select
    return unless block_given?

    array = []
    each do |x|
      array.push(self[x]) if yield(self[x]) == true
    end
    array
  end

  def my_all?
    my_each { |x| return false if yield(x) == false }
    true
  end

  def my_any?
    my_each { |x| return true if yield(x) == true }
    false
  end

  def my_none?
    my_each { |x| return false if yield(x) == true }
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

  def my_map()
    arr = []
    if block_given?
      my_each do |x|
        arr.push(yield(x))
      end
    end
    arr
  end

  def my_inject(par = nil)
    if par.nil?
      acc = self[0]
      (1...length).each do |x|
        acc = yield(acc, self[x])
      end

    else
      acc = par
      (0...length).each do |x|
        acc = yield(acc, self[x])
      end
      acc
    end
  end
end

def multiply_els(array)
  array.my_inject { |product, n| product * n }
end
