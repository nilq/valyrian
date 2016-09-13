# valyrian

A library approaching LÖVE game development with a class-based object oriented
point of view.

---

List of things that needs improvement:
1. *super* : A better thing for accessing parent class methods

---

Example - Moving a rectangle:

```lua
require "lib"

class: Player("Transform2D") {
  speed = 200;
  update = function(dt)
    local dx, dy = 0, 0
    if input.isDown("d") then
      dx = self.speed
    elseif input.isDown("a") then
      dx = -self.speed
    end
    if input.isDown("s") then
      dy = self.speed
    elseif input.isDown("w") then
      dy = -self.speed
    end
    self.translate(dx * dt, dy * dt)
  end;

  draw = function()
    love.graphics.rectangle("fill", self.position.x, self.position.y, 100, 100)
  end;
}

local player = new: Player({x = 100, y = 300,})
```
---
