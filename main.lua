Object = require 'libraries/classic/classic'
Input = require 'libraries/input/input'
Timer = require 'libraries/hump/timer'

function love.load()
  RequireAllObjects()
  input = Input()
  input:bind('k', 'test')

  timer = Timer()

  circle = Circle(400, 300, 50)
  hyperCircle = HyperCircle(200, 150, 50, 120, 10)
  timer:every(1, function()
    timer:tween(0.5, hyperCircle, { radius = 100, outer_radius = 240 }, 'in-out-cubic')
    timer:after(0.5, function()
      timer:tween(0.5, hyperCircle, { radius = 50, outer_radius = 40 }, 'in-out-cubic')
    end)
  end)
end

function RequireAllObjects()
  local object_files = {}
  RecursiveEnumerate('objects', object_files)
  RequireFiles(object_files)
  return object_files
end

function RequireFiles(files)
  for _, fileName in ipairs(files) do
    require(fileName:sub(1, -5))
  end
end

function RecursiveEnumerate(folder, file_list)
  local items = love.filesystem.getDirectoryItems(folder)
  for _, item in ipairs(items) do
    local file = folder .. '/' .. item
    local info = love.filesystem.getInfo(file)
    if info.type == "file" then
      table.insert(file_list, file)
    elseif info.type == "directory" then
      RecursiveEnumerate(file, file_list)
    end
  end
end

function love.update(dt)
  timer:update(dt)
  if input:pressed('test') then print('pressed') end
  if input:released('test') then print('released') end
  if input:down('test') then print('down') end
end

function love.draw()
  love.graphics.print("hi", love.math.random(0, 800), 400)
  circle:draw()
  hyperCircle:draw()
end

function love.run()
  if love.math then love.math.setRandomSeed(os.time()) end
  if love.load then love.load() end
  if love.timer then love.timer.step() end
  local dt = 0
  local fixed_dt = 1 / 60
  local accumulator = 0
  while true do
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == 'quit' then
          if not love.quit or not love.quit() then
            return a
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end
    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end
    accumulator = accumulator + dt
    while accumulator >= fixed_dt do
      if love.update then love.update(fixed_dt) end
      accumulator = accumulator - fixed_dt
    end
    if love.graphics and love.graphics.isActive() then
      love.graphics.clear(love.graphics.getBackgroundColor())
      love.graphics.origin()
      if love.draw then love.draw() end
      love.graphics.present()
    end
    if love.timer then love.timer.sleep(0.001) end
  end
end
