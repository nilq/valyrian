class: Input() {
  keys = {};

  update = function()
    self.mouse = {
      x = love.mouse.getX(),
      y = love.mouse.getY(),
    }
  end;

  keypressed = function(key, scancode, isrepeat)
    self.keys[key] = true
    event:keychanged(key, true)
  end;

  keyreleased = function(key, scancode, isrepeat)
    self.keys[key] = false
    event:keychanged(key, false)
  end;

  mousepressed = function(x, y, button, istouch)
    event:mousechanged(x, y, button, isTouch, true)
  end;

  mousereleased = function(x, y, button, istouch)
    event:mousechanged(x, y, button, isTouch, false)
  end;

  isDown = function(key)
    return self.keys[key] or false
  end;

  isDownAny = function(keys)
    for _, key in ipairs(self.keys) do
      if self:isDown(key) then
        return true
      end
    end
    return false
  end;

  isDownAll = function(keys)
    for _, key in ipairs(self.keys) do
      if not self:isDown(key) then
        return false
      end
    end
    return true
  end;
}
