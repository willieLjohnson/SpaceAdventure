ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
  ShootEffect.super.new(self, area, x, y, opts)
  self.width = 8
  self.timer:tween(0.1, self, { width = 0 }, 'in-out-cubic', function() self.dead = true end)
end

function ShootEffect:draw()
  love.graphics.setColor(DefaultColor)
  love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.width / 2, self.width, self.width)
end
