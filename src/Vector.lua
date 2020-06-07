--{
--Vector
--  x = Num
--  y = Num
--
--  new{x (opt), y(opt)}
--}

require "utils"

Vector = {}

function Vector:new (arg)
  arg = arg or {}

  local vect = {
    x = arg.x or 0,
    y = arg.y or 0
  }

  return setmetatable(vect, { __index = self })
end

