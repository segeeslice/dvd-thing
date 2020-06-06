-- === Constants ===

DVD_LOGO_PATH = 'resources/dvd-logo.png'

-- === Direction ===

Direction = {
  position = 0,
  size = 0,
  shouldInc = true
}

function Direction:new (o)
  o = o or {}
  setmetatable(o, { __index = self })
  return o
end

-- === Logo ===

Logo = { }

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

  setmetatable(logo, { __index = self })
  return logo
end
