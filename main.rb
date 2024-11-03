require_relative "lib/hashmap"

test = Hashmap.new

test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")
test.set("frog", "green")
test.set("grape", "purple")
test.set("hat", "black")
test.set("ice cream", "white")
test.set("jacket", "blue")
test.set("kite", "pink")
test.set("lion", "golden")

p test.entries

test.set("moon", "silver")

puts test.get("moon")
p test.has?("lion")
p test.remove("lion")
p test.has?("lion")

p ""

p "#{test.length}\n"

p test.keys
p test.values
p test.clear
p test.entries
