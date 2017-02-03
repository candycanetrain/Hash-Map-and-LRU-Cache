require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.between?(0,@max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @length = num_buckets
  end

  def insert(num)
    i = index(num)
    self[i] << num
  end

  def remove(num)
    i = index(num)
    if self[i].include?(num)
      self[i].delete(num)
    end
  end

  def include?(num)
    i = index(num)
    self[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def index(num)
    num % @length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count >= num_buckets
      # byebug
      resize!
    end

    i = index(num)

    unless self[i].include?(num)
      self[i] << num
      @count += 1
    end
  end

  def remove(num)
    i = index(num)
    if self[i].include?(num)
      self[i].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    i = index(num)
    self[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    bigger_buckets = num_buckets * 2
    old_store = @store
    @count = 0
    @store = Array.new(bigger_buckets){Array.new}
    old_store.flatten.each do |el|
      insert(el)
    end
  end

  def index(num)
    num % num_buckets
  end
end
