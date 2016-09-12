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
    assert(type(b) == type(self.body), "can't dot 'vector' with 'non-vector'!")
    assert(#self.body == #b, "can't dot 'vectors' of different dimensions!")
    for n = 1, #self.body do
      self.body[n] = self.body[n] * b[n]
    end
    return self
  end;
  subtract = function(b)
    assert(type(b) == type(self.body), "can't subtract 'vector' with 'non-vector'!")
    assert(#self.body == #b, "can't subtract 'vectors' of different dimensions!")
    for n = 1, #self.body do
      self.body[n] = self.body[n] - b[n]
    end
    return self
  end;
  add = function(b)
    assert(type(b) == type(self.body), "can't add 'vector' with 'non-vector'!")
    assert(#self.body == #b, "can't add 'vectors' of different dimensions!")
    for n = 1, #self.body do
      self.body[n] = self.body[n] + b[n]
    end
    return self
  end;
  divide = function(b)
    assert(type(b) == type(self.body), "can't divide 'vector' with 'non-vector'!")
    assert(#self.body == #b, "can't divide 'vectors' of different dimensions!")
    for n = 1, #self.body do
      self.body[n] = self.body[n] / b[n]
    end
    return self
  end;
}
