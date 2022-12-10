Circle = Object:extend()

function Circle:new(x, y, radius)
  self.x = x
  self.y = y
  self.radius = radius
  self.creation_time = love.timer.getTime()
end

function Circle:update(dt)
end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, outer_radius, line_width)
  HyperCircle.super.new(self, x, y, radius)
  self.outer_radius = outer_radius
  self.line_width = line_width
end

function HyperCircle:draw()
  HyperCircle.super.draw(self)
  love.graphics.setLineWidth = self.line_width
  love.graphics.circle("line", self.x, self.y, self.outer_radius)
end
