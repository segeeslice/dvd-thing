-- Observer class for event-driven interactions

Observer = {}
Observer.__metatable = "No no no no no no no"

function Observer:subscribe (key, cb)
  if self.map[key] == nil then
    self.map[key] = {}
  end

  table.insert(self.map[key], cb)
end

function Observer:unsubscribe (key, cb)
  for i, f in ipairs(self.map[key]) do
    if f == cb then
      table.remove(self.map[key], i)
      break
    end
  end
end

-- Subscribe/unsubscribe syntactic sugar
-- e.g. obs:on('event'):call(print)
function Observer:on (key)
  return {
    -- _ just for code consistency with :
    call = function (_, cb) self:subscribe(key, cb) end,
    dontCall = function (_, cb) self:unsubscribe(key, cb) end
  }
end

function Observer:notify (key, ...)
  if self.map[key] ~= nil then
    for _, f in ipairs(self.map[key]) do
      f(...)
    end
  end
end

function Observer:new ()
  local obs = { map = {} }
  return setmetatable(obs, { __index = self })
end

--[[
--Currently registered events:
--
--
--]]
