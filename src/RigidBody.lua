-- {
-- RigidBody : Observer
--   x = Num
--   y = Num
--   width = Num
--   height = Num
--   sprite = Love image
--   velocity = Vector
--
--   draw()
--   new{
--     sprite,
--     width (opt),
--     height (opt),
--     x (opt),
--     y (opt),
--     velocity (opt)
--   }
-- }

require "Observer"
require "Vector"
require "utils"

RigidBody = {}

function RigidBody:getXRight ()
  return self.x + self.width
end

function RigidBody:getYBottom ()
  return self.y + self.height
end

function RigidBody:draw ()
  local scaleX = self.width / self.sprite:getWidth()
  local scaleY = self.height / self.sprite:getHeight()
  love.graphics.draw(self.sprite, self.x, self.y, 0, scaleX, scaleY)
end

function RigidBody:updatePosition (dt)
  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

-- TODO: onUpdate general physics

function RigidBody:new (arg)
  arg = arg or {}

  local rb = {
    x = arg.x or 0,
    y = arg.y or 0,
    width = arg.width or 0,
    height = arg.height or 0,
    sprite = arg.sprite,
    velocity = arg.velocity or Vector:new()
  }

  ---- Inheritance
  local mt = setmetatable(utils.copy(self), { __index = Observer:new() })

  return setmetatable(rb, { __index = mt })
end
