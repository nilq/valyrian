class: Camera("Transform2D") {
  set = function()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(1 / self.scale.x, 1 / self.scale.y)
    love.graphics.translate(-self.position.x, -self.position.y)
  end;

  unset = function()
    love.graphics.pop()
  end;

  view_width = function()
    return love.graphics.getWidth() * self.scale.x
  end;

  view_height = function()
    return love.graphics.getHeight() * self.scale.y
  end;

  view_size = function()
    return self.view_width(), self.view_height()
  end;
}
