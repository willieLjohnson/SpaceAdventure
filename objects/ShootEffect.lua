ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
  ShootEffect.super.new(self, area, x, y, opts)
  self.width = 8
  self.timer:tween(0.5, self, { width = 0 }, 'in-out-cubic', function() self.dead = true end)
end

function ShootEffect:update(dt)
  ShootEffect.super.update(self, dt)
  -- self:matchPlayerPosition()
end

function ShootEffect:matchPlayerPosition()
  if self.player then
    self.x = self.player.x + self.diameter * math.cos(self.player.rotation)
    self.y = self.player.y + self.diameter * math.sin(self.player.rotation)
  end
end

function ShootEffect:draw()
  PushRotate(self.x, self.y, self.player.rotation + math.pi / 4)
  love.graphics.setColor(DefaultColor)
  love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.width / 2, self.width, self.width)
  love.graphics.pop()
end
