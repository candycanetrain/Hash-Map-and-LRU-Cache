class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, i|
      result += (el.hash * (i + 1)) ** 2
    end
    result
  end
end

class String
  def hash
    result = 0
    self.chars.each_with_index do |el, i|
      result += (el.ord + i)**2
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.each do |k, v|
      k_num = k.hash
      v_num = v.hash

      result += (k_num + v_num) ** 2 + 45 - (k_num)

    end
    result
  end
end
