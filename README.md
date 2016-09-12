# valyrian

this library is quite fancy indeed.

---

Example with a moving cube ...
```lua
require "lib"

class: Entity() {
  awake = function(image, x, y)
    self.image    = love.graphics.newImage(image)
    self.position = new: Vector(x, y)
    self.velocity = new: Vector(0, 0)
  end;

  update = function(self, dt)
    self.position.x = self.position.x + self.velocity.x * dt
    self.position.y = self.position.y + self.velocity.y * dt
  end;

  draw = function()
    love.graphics.draw(self.image)
  end;
}

class: Player("Entity") {
  speed = 300;
  update = function(dt)
    super:update(self, "Entity", self, dt)
    local dx = 0
    local dy = 0
    if input.isDown("d") then
      dx = self.speed
    elseif input.isDown("a") then
      dx = -self.speed
    end
    if input.isDown("w") then
      dy = -self.speed
    elseif input.isDown("s") then
      dy = self.speed
    end
    self.velocity.x = dx
    self.velocity.y = dy
  end;
}

local player = new: Player("path/to/image.png", 100, 300)
```
---

