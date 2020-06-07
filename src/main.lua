require "Observer"
require "Logo"

-- ** Global Definitions **

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

  WIN.x.size, WIN.y.size = love.graphics.getDimensions()
  OBSERVER = Observer:new()

  LOGO = Logo:new()
  OBSERVER:on('update'):from(LOGO):call(LOGO.onUpdate)

  -- TODO: sound effect or something?
  LOGO:on('bounce'):call(function () print('Bouncey') end)
end

function love.resize(w, h)
  WIN.x.size = w
  WIN.y.size = h
end

function love.draw()
  LOGO:draw()
end

function love.update(dt)
  OBSERVER:notify('update', dt)
end
