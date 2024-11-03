class Hashmap
  LOAD_FACTOR = 0.8

  def initialize
    @table = Array.new(16)
  end

  def hash(key)
    code = 0
    prime = 31

    key.each_char { |char| code = (prime * code) + char.ord }

    code % @table.length
  end

  def set(key, value)
    hash_code = hash(key)

    if @table[hash_code].nil? || @table[hash_code].keys.join == key
      @table[hash_code] = { key => value }

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
      @table[hash_code].each { |h| return true if h.keys.join == key }
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
        sum + v.reduce { |s, v| s + 1 unless v.nil? }
      else
        sum + 1
      end
    end
  end

  def clear
  end

  def keys
  end

  def values
  end

  def entries
  end
end
