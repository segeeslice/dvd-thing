-- {
-- Logo : Observer
--   x = Direction
--   y = Direction
--   img = Love image
--
--   draw()
--   new{ width (opt), height (opt), img (opt) }
-- }

require "Observer"
require "utils"

-- ** Constants **

DVD_LOGO_PATH = 'resources/dvd-logo.png'

-- ** Direction **
-- TODO: Refactor to generic "velocity" vector

Direction = {}

function Direction:new (arg)
  arg = arg or {}

  local dir = {
    position = arg.position or 0,
    size = arg.size or 0,
    shouldInc = arg.shouldInc or true
  }

  return setmetatable(dir, { __index = self })
end

-- ** Logo **

Logo = {}

function Logo:draw ()
  local imgScaleX = self.x.size / self.img:getWidth()
  local imgScaleY = self.y.size / self.img:getHeight()

  love.graphics.draw(self.img, self.x.position, self.y.position, 0, imgScaleX, imgScaleY)
end

function Logo:new (arg)
  arg = arg or {}

  local logo = {
    x = Direction:new{size = arg.width or 150},
    y = Direction:new{size = arg.width or 80},
    img = arg.img or love.graphics.newImage(DVD_LOGO_PATH)
  }

  -- Inheritance
  local mt = setmetatable(utils.copy(self), { __index = Observer:new() })

  return setmetatable(logo, { __index = mt })
end
