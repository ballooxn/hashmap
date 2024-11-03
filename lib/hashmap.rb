class HashMap
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
    hashes.each { |v| set(v[0], v[1]) }
  end

  def set(key, value)
    grow_table if length.positive? && (length.to_f / @table.length) >= LOAD_FACTOR
    hash_code = hash(key)
    bucket = @table[hash_code]

    if bucket.nil?
      @table[hash_code] = { key => value }
    elsif bucket.is_a?(Hash) && @table[hash_code].key?(key)
      @table[hash_code][key] = value
    elsif bucket.is_a?(Array)
      @table[hash_code].push({ key => value })
    else
      prev_hash = @table[hash_code]
      @table[hash_code] = [prev_hash, { key => value }]
    end
  end

  def get(key)
    hash_code = hash(key)
    bucket = @table[hash_code]
    return nil if @table[hash_code].nil?

    if bucket.is_a?(Array)
      @table[hash_code].each { |h| return h.values if h.key?(key) }
    elsif bucket.key?(key)
      @table[hash_code][key]
    end
  end

  def has?(key)
    hash_code = hash(key)
    bucket = @table[hash_code]
    return false if @table[hash_code].nil?

    if bucket.is_a?(Array)
      bucket.any? { |h| h.key(key) }
    else
      bucket.key?(key)
    end
  end

  def remove(key)
    hash_code = hash(key)
    bucket = @table[hash_code]

    return nil if @table[hash_code].nil?

    if bucket.is_a?(Array)
      @table[hash_code].delete_if { |h| h.key?(key) }
    elsif bucket.key?(key)
      @table[hash_code] = nil
      bucket
    end
  end

  def length
    @table.reduce(0) do |sum, v|
      sum + (if v.is_a?(Array)
               v.length
             else
               (v.nil? ? 0 : 1)
             end)
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
