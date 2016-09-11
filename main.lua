require "valyrian"

class: Foo() {
  hello = "I am Foo's value!";
}

class: Bar("Foo") {
  awake = function()
    print(self.hello)
  end;
}

local bar = new: Bar()
