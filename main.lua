require "valyrian"

class: Foo() {
  hello = "I am Foo's value!";
  awake = function()
    print "Inside of parent: Foo"
  end;
}

class: Bar("Foo") {
  awake = function()
    print(self);
    print(self.hello);
  end;
}

local bar = new: Bar()

super:awake(bar, "Foo")
