Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)

  self.x, self.y = x, y
  self.width, self.height = 12, 12
  self.collider = self.area.world:newCircleCollider(self.x, self.y, self.width)
  self.collider:setObject(self)

  self.rotation = -math.pi / 2
  self.rotationv = 1.66 * math.pi
  self.velocity = 0
  self.max_velocity = 100
  self.acceleration = 100

  self.timer:every(0.24, function()
    self:shoot()
  end)
end

function Player:shoot()
  self.area:addGameObject("ShootEffect", self.x + 1.2 * self.width * math.cos(self.rotation),
    self.y + 1.2 * self.width * math.sin(self.rotation))
end

function Player:update(dt)
  Player.super.update(self, dt)

  if input:down('left') then self.rotation = self.rotation - self.rotationv * dt end
  if input:down('right') then self.rotation = self.rotation + self.rotationv * dt end

  self.velocity = math.min(self.velocity + self.acceleration * dt, self.max_velocity)
  self.collider:setLinearVelocity(self.velocity * math.cos(self.rotation), self.velocity * math.sin(self.rotation))
end

function Player:draw()
  love.graphics.circle('line', self.x, self.y, self.width)
  love.graphics.line(self.x, self.y, self.x + 2 * self.width * math.cos(self.rotation),
    self.y + 2 * self.width * math.sin(self.rotation))
end

function Player:destroy()
  Player.super.destroy(self)
end
