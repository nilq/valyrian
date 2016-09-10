local _things = setmetatable({}, {
  __index = function(t, k)
    error "trying to reference undefined thing!"
  end
})

local _type = type
function type(n)
  local mt = {}
  if _type(n) == "table" then
    mt = getmetatable(n) or mt
  end
  if _type(rawget(mt, "__type")) == "string" then
    return rawget(meta, "__type")
  end
  return _type(n)
end

function struct(n)
  if rawget(_things, n) ~= nil then
    local t = getmetatable(rawget(_things, n)).__type
    error("trying to redefine " .. t .. " : " .. n .. "!")
  end
  _things[n] = {}
  setmetatable(_things[n], {
    __type   = "struct",
    __object = n,
    __parents = {},
  })
  local ft = setmetatable({}, {
    __call = function(t, body, _)
      if _ then
        body = _
      end
      if type(body) == "table" then
        for k, v in pairs(body) do
          _things[n][k] = v
        end
        getmetatable(_things[n]).__newindex = function() end
      else
        error "trying to define struct with no body!"
      end
    end,
    __index = function(t, parent)
      local mt = getmetatable(_things[n])
      table.insert(mt.__parents, parent)
      for k, v in pairs(_things[parent]) do
        if k == parent then
          _things[n][n] = v
        else
          _things[n][k] = v
        end
      end
      return ft
    end,
  })
  return ft
end
