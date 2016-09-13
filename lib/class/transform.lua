class: Transform2D() {
  awake = function(pos, sca, rot)
    pos = pos or {}
    sca = sca or {}
    rot = rot or 0

    self.position = new: Vector(pos.x or 0, pos.y or 1)
    self.rotation = rot
    self.scale    = new: Vector(sca.x or 1, sca.y or 1)
  end;

  translate = function(dx, dy)
    self.position.x = self.position.x + dx
    self.position.y = self.position.y + dy
  end;

  rotate = function(dr)
    self.rotation = self.rotation + dr
  end;

  scale = function(dx, dy)
    self.scale.x = self.scale.x + dx
    self.scale.y = self.scale.y + dy
  end;

  point_towards = function(point)
    self.rotation = math.atan2(point.y - self.position.y, point.x - self.position.x)
  end;

  translate_towards = function(point, s)
    point_towards(point)
    translate(math.cos(self.rotation) * s, math.sin(self.rotation) * s)
  end;
}
