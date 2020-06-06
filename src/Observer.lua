-- Observer class for event-driven interactions

Observer = { map = {} }

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

function Observer:notify (key, ...)
  if self.map[key] ~= nil then
    for _, f in ipairs(self.map[key]) do
      f(...)
    end
  end
end

Observer.__metatable = "No no no no no no no"

--[[
--Currently registered events:
--
--
--]]
