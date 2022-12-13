ExplodeParticle = GameObject:extend()

function ExplodeParticle:new(area, x, y, opts)
  ExplodeParticle.super.new(self, area, x, y, opts)
  self.color = opts.color or DefaultColor
  self.rotation = random(0, 2 * math.pi)
  self.radius = opts.radius or random(2, 3)
  self.velocity = opts.velocity or random(75, 150)
  self.line_width = 2
  self.timer:tween(opts.diameter or random(0.3, 0.5), self, { radius = 0, velocity = 0, line_width = 0 },
    "linear", function() self.dead = true end)
end

function ExplodeParticle:update(dt)
  ExplodeParticle.super.update(self, dt)
  self.x = self.x + self.velocity * math.cos(self.rotation) * dt
  self.y = self.y + self.velocity * math.sin(self.rotation) * dt
end

function ExplodeParticle:draw()
  PushRotate(self.x, self.y, self.rotation)
  love.graphics.setLineWidth(self.line_width)
  love.graphics.setColor(self.color)
  love.graphics.line(self.x - self.radius, self.y, self.x + self.radius, self.y)
  love.graphics.setColor(DefaultColor)
  love.graphics.setLineWidth(1)
  love.graphics.pop()
end

function ExplodeParticle:destroy()
  ExplodeParticle.super.destroy(self)
end
