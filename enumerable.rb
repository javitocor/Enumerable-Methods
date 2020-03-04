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

    end

    def my_any?

    end

    def my_none?

    end

    def my_count

    end

    def my_map

    end

    def my_inject

    end
end
