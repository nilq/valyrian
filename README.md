# valyrian

\*insert clever introduction here\*

---

```lua
require "valyrian"

class: Animal() {
  mammal = true;
  carnivore = false;
  isMammal = function()
    return self.mammal
  end;
  isCarnivore = function()
    return self.carnivore
  end;
}

class: Duck("Animal") {
  mammal = true;
  carnivore = true;
}

local duck = new: Duck()

print(duck:isMammal(), duck:isCarnivore())
```

stdout:

```
$ true	true
```

---

