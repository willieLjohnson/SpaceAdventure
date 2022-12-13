Stage = Object:extend()

function Stage:new()
  self.area = Area(self)
  self.area:addPhysicsWorld()
  self.main_canvas = love.graphics.newCanvas(game_width, game_height)

  self.area:addGameObject('Player', game_width / 2, game_height / 2)
end

function Stage:update(dt)
  camera.smoother = Camera.smooth.damped(5)
  camera:lockPosition(dt, game_width / 2, game_height / 2)

  self.area:update(dt)
end

function Stage:draw()
  love.graphics.setCanvas(self.main_canvas)
  love.graphics.clear()
  camera:attach(0, 0, game_width, game_height)
  self.area:draw()
  camera:detach()
  love.graphics.setCanvas()

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.setBlendMode('alpha', 'premultiplied')
  love.graphics.draw(self.main_canvas, 0, 0, 0, scale_x, scale_y)
  love.graphics.setBlendMode('alpha')
end

function Stage:destroy()
  self.area:destroy()
  self.area = nil
end
