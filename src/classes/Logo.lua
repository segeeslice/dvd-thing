-- {
-- Logo : RigidBody : Observer
--   new{ width (opt), height (opt), x (opt), y (opt), speed (opt) }
--
--   @bounce
-- }

require "classes/RigidBody"
require "classes/Vector"
require "utils"

-- ** Constants **

DVD_LOGO_PATH = 'resources/dvd-logo.png'
DEFAULT_LOGO_SPEED = 100 -- px/sec

-- ** Logo **

Logo = {}

function Logo:onMouseUpdate (x, y)
  local dist = self:getDistFrom(x, y)
end

function Logo:onUpdate (dt)
  -- Update position based on velocity vector
  self:updatePosition(dt)

  -- Detect collisions
  -- TODO: Generalize within container, somehow?
  if (self.velocity.x > 0 and self:getXRight() >= WIN.x.size or
      self.velocity.x < 0 and self.x < 0) then
    self.velocity.x = -1 * self.velocity.x
  end

  if (self.velocity.y > 0 and self:getYBottom() >= WIN.y.size or
      self.velocity.y < 0 and self.y < 0) then
    self.velocity.y = -1 * self.velocity.y
  end
end

function Logo:new (arg)
  arg = arg or {}

  local speed = arg.speed or DEFAULT_LOGO_SPEED
  local rb = RigidBody:new{
    x = arg.x,
    y = arg.y,
    width = arg.width or 150,
    height = arg.height or 80,
    sprite = love.graphics.newImage(DVD_LOGO_PATH),
    velocity = Vector:new{x = speed, y = speed}
  }

  -- Inheritance
  return setmetatable(utils.copy(self), { __index = rb })
end
