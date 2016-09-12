class: Timer() {
  awake = function(f, a, depencies)
    self.f = f or function() end
    self.a = a or 0
    self.depencies = depencies or {}
  end;

  trigger = function()
    r = self.f(self.depencies)
    if r then
      self.a = r
    else
      kill: self()
    end
  end;

  update = function(dt)
    self.a = self.a - dt
    if self.a <= 0 then
      self:trigger()
    end
  end;
}
