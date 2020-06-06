-- {
-- Logo : Observer
--   x = Direction
--   y = Direction
--   img = Love image
--
--   draw()
--   new{ width (opt), height (opt), img (opt) }
--
--   @bounce
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

-- TODO: replace with generic physics system & vectors
function Logo:incPosition (incVal)
  for k,o in pairs({ x = self.x, y = self.y }) do
    if o.shouldInc == true and o.position + o.size + incVal > WIN[k].size then
      self:notify('bounce')
      o.shouldInc = false
    elseif o.shouldInc == false and o.position - incVal < 0 then
      self:notify('bounce')
      o.shouldInc = true
    end

    if o.shouldInc == true then
      o.position = o.position + incVal
    else
      o.position = o.position - incVal
    end
  end
end

function Logo:onUpdate (dt)
  local incVal = LOGO_SPEED * dt
  self:incPosition(incVal)
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
