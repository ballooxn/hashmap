require_relative "lib/hashmap"

test = Hashmap.new

test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")

p test.get("elephant")
