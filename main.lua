require "lib"

class: Foo() {

  foobar = true;
  x = 0;

  update = function(dt)

  end;

  draw = function()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", self.x, 100, 100, 200)
  end;

  filtered_method = function(d)
    print("yay! : " .. d)
  end;
}

local foo = new: Foo()

timer = new: Timer(function()
  print "Hello, I'm a fucking timer.. tick tock"
  return 2
end, 0)

event: filtered_method("yay, argument!")
