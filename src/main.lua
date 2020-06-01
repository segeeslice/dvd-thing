NUM = 0

function love.draw()
  str = string.format('The number is now %d', NUM)
  love.graphics.print(str, 300, 300)
end

function love.update(dt)
  if love.keyboard.isDown('up') then
    NUM = NUM + 100 * dt
  elseif love.keyboard.isDown('down') then
    NUM = NUM - 100 * dt
  end
end
