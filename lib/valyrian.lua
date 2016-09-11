require "lib/deepcopy"

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
  __type     = "class",
  __index    = function(_, k)
    return function(_, ...)
      if _things[k] then
        error("trying to redefine class '" .. k .. "'!")
      end

      local parents = {...}

      return function(body)
        if type(body) == "table" then
          if body.self ~= nil then
            error "class can't contain 'self'!"
          end
          _things[k] = body

          setmetatable(_things[k], {
            __parents = parents,
          })

          for _, p in ipairs(parents) do
            for n, v in pairs(_things[p]) do
              if _things[k][n] == nil then
                _things[k][n] = v
              end
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
        __parents = getmetatable(_things[n]).__parents,
      })
      if instance.awake then
        instance.awake(...)
      end
      return instance
    end
  end,
})

kill = function(instance, ...)
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
    return function(_, filter, ...)
      local r = {}
      for instance in pairs(_instances) do
        local args = {...}
        if filter and type(filter) == "function" then
          if filter(instance) then
            if instance[method] then
              r[instance] = instance[method](...)
            end
          end
        elseif instance[method] then
          r[instance] = instance[method](...)
        end
      end
      return r
    end
  end,
})

super = setmetatable({}, {
  __call     = call_index,
  __newindex = function() end,
  __index    = function(_, value)
    return function(_, n, p, ...)
      local r = {}
      local mt = getmetatable(_instances[n])

      for k, v in pairs(mt.__parents) do
        if v == p then
          local v_type = type(_things[v][value])
          if v_type == "function" then
            return _things[v][value](...)
          end
          return _things[v][value]
        else
          error(p .. " is not a parent of " .. mt.__type .. "!")
        end
      end
      return r
    end
  end
})
