# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    each do |x|
      yield x
    end
    self
  end

  def my_each_with_index
    return to_enum __method__ unless block_given?

    idx = 0
    each do |x|
      yield(x, idx)
      idx += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each do |x|
      array.push(x) if yield(x) == true
    end
    array
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    return true if !block_given? && arg.nil? && include?(nil || false) == false 
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
    return true if !block_given? && arg.nil? && include?(nil || false) != false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |x| return true if yield(x) == true }
    elsif arg.class == Regexp
      my_each { |x| return true unless arg.match(x).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |x| return true if x == arg }
    else
      my_each { |x| return true if x.class <= arg }
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

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_count(par = nil)
    number = 0
    my_each do |x|
      if block_given?
        number += 1 if yield(x) == true
      elsif !par.nil?
        number += 1 if x == par
      else
        number = length
      end
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

  def my_inject(par = nil, sym = nil)
    array = to_a
    if block_given?
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
    else
      if !par.nil? && sym != nil
        acc = par
        self.my_each do |x|
        acc = acc.send(sym, x)
        end
      elsif !par.nil? && sym == nil
        acc = self[0]
        array[1...array.length].my_each do |x|
          acc = acc.send(par, x)
        end
      end
    end
    acc
  end
end
# rubocop:enable Metrics/ModuleLength
def multiply_els(array)
  array.my_inject { |product, n| product * n }
end

puts 'my_each'

[1, 2, 3, 4, 'hi'].my_each do |x|
  puts x
end
puts [2,4,7,11].my_each #<Enumerator: [2, 4, 7, 11]:my_each>

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_each_with_index'

[1, 2, 3, 4, 'hi'].my_each_with_index { |value, index| puts "#{value} => #{index}" }
puts [2,4,7,11].my_each_with_index  #<Enumerator: [2, 4, 7, 11]:my_each_with_index

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_select'

result = [1, 2, 3, 4, 5, 6].my_select(&:even?) #=> [2, 4, 6]
puts result
puts [1, 2].my_select { |num| num == 1 } #=> [1]
puts [2,4,7,11].my_select  #<Enumerator: [2, 4, 7, 11]:my_select>

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_all?'

puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_all?(/t/) #=> false
puts [1, 2i, 3.14].my_all?(Numeric) #=> true
puts [nil, true, 99].my_all? #=> false
puts [].my_all? #=> true
puts [nil, false, true, []].my_all? #=> false
puts [1, 2.5, 'a', 9].my_all?(Integer) #=> false
puts %w[dog door rod blade].my_all?(/d/) #=> true
puts [3,4,7,11].my_all?(3) #=> false
puts [1, false].my_all? #=> false

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_any??'

puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].my_any?(/d/) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false
puts [nil, false, true, []].my_any? #=> true
puts [1, 2.5, 'a', 9].my_any?(Integer) #=> true
puts %w[dog door rod blade].my_any?(/d/) #=> true
puts [3,4,7,11].my_any?(3) #=> true
puts [1, false].my_any? #=> true

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_none?'

puts %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
puts %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_none?(/d/) #=> true
puts [1, 3.14, 42].my_none?(Float) #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false
puts [nil, false, true, []].my_none? #=> false
puts [1, 2.5, 'a', 9].my_none?(Integer) #=> false
puts %w[dog door rod blade].my_none?(/d/) #=> false
puts [3,4,7,11].my_none?(3) #=> false

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_count'

ary = [1, 2, 4, 2]
puts ary.my_count #=> 4
puts ary.my_count(2) #=> 2
puts ary.my_count(&:even?) #=> 3

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_map'

puts (1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
puts (1..4).my_map { 'dog' } #=> ["dog", "dog", "dog", "dog"]
puts %w[a b c].my_map(&:upcase) #=> ["A", "B", "C"]
puts %w[a b c].my_map(&:class) #=> [String, String, String]
puts [2,4,7,11].my_map #<Enumerator: [2, 4, 7, 11]:my_map
my_proc = Proc.new {|num| num > 10 }
puts [18, 22, 5, 6] .my_map(my_proc) {|num| num < 10 } # true true false false

puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'my_inject'

longest = %w[cat sheep bear].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end

puts longest #=> "sheep"

puts (5..10).my_inject { |sum, n| sum + n } #=> 45
puts (5..10).my_inject(2) { |sum, n| sum + n } #=> 47
puts (1..5).my_inject(4) { |prod, n| prod * n } #=> 480
puts [1, 1, 1].my_inject(:+) #=> 3
puts [1, 1, 1].my_inject(2, :+) #=> 5


puts '-*-*-*-*-*-*-*-*-*-*-*-*-'
puts 'multiply_els'

puts multiply_els([2, 4, 5]) #=> 40
