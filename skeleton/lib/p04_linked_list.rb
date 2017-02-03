class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @sentinel = Link.new
    @sentinel.next, @sentinel.prev = @sentinel, @sentinel
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next == @sentinel
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)

    if self.empty?
      @sentinel.next = new_link
      @sentinel.prev = new_link
      new_link.prev = @sentinel
      new_link.next = @sentinel
    else
      last.next = new_link
      new_link.prev = last
      new_link.next = @sentinel
      @sentinel.prev = new_link
    end
  end

  def update(key, val)
    self.each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    link_to_remove = nil
    self.each do |link|
      link_to_remove = link if link.key == key
    end

    link_to_remove.prev.next = link_to_remove.next
    link_to_remove.next.prev = link_to_remove.prev
  end

  def each(&blk)
    current_link = @sentinel.next
    until current_link == @sentinel
      blk.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
