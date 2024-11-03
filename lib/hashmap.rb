class Hashmap
  LOAD_FACTOR = 0.75

  def initialize
    @table = Array.new(16)
  end

  def hash(key)
    code = 0
    prime = 31

    key.each_char { |char| code = (prime * code) + char.ord }

    code % @table.length
  end

  def grow_table
    hashes = entries

    @table = Array.new(@table.length * 2)
    p @table.length
    hashes.each do |v|
      set(v[0], v[1])
    end

    p @table
  end

  def set(key, value)
    occupied_length = length
    current_load = (occupied_length / @table.length.to_f).round(2)
    grow_table if !occupied_length.zero? && current_load >= LOAD_FACTOR

    hash_code = hash(key)

    if @table[hash_code].nil?
      @table[hash_code] = { key => value }
    elsif !@table[hash_code].is_a?(Array) && @table[hash_code].keys.join == key
      @table[hash_code][key] = value

    elsif @table[hash_code].is_a?(Array)
      @table[hash_code].push({ key => value })

    elsif !@table[hash_code].nil? && @table[hash_code].keys.join != key
      prev_hash = @table[hash_code]
      @table[hash_code] = Array.new(2)
      @table[hash_code][0] = prev_hash
      @table[hash_code][1] = { key => value }
    else
      puts "ERROR!!!!"
    end
  end

  def get(key)
    hash_code = hash(key)

    if @table[hash_code].nil?
      return nil
    elsif @table[hash_code].is_a?(Array)
      @table[hash_code].each { |h| return h.values if h.keys.join == key }
    elsif @table[hash_code].keys.join == key
      return @table[hash_code][key]
    end

    nil
  end

  def has?(key)
    hash_code = hash(key)
    if @table[hash_code].nil?
      return false
    elsif @table[hash_code].is_a?(Array)
      @table[hash_code].each do |h|
        next if h.nil?
        return true if h.keys.join == key
      end
    elsif @table[hash_code].keys.join == key
      return true
    end

    false
  end

  def remove(key)
    hash_code = hash(key)

    if @table[hash_code].nil?
      return nil
    elsif @table[hash_code].is_a?(Array)
      @table[hash_code].each_with_index do |h, i|
        if h.keys.join == key
          @table[hash_code][i] = nil
          return h
        end
      end
    elsif @table[hash_code].keys.join == key
      entry = @table[hash_code]
      @table[hash_code] = nil
      return entry
    end

    nil
  end

  def length
    @table.reduce(0) do |sum, v|
      if v.nil?
        sum + 0
      elsif v.is_a?(Array)
        v.each { |_| sum += 1 }
        sum
      else
        sum + 1
      end
    end
  end

  def clear
    @table = Array.new(16)
  end

  def keys
    @table.reduce([]) do |arr, v|
      if v.nil?
        arr
      elsif v.is_a?(Array)
        v.each do |hash|
          next if hash.nil?

          arr.push(hash.keys.join)
        end
        arr
      else
        arr.push(v.keys.join)
      end
    end
  end

  def values
    @table.reduce([]) do |arr, v|
      if v.nil?
        arr
      elsif v.is_a?(Array)
        v.each do |hash|
          next if hash.nil?

          arr.push(hash.values.join)
        end
        arr
      else
        arr.push(v.values.join)
      end
    end
  end

  def entries
    @table.reduce([]) do |arr, v|
      if v.nil?
        arr
      elsif v.is_a?(Array)
        v.each { |hash| arr.push([hash.keys.join, hash.values.join]) }
        arr
      else
        arr.push([v.keys.join, v.values.join])
      end
    end
  end
end
