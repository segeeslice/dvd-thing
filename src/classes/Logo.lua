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

MAX_SHAKE_SCREEN_PERCENT = .5 -- % of screen size
MAX_SHAKE_OFFSET = 30

-- ** Logo **

Logo = {}

function Logo:onMouseUpdate (x, y, winWidth, winHeight)
  -- LOVE can't detect if mouse isn't in the screen
  -- Instead, consider a single-pixel border at the end of the screen
  -- to be the pseudo "out-of-of-screen"
  -- If out of screen, don't shake
  if (x <= 0 or x >= winWidth - 1 or y <= 0 or y >= winHeight - 1) then
    -- TODO: ease out?
    self._shakeAmount = 0
    return
  end

  local dist = self:getDistFrom(x, y)
  -- TODO: Could add to event-driven structure
  local widthHeightAvg = (winWidth + winHeight) / 2
  local maxShakeDist = MAX_SHAKE_SCREEN_PERCENT * widthHeightAvg

  if (dist > maxShakeDist) then
    self._shakeAmount = 0
  else
    -- TODO: eased increase instead of linear
    self._shakeAmount = (maxShakeDist - dist) / maxShakeDist
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
