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
        my_each { |x| return false if yield(x) == false}
        return true
    end
    
    def my_any?
        my_each { |x| return true if yield(x)==true}
        return false
    end
    
    def my_none?
        my_each { |x| return false if yield(x)== true}
        return true
    end
    
    def my_count(n=nil)
        number = 0
        if block_given?
            my_each do |x|
                if yield(x)== true
                    number += 1
                end
            end
            number 
        elsif n != nil
            my_each do |x|
                if x == n
                    number += 1
                end
            end
            number
        else
            number = self.length
        end
        return number
    end
    puts [1, 2, 4, 2].my_count (2)
    def my_map

    end

    def my_inject

    end
end
