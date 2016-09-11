require "lib"

class: Foo() {

  foobar = true;

  update = function(dt)
  end;

  draw = function()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 100, 100, 100, 200)
  end;

  filtered_method = function(d)
    print("yay! : " .. d)
  end;
}

local foo = new: Foo()

event: filtered_method(nil, "yay, argument!")
