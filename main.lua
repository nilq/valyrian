require "valyrian"
struct "foo" {
  x = 110,
  y = 0,
}
class "Foo" {
  Foo = function(self)
    print("Constructed!")
  end;
}
local instance = new "Foo"
