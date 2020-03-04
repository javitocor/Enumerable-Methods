module Enumerable
    def my_each
        if block_given?
            for x in self do
                yield (x)
            end
        end
        return self
    end
    
    def my_each_with_index
        if block_given?
            idx = 0
            for x in self do
                yield(x, idx)
                idx += 1                
            end           
        end
        return self
    end
    
    def my_select
        if block_given?
        array=[]
        for x in self do
            if yield(self[x]) == true
                array.push(self[x])
            end
        end
        return array
        end
    end
    
    def my_all?
        self.my_each { |x| return false if yield(x) == false}
        return true
    end
    
    def my_any?
        self.my_each { |x| return true if yield(x)==true}
        return false
    end
    
    def my_none?
        self.my_each { |x| return false if yield(x)== true}
        return true
    end
    
    def my_count(n=nil)
        number = 0
        if block_given? 
            self.my_each do |x|
                if yield(x)== true
                    number += 1
                end
            end            
        elsif n != nil
            self.my_each do |x|
                if x == n
                    number += 1
                end
            end            
        else
            number = self.length
        end
        return number
    end
    
    def my_map
        arr = []
        if block_given?
            self.my_each do |x|
                arr.push(yield(x))
            end
        end
        arr
    end
    
    def my_inject(n=nil)
        if n == nil
            acc = self[0]
            for x in 1...self.length
                acc = yield(acc, self[x])
            end
            return acc
        else
            acc = n
            for x in 0...self.length
                acc = yield(acc, self[x])
            end
            return acc
        end
    end    
    
end

# Most of those examples comes from https://apidock.com/ruby/ 

puts "my_each"

[1,2,3,4,"hi"].my_each do |x|
    puts x
end

puts "--------------------------"
puts "my_each_with_index"

[1,2,3,4,"hi"].my_each_with_index { |value, index| puts "#{value} => #{index}"} 

puts "--------------------------"
puts "my_select"

result = [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
puts result

puts "--------------------------"
puts "my_all?"

puts %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].all?(/t/)                        #=> false
puts [1, 2i, 3.14].all?(Numeric)                       #=> true
puts [nil, true, 99].all?                              #=> false
puts [].all?                                           #=> true

puts "--------------------------"
puts "my_any??"

puts %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].any?(/d/)                        #=> false
puts [nil, true, 99].any?(Integer)                     #=> true
puts [nil, true, 99].any?                              #=> true
puts [].any?                                           #=> false

puts "--------------------------"
puts "my_none?"

puts %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
puts %w{ant bear cat}.none?(/d/)                        #=> true
puts [1, 3.14, 42].none?(Float)                         #=> false
puts [].none?                                           #=> true
puts [nil].none?                                        #=> true
puts [nil, false].none?                                 #=> true
puts [nil, false, true].none?                           #=> false

puts "--------------------------"
puts "my_count"

ary = [1, 2, 4, 2]
puts ary.my_count                #=> 4
puts ary.my_count(2)            #=> 2
puts ary.my_count{ |x| x%2==0 } #=> 3

puts "--------------------------"
puts "my_map"

puts (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
puts (1..4).my_map { "dog"  }   #=> ["cat", "cat", "cat", "cat"]

puts "--------------------------"
puts "my_inject"

longest = %w{ cat sheep bear }.my_inject do |memo, word|
    memo.length > word.length ? memo : word
 end

puts longest               #=> "sheep"
puts (5..10).inject { |sum, n| sum + n }      #=> 45
puts (5..10).inject(2) { |sum, n| sum + n }      #=> 47

puts "--------------------------"
puts "multiply_els"

def multiply_els(array)
    array.my_inject { |product, n| product * n }
end

puts multiply_els([2,4,5])    #=> 40

puts "--------------------------"
puts "my_map_proc_block"


