require "classes/Observer"
require "classes/Logo"

-- ** Global Definitions **

-- Global observer for love events
OBSERVER = {}

-- Global window object for more efficient storing of data
WIN = {
  x = {
    size = 0
  },
  y = {
    size = 0
  }
}

-- ** Love callbacks **

function love.load()
  love.window.setMode(0, 0, {
    resizable = true,
    minwidth = 800,
    minheight = 600
  })

  math.randomseed(os.time())

  WIN.x.size, WIN.y.size = love.graphics.getDimensions()
  OBSERVER = Observer:new()

  LOGO = Logo:new()
  OBSERVER:on('update'):from(LOGO):call(LOGO.onUpdate)
  OBSERVER:on('mouseUpdate'):from(LOGO):call(LOGO.onMouseUpdate)
end

function love.resize(w, h)
  WIN.x.size = w
  WIN.y.size = h
end

function love.draw()
  LOGO:draw()
end

function love.update(dt)
  local x, y = love.mouse.getPosition()
  OBSERVER:notify('mouseUpdate', x, y)
  OBSERVER:notify('update', dt)
end
