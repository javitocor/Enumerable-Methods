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
        if n = nil
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
