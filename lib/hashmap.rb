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
  end

  def remove(key)
  end

  def length
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
