require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = bucket(key)
    list.include?(key)
  end

  def set(key, val)
    if count >= num_buckets
      resize!
    end

    if include?(key)
      list = bucket(key)
      list.update(key, val)
    else
      list = bucket(key)
      list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    list = bucket(key)
    list.get(key)
  end

  def delete(key)
    list = bucket(key)
    list.remove(key)
    @count -= 1
  end

  def each
    @store.each do |linked_list|
      linked_list.each do |link|
        yield(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.flatten.each do |linked_list|
      # possibly iterate through linked_list
      linked_list.each do |link|
        set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    bucket_index = key.hash % num_buckets
    @store[bucket_index]
    # optional but useful; return the bucket corresponding to `key`
  end
end
