-- constants --
local W, H = love.graphics.getDimensions()
-- local PRESENTATION_FPS = 100
local COLORS = {
  BLACK = {0, 0, 0},
  WHITE = {1, 1, 1},
}
local INITIAL_DENSITY = 0.3


-- main loop --
-- local last_draw_time = 0

love.run = function()
  love.load()

  return function()
    love.event.pump()
    for name, a in love.event.poll() do
      if name == "quit" then
        love.quit()
        return a or 0
      end
    end

    -- love.timer.step()
    -- love.update()

    -- local now = love.timer.getTime()
    -- if now - last_draw_time < PRESENTATION_FPS then
    --   last_draw_time = now
      love.draw()
      love.graphics.present()
    -- end
  end
end


-- set up state --
local canvases, game_of_life_shader

love.load = function()
  canvases = {
    previous = love.graphics.newCanvas(W, H),
    to_draw = love.graphics.newCanvas(W, H),
  }

  print("Rendering base canvas")
  love.graphics.setCanvas(canvases.previous)

  for x = 1, W do
    for y = 1, H do
      local color = math.random() < INITIAL_DENSITY and COLORS.WHITE or COLORS.BLACK
      love.graphics.setColor(color)
      love.graphics.points(x, y)
    end
  end

  love.graphics.setColor(COLORS.WHITE)
  love.graphics.setCanvas()
  print("Finished.")

  game_of_life_shader = love.graphics.newShader("game_of_life.glsl")
end


-- calculate & draw stuff --
love.draw = function()
  love.graphics.setCanvas(canvases.to_draw)
  love.graphics.setShader(game_of_life_shader)

  love.graphics.draw(canvases.previous)

  love.graphics.setShader()
  love.graphics.setCanvas()

  love.graphics.draw(canvases.to_draw)

  canvases.to_draw, canvases.previous = canvases.previous, canvases.to_draw
end


love.quit = function()
  print("Quit.")
end
