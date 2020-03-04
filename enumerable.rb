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
            for x in self do
                yield (x)                
            end
            for y in self do
                y.index(self[x]).to_i
            end
        end
        return self
    end
    ['a', 'b', 'c'].my_each_with_index { |el, i| puts i }
    def my_select

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
