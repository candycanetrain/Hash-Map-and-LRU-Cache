require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)

    if count >= num_buckets
      resize!
    end
    unless self.include?(key)
      @store[bucket_index(key)] << key
      @count += 1
    end
  end

  def include?(key)
    @store[bucket_index(key)].include?(key)
  end

  def remove(key)
    @store[bucket_index(key)].delete(key) if self.include?(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    @count = 0
    old_store.flatten.each do |el|
      @store.insert(el)
    end
  end

  def bucket_index(key)
    num = key.hash
    bucket_idx = num % num_buckets
    #returns index for @store
  end
end
