WIN = {
  x = {
    size = 0
  },
  y = {
    size = 0
  }
}

rect = {
  x = {
    position = 0,
    size = 100,
    shouldInc = true
  },
  y = {
    position = 0,
    size = 100,
    shouldInc = true
  }
}

function love.load()
  WIN.x.size, WIN.y.size = love.graphics.getDimensions()
  print(WIN.x.size, WIN.y.size)
end

function love.draw()
  love.graphics.rectangle('fill', rect.x.position, rect.y.position, 100, 100)
end

function love.update(dt)
  local incVal = 100 * dt

  for k,o in pairs(rect) do
    if o.shouldInc == true and o.position + o.size + incVal > WIN[k].size then
      o.shouldInc = false
    elseif o.shouldInc == false and o.position - incVal < 0 then
      o.shouldInc = true
    end

    if o.shouldInc == true then
      o.position = o.position + incVal
    else
      o.position = o.position - incVal
    end
  end
end
