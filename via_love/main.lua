-- constants --
local W, H = love.graphics.getDimensions()
-- local PRESENTATION_FPS = 100
local COLORS = {
  NO_CELL = {0, 0, 0},
  CELL = {1, 1, 1},
  BLACK = {0, 0, 0},
  WHITE = {1, 1, 1},
}
local INITIAL_DENSITY = 0.3


-- main loop --
-- local last_draw_time = 0
local frame_time = -1

love.run = function()
  love.load()

  return function()
    local start_time = love.timer.getTime()

    -- TODO don't do as frequently?
    love.event.pump()
    for name, a in love.event.poll() do
      if name == "quit" then
        love.quit()
        return a or 0
      end
    end

    -- local now = love.timer.getTime()
    -- if now - last_draw_time < PRESENTATION_FPS then
    --   last_draw_time = now
      love.draw()
      love.graphics.present()
    -- end

    frame_time = love.timer.getTime() - start_time
  end
end


-- set up --
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
      local color = math.random() < INITIAL_DENSITY and COLORS.CELL or COLORS.NO_CELL
      love.graphics.setColor(color)
      love.graphics.points(x, y)
    end
  end

  love.graphics.setColor(COLORS.WHITE)
  love.graphics.setCanvas()
  print("Finished.")

  game_of_life_shader = love.graphics.newShader("game_of_life.glsl")
end


-- run --
local displayed_frame_time
local frames_counter = 100
love.draw = function()
  -- game of life itself --
  love.graphics.setCanvas(canvases.to_draw)
  love.graphics.setShader(game_of_life_shader)

  love.graphics.draw(canvases.previous)

  love.graphics.setShader()
  love.graphics.setCanvas()

  love.graphics.draw(canvases.to_draw)

  canvases.to_draw, canvases.previous = canvases.previous, canvases.to_draw

  -- stats --
  if frames_counter >= 100 then
    displayed_frame_time = frame_time
    frames_counter = 0
  end
  frames_counter = frames_counter + 1

  love.graphics.setColor(COLORS.BLACK)
  love.graphics.rectangle("fill", 0, 0, 50, 50)
  love.graphics.setColor(COLORS.WHITE)
  love.graphics.print(("%.2f"):format(1 / displayed_frame_time))
end


-- finish --
love.quit = function()
  print("Quit.")
end
