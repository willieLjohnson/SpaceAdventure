function UUID()
  local fn = function(x)
    local r = math.random(16) - 1
    r = (x == "x") and (r + 1) or (r % 4) + 9
    return ("0123456789abcdef"):sub(r, r)
  end
  return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

function random(min, max)
  local min, max = min or 0, max or 1
  return (min > max and (love.math.random() * (min - max) + max)) or (love.math.random() * (max - min) + min)
end

function PushRotate(x, y, rotation)
  love.graphics.push()
  love.graphics.translate(x, y)
  love.graphics.rotate(rotation or 0)
  love.graphics.translate(-x, -y)
end

function PushRotateScale(x, y, rotation, scale_x, scale_y)
  love.graphics.push()
  love.graphics.translate(x, y)
  love.graphics.rotate(rotation or 0)
  love.graphics.scale(scale_x or 1, scale_y or scale_x or 1)
  love.graphics.translate(-x, -y)
end
