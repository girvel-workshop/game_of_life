-- constants --
local W, H = love.graphics.getDimensions()
local PRESENTATION_FPS = 100
local COLORS = {
  BLACK = {0, 0, 0},
  WHITE = {1, 1, 1},
}
local GAME_OF_LIFE_SHADER = love.graphics.newShader("shader.glsl")


-- set up state --
local canvases = {
  previous = love.graphics.newCanvas(W, H),
  to_draw = love.graphics.newCanvas(W, H),
}


love.load = function()
  print("Rendering base canvas")
  love.graphics.setCanvas(canvases.previous)

  for x = 1, W do
    for y = 1, H do
      local color = math.random() < 0.5 and COLORS.WHITE or COLORS.BLACK
      love.graphics.setColor(color)
      love.graphics.points(x, y)
    end
  end

  love.graphics.setColor(COLORS.WHITE)
  love.graphics.setCanvas()
  print("Finished.")
end


love.draw = function()
  love.graphics.draw(canvases.previous)
end


love.quit = function()
  return false
end
