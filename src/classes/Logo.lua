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

MAX_SHAKE_DIST = 700
MAX_SHAKE_OFFSET = 30

-- ** Logo **

Logo = {}

function Logo:onMouseUpdate (x, y)
  local dist = self:getDistFrom(x, y)

  if (dist > MAX_SHAKE_DIST) then
    self._shakeAmount = 0
  else
    -- TODO: eased increase instead of linear
    self._shakeAmount = (MAX_SHAKE_DIST - dist) / MAX_SHAKE_DIST
  end
end

function Logo:_getRandomShakeOffset ()
  return math.random(-MAX_SHAKE_OFFSET, MAX_SHAKE_OFFSET) * self._shakeAmount
end

function Logo:draw ()
  if (self._shakeAmount == 0) then
    -- TODO: find better way to do this like super:draw()
    RigidBody.draw(self)
  else
    local shakenX = self.x + self:_getRandomShakeOffset()
    local shakenY = self.y + self:_getRandomShakeOffset()
    RigidBody.draw(self, shakenX, shakenY)
  end
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
    velocity = Vector:new{x = speed, y = speed},
    _shakeAmount = 0 -- Value 0-1 indicating strength of shake
  }

  -- Inheritance
  return setmetatable(utils.copy(self), { __index = rb })
end
