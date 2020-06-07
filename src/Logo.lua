-- {
-- Logo : RigidBody : Observer
--   new{ width (opt), height (opt), x (opt), y (opt) }
--
--   @bounce
-- }

require "RigidBody"
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

-- TODO: replace with generic physics system & vectors
function Logo:incPosition (incVal)
  self.x = self.x + incVal
  self.y = self.y + incVal

  --for k,o in pairs({ x = self.x, y = self.y }) do
    --if o.shouldInc == true and o.position + o.size + incVal > WIN[k].size then
      --self:notify('bounce')
      --o.shouldInc = false
    --elseif o.shouldInc == false and o.position - incVal < 0 then
      --self:notify('bounce')
      --o.shouldInc = true
    --end

    --if o.shouldInc == true then
      --o.position = o.position + incVal
    --else
      --o.position = o.position - incVal
    --end
  --end
end

function Logo:onUpdate (dt)
  local incVal = LOGO_SPEED * dt
  self:incPosition(incVal)
end

function Logo:new (arg)
  arg = arg or {}

  local rb = RigidBody:new{
    x = arg.x,
    y = arg.y,
    width = arg.width or 150,
    height = arg.height or 80,
    sprite = love.graphics.newImage(DVD_LOGO_PATH)
  }

  -- Inheritance
  return setmetatable(utils.copy(self), { __index = rb })
end
