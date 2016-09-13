require "lib/valyrian"

require "lib/class/input"
require "lib/class/timer"
require "lib/class/vector"
require "lib/class/transform"

require "lib/class/camera"

love.graphics.setDefaultFilter("nearest", "nearest")

-- global objects
input = new: Input()
camera = new: Camera({x = 0, y = 0}, {x = 1, y = 1}, 0)

function love.run()
  local dt = 0

  local update_timer = 0
  local target_delta = 1 / 60

  if love.math then
    love.math.setRandomSeed(os.time())
  end

  if love.load then
    emit:load()
  end

  if love.timer then
    love.timer.step()
  end

  while true do
    update_timer = update_timer + dt

    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        event[name](a, b, c, d, e, f)
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a
          end
        end
      end
    end

    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end

    if update_timer > target_delta then
      event:update(target_delta)
    end

    if love.graphics and love.graphics.isActive() then
      love.graphics.clear(love.graphics.getBackgroundColor())
      love.graphics.setColor(255, 255, 255)

      love.graphics.origin()

      camera.set()
      event:draw()
      camera.unset()

      love.graphics.present()
    end

    if love.timer then
      love.timer.sleep(0.001)
    end
  end
end
