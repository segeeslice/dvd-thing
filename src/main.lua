require "Observer"
require "Logo"

-- ** Global Definitions **

-- Speed in pixels / sec
-- TODO: move to generic RigidBody class
LOGO_SPEED = 100

-- Global window object for more efficient storing of data
WIN = {
  x = {
    size = 0
  },
  y = {
    size = 0
  }
}

-- ** Util methods **

-- TODO: move to generic RigidBody class
function incLogoPosition (logo, incVal)
  for k,o in pairs({ x = logo.x, y = logo.y }) do
    if o.shouldInc == true and o.position + o.size + incVal > WIN[k].size then
      o.shouldInc = false
      logo:notify('bounce', 'Bouncy!')
    elseif o.shouldInc == false and o.position - incVal < 0 then
      o.shouldInc = true
      logo:notify('bounce', 'Boingy!')
    end

    if o.shouldInc == true then
      o.position = o.position + incVal
    else
      o.position = o.position - incVal
    end
  end
end

-- ** Love callbacks **

function love.load()
  love.window.setMode(0, 0, {
    resizable = true,
    minwidth = 800,
    minheight = 600
  })

  WIN.x.size, WIN.y.size = love.graphics.getDimensions()

  LOGO = Logo:new()
  LOGO:on('bounce'):call(print)
end

function love.resize(w, h)
  WIN.x.size = w
  WIN.y.size = h
end

function love.draw()
  LOGO:draw()
end

function love.update(dt)
  local incVal = LOGO_SPEED * dt
  incLogoPosition(LOGO, incVal)
end
