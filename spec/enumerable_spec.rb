# spec/enumerable_spec.rb

require './lib/enumerable.rb'

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'returns every single element of an array ' do
      expect([1, 2, 3, 4, 'hi'].my_each { |x| print x }).to eql([1, 2, 3, 4, 'hi'])
    end
  end
  describe '#my_each_with_index' do
    it 'returns every single element of an array with its index' do
      expect([1, 2, 3, 4].my_each_with_index { |value, index| puts "#{value} => #{index}" }).to eql([1, 2, 3, 4])
    end
  end
  describe 'my_select' do
    it 'returns an array of elements that matches the block' do
      expect([1, 2, 3, 4, 5, 6].my_select(&:even?)).to eql([2, 4, 6])
    end
  end
  describe 'my_all?' do
    it 'returns true if all elements matches the block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'returns true if regexp matches all the elements' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end
    it 'returns true if all elements belongs to the same class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
    it 'returns true if any of the elements are false or nil' do
      expect([nil, true, 99].my_all?).to eql(false)
    end
    it 'returns true if the array is empty' do
      expect([].my_all?).to eql(true)
    end
    it 'returns true if all the elements match the parameter' do
      expect([3, 4, 7, 11].my_all?(3)).to eql(false)
    end
  end
  describe '#my_any?' do
    it 'returns true if any of the elements are true' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it 'returns true if any of the elements matches de regexp' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end
    it 'returns true if any of the elements belongs to the class given' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end
    it 'returns true if any of the elements are true' do
      expect([nil, true, 99].my_any?).to eql(true)
    end
    it 'returns false if the array passed is empty' do
      expect([].my_any?).to eql(false)
    end
    it 'returns true if any of the elements matches the pattern' do
      expect([3, 4, 7, 11].my_any?(3)).to eql(true)
    end
    it 'returns true if any of the elements matches the pattern' do
      expect([3, 4, 7, 11].my_any?(3)).to eql(true)
    end
  end
  describe '#my_none?' do
    it 'returns true if none of the elements matches the block' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(false)
    end
    it 'returns true if none of the elements matches the regexp' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
    end
    it 'returns true if none of the elements matches belongs to the class' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end
    it 'returns true if the array passed is empty' do
      expect([].my_none?).to eql(true)
    end
    it 'returns true if any of the elements are true' do
      expect([nil, false, true].my_none?).to eql(false)
    end
    it 'returns true if none of the elements matches the pattern' do
      expect([3, 4, 7, 11].my_none?(3)).to eql(false)
    end
  end
  describe '#my_count' do
    it 'returns the length of the array' do
      expect([1, 2, 4, 2].my_count).to eql(4)
    end
    it 'returns the number of elements that matches the pattern' do
      expect([1, 2, 4, 2].my_count(2)).to eql(2)
    end
    it 'returns the number of elements that matches the block' do
      expect([1, 2, 4, 2].my_count(&:even?)).to eql(3)
    end
  end
  describe '#my_map' do
    it 'returns a new array after the block is applied' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
    it 'returns a new array with the result of the Proc if a block and a Proc are passed' do
      my_proc = proc { |num| num > 10 }
      expect([18, 22, 5, 6] .my_map(my_proc) { |num| num < 10 }).to eql([true, true, false, false])
    end
    it 'returns a new array with the classes of each element of the array' do
      expect(%w[a b c].my_map(&:class)).to eql([String, String, String])
    end
  end
  describe '#my_inject' do
    it 'returns the result of the symbol given' do
      expect([1, 1, 1].my_inject(:+)).to eql(3)
    end
    it 'returns the result of the symbol given adding the initial pattern' do
      expect([1, 1, 1].my_inject(2, :+)).to eql(5)
    end
    it 'returns the result of the block adding the initial pattern' do
      expect((5..10).my_inject(2) { |sum, n| sum + n }).to eql(47)
    end
    it 'returns the result of the block' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end
  end
  describe '#multiply_els' do
    it 'multiplies the elements between each other' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
