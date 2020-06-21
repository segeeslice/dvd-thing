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

require "classes/Observer"
require "classes/Vector"
require "utils"

RigidBody = {}

function RigidBody:getXRight ()
  return self.x + self.width
end

function RigidBody:getYBottom ()
  return self.y + self.height
end

-- x, y optional; defaults to self.x and self.y
function RigidBody:draw (x, y)
  local scaleX = self.width / self.sprite:getWidth()
  local scaleY = self.height / self.sprite:getHeight()
  love.graphics.draw(self.sprite, x or self.x, y or self.y, 0, scaleX, scaleY)
end

function RigidBody:updatePosition (dt)
  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

function RigidBody:getDistFrom (x, y)
  local isLeft = x < self.x
  local isAbove = y < self.y
  local isRight = x > self:getXRight()
  local isBelow = y > self:getYBottom()

  local compareX, compareY

  if (isLeft) then
    compareX = self.x
  elseif (isRight) then
    compareX = self:getXRight()
  else
    compareX = x
  end

  if (isAbove) then
    compareY = self.y
  elseif (isBelow) then
    compareY = self:getYBottom()
  else
    compareY = y
  end

  -- Pythagorean's
  local distX = x - compareX
  local distY = y - compareY

  return math.sqrt(math.pow(distX, 2) + math.pow(distY, 2))
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
