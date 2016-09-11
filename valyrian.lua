require "deepcopy"

local _things = {}
local _instances = {}

local function call_index(t, func, ...)
  local args = {...}
  if #args > 0 then
    return getmetatable(t).__index(nil, func)(nil, ...)
  end
  return function(...)
    return getmetatable(t).__index(nil, func)(nil, ...)
  end
end

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

class = setmetatable({}, {
  __call     = call_index,
  __newindex = function() end,
  __type     = "thing",
  __parents  = {},
  __index    = function(_, k)
    return function(_, ...)
      if _things[n] then
        error("trying to redefine class '" .. k .. "'!")
      end
      if parent then
        print("inherit from: " .. parent)
      end

      local parents = {...}

      return function(body)
        if type(body) == "table" then
          if body.self ~= nil then
            error "class can't contain 'self'!"
          end
          _things[k] = body
          for _, p in ipairs(parents) do
            for n, v in pairs(_things[p]) do
              _things[k][n] = v
            end
          end
        else
          error("trying to define class '" .. k .. "' with no body!")
        end
      end
    end
  end,
})

new = setmetatable({}, {
  __call     = call_index,
  __newindex = function() end,
  __index    = function(_, n)
    return function(_, ...)
      if not _things[n] then
        error("trying to instantiate undefined class '" .. n .. "'!")
      end
      local instance = {}
      local data     = table.deepcopy(_things[n], { function_env = instance }, {
        ["userdata"] = function(stack, orig, copy, state, arg1, arg2)
          return orig, true
        end,
      })
      _instances[instance] = setmetatable(instance, {
        __index = function(t, k)
          if k == "self" then
            return instance
          else
            return data[k] or (_ENV or _G)[k]
          end
        end,
        __newindex = function(t, k, v)
          data[k] = v
        end,
        __type = n,
      })
      if instance.awake then
        instance.awake(...)
      end
      return instance
    end
  end,
})

remove = function(instance, ...)
  if not instance then
    error "trying to remove nil!"
  end
  _instances[instance] = nil
  if instance.kill then
    return instance.kill(...)
  end
end

event = setmetatable({}, {
  __call     = call_index,
  __newindex = function() end,
  __index    = function(_, method)
    return function(_, ...)
      local r = {}
      for instance in pairs(_instances) do
        if instance[method] then
          r[instance] = instance[method](...)
        end
      end
      return r
    end
  end,
})
