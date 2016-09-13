class: Vector() {
  body = {};
  awake = function(...)
    for i, v in ipairs({...}) do
      -- for fanciness:
      if i == 1 then
        self.x = v
      elseif i == 2 then
        self.y = v
      elseif i == 3 then
        self.z = v
      elseif i == 4 then
        self.w = v
      end
      self.body[#self.body + 1] = v
    end
  end;
  magnitude = function()
    local r = 0
    for n = 1, #self.body do
      r = r + self.body[n]^2
    end
    return math.sqrt(r)
  end;
  magnitude_squared = function()
    local r = 0
    for n = 1, #self.body do
      r = r + self.body[n]^2
    end
    return r
  end;
  dot = function(b)
    for n = 1, #self.body do
      self.body[n] = self.body[n] * b.body[n]
      if n == 1 then
        self.x = self.body[n]
      elseif n == 2 then
        self.y = self.body[n]
      elseif n == 3 then
        self.z = self.body[n]
      elseif n == 4 then
        self.w = self.body[n]
      end
    end
    return self
  end;
  subtract = function(b)
    for n = 1, #self.body do
      self.body[n] = self.body[n] - b.body[n]
      if n == 1 then
        self.x = self.body[n]
      elseif n == 2 then
        self.y = self.body[n]
      elseif n == 3 then
        self.z = self.body[n]
      elseif n == 4 then
        self.w = self.body[n]
      end
    end
    return self
  end;
  add = function(b)
    for n = 1, #self.body do
      self.body[n] = self.body[n] + b.body[n]
      if n == 1 then
        self.x = self.body[n]
      elseif n == 2 then
        self.y = self.body[n]
      elseif n == 3 then
        self.z = self.body[n]
      elseif n == 4 then
        self.w = self.body[n]
      end
    end
    return self
  end;
  divide = function(b)
    for n = 1, #self.body do
      self.body[n] = self.body[n] / b.body[n]
      if n == 1 then
        self.x = self.body[n]
      elseif n == 2 then
        self.y = self.body[n]
      elseif n == 3 then
        self.z = self.body[n]
      elseif n == 4 then
        self.w = self.body[n]
      end
    end
    return self
  end;
}
