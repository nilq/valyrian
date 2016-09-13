-- bump.lua wrapper
class: World() {
  awake = function(grid)
    grid = grid or 64

    local bump = require "lib/depencies/bump"
    self.bump = bump.newWorld(grid)
  end;
  add = function(obj, position, dimension)
    self.bump:add(obj, position.x, position.y, dimension.x, dimension.y)
  end;
  remove = function(obj)
    self.bump:remove(obj)
  end;
  move = function(obj, position, filter)
    local x, y, cols, len = self.bump:move(obj, position.x, position.y, filter)
    return new: Vector(x, y), cols, len
  end;
  change = function(obj, position, dimension)
    self.bump:update(obj, position.x, position.y, dimension.x, dimension.y)
  end;
  check = function(obj, position, filter)
    local x, y, cols = self.bump:move(obj, position.x, position.y, filter)
    return new: Vector(x, y), cols, len
  end;
}
