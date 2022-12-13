Projectile = GameObject:extend()

function Projectile:new(area, x, y, opts)
  Projectile.super.new(self, area, x, y, opts)
  self.radius = opts.radius or 2.5
  self.velocity = opts.velocity or 200

  self.collider = self.area.world:newCircleCollider(self.x, self.y, self.radius)
  self.collider:setObject(self)
  self.collider:setLinearVelocity(self.velocity * math.cos(self.rotation), self.velocity * math.sin(self.rotation))
end

function Projectile:update(dt)
  Projectile.super.update(self, dt)
  self.collider:setLinearVelocity(self.velocity * math.cos(self.rotation), self.velocity * math.sin(self.rotation))
end

function Projectile:draw()
  love.graphics.setColor(DefaultColor)
  love.graphics.circle('line', self.x, self.y, self.radius)
end
