TickEffect = GameObject:extend()

function TickEffect:new(area, x, y, opts)
  TickEffect.super.new(self, area, x, y, opts)
  self.width, self.height = 48, 32
  self.y_offset = 0
  self.timer:tween(0.13, self, { height = 0, y_offset = 32 }, "in-out-cubic", function() self.dead = true end)
end

function TickEffect:update(dt)
  TickEffect.super.update(self, dt)
  if self.parent then self.x, self.y = self.parent.x, self.parent.y end
end

function TickEffect:draw()
  love.graphics.setColor(DefaultColor)
  love.graphics.rectangle("fill", self.x - self.width / 2, self.y, self.width, self.height)
  love.graphics.setColor(WhiteColor)
end

function TickEffect:destroy()
  TickEffect.super.destroy(self)
end
