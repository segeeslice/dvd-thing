-- Observer class for event-driven interactions

Observer = { map = {} }

Observer.subscribe = function(self, key, cb)
  if self.map[key] == nil then
    self.map[key] = {}
  end

  table.insert(self.map[key], cb)
end

Observer.unsubscribe = function(self, key, cb)
  for i, f in ipairs(self.map[key]) do
    if f == cb then
      table.remove(self.map[key], i)
      break
    end
  end
end

Observer.notify = function(self, key, ...)
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
