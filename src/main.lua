require "Observer"

-- ** Global Definitions **

-- Speed in pixels / sec
LOGO_SPEED = 100

DVD_LOGO_IMG = nil

-- Global window object for more efficient storing of data
-- TODO: allow resize and update this tracker
WIN = {
  x = {
    size = 0
  },
  y = {
    size = 0
  }
}

-- Global logo data for x and y directions
logo = {
  x = {
    position = 0,
    size = 150,
    shouldInc = true
  },
  y = {
    position = 0,
    size = 80,
    shouldInc = true
  }
}

-- ** Util methods **
-- TODO: Move logo stuff to own class in separate file

function drawLogo ()
  if DVD_LOGO_IMG == nil then return end
  local scaleX = logo.x.size / DVD_LOGO_IMG:getWidth()
  local scaleY = logo.y.size / DVD_LOGO_IMG:getHeight()
  love.graphics.draw(DVD_LOGO_IMG, logo.x.position, logo.y.position, 0, scaleX, scaleY)
end

function incLogoPosition (incVal)
  for k,o in pairs(logo) do
    if o.shouldInc == true and o.position + o.size + incVal > WIN[k].size then
      o.shouldInc = false
      Observer:notify('onBounce', 'Bouncy!')
    elseif o.shouldInc == false and o.position - incVal < 0 then
      o.shouldInc = true
      Observer:notify('onBounce', 'Boingy!')
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
  DVD_LOGO_IMG = love.graphics.newImage('resources/dvd-logo.png')

  Observer:subscribe('onBounce', print)
end

function love.resize(w, h)
  WIN.x.size = w
  WIN.y.size = h
end

function love.draw()
  drawLogo()
end

function love.update(dt)
  local incVal = LOGO_SPEED * dt
  incLogoPosition(incVal)
end
