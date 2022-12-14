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
  self.base_max_velocity = 100
  self.max_velocity = self.base_max_velocity
  self.acceleration = 100

  self.timer:every(0.24, function()
    self:shoot()
  end)
  input:bind('f4', function() self:die() end)
  self.timer:every(5, function() self:tick() end)
end

function Player:shoot()
  local diameter = self.width * 1.2
  self.area:addGameObject("ShootEffect", self.x + diameter * math.cos(self.rotation),
    self.y + diameter * math.sin(self.rotation), { player = self, diameter = diameter })
  self.area:addGameObject("Projectile", self.x + 1.5 * diameter * math.cos(self.rotation),
    self.y + 1.5 * diameter * math.sin(self.rotation),
    { rotation = self.rotation })
end

function Player:tick()
  self.area:addGameObject("TickEffect", self.x, self.y, { parent = self })
end

function Player:update(dt)
  Player.super.update(self, dt)

  local dir = self:getInputDir()
  if dir.left then self.rotation = self.rotation - self.rotationv * dt end
  if dir.right then self.rotation = self.rotation + self.rotationv * dt end

  self.max_velocity = self.base_max_velocity
  if dir.up then self.max_velocity = 1.5 * self.base_max_velocity end
  if dir.down then self.max_velocity = 1.5 * self.base_max_velocity end

  self.velocity = math.min(self.velocity + self.acceleration * dt, self.max_velocity)
  self.collider:setLinearVelocity(self.velocity * math.cos(self.rotation), self.velocity * math.sin(self.rotation))
end

function Player:getInputDir()
  return {
    up = input:down("up"),
    down = input:down("down"),
    left = input:down("left"),
    right = input:down("right"),
  }
end

function Player:draw()
  love.graphics.circle('line', self.x, self.y, self.width)
  love.graphics.line(self.x, self.y, self.x + 2 * self.width * math.cos(self.rotation),
    self.y + 2 * self.width * math.sin(self.rotation))
end

function Player:destroy()
  Player.super.destroy(self)
end

function Player:die()
  self.dead = true
  for i = 1, love.math.random(8, 12) do
    self.area:addGameObject("ExplodeParticle", self.x, self.y,
      { color = RedColor })
  end
  Slow(0.15, 1)
  camera:shake(6, 60, 0.4)
end
