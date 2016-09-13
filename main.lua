require "lib"
local thing = new: Vector(100, 100)
local thing2 = new: Vector(1, 1)

thing.add(thing2)

print(thing.x, thing.y)
