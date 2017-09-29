players = {}

function getInput(controlScheme)
  local returnTable = {}
  
  for operation, button in pairs(controlScheme) do
    if love.keyboard.isDown(button) then
      returnTable[operation] = true
    end
  end
  
  return returnTable
end

function createNewPlayer(properties)
  local newPlayer = {}
  
  newPlayer.name = name
  newPlayer.isControllable = false
  newPlayer.size = 10
  newPlayer.x = 0
  newPlayer.y = 0
  newPlayer.colour = {255, 0, 0} -- RGB
  newPlayer.direction = 0
  newPlayer.speed = 50
  newPlayer.jumpDistance = 10
  newPlayer.controlScheme = {left = "left", right = "right", up = "up", down = "down",jump = " "}
  newPlayer.run = 0
  newPlayer.lastRun = 0
  newPlayer.tail = {}
  
  if properties then
    for k, v in pairs(properties) do
      newPlayer[k] = v
    end
  end
  
  return newPlayer
end

function createNewTailPiece(properties)
  local newTailPiece = {}
  
  newTailPiece.x = 0
  newTailPiece.y = 0
  newTailPiece.size = 0
  newTailPiece.colour = {255, 0, 0} -- RGB
  
  if properties then
    for k, v in pairs(properties) do
      newTailPiece[k] = v
    end
  end
  
  return newTailPiece
end

function updatePlayer(player, dt)
  player.run = player.run + dt
  
  if player.run >= player.lastRun + (1 / player.speed) then
    player.x = player.x + ((math.cos(player.direction) * player.jumpDistance))
    player.y = player.y + ((math.sin(player.direction) * player.jumpDistance))
    
    table.insert(player.tail, createNewTailPiece({x = player.x, y = player.y, size = player.size, colour = player.colour}))
    
    player.lastRun = player.run
  end
  
  
  if player.isControllable then  
    local activeKeys = getInput(player.controlScheme)
  
    if activeKeys.up then
      player.direction = math.rad(270)
    elseif activeKeys.down then
      player.direction = math.rad(90)
    elseif activeKeys.left then
      player.direction = math.rad(180)
    elseif activeKeys.right then
      player.direction = math.rad(0)
    end
  end
  
  if #player.tail >= 20 then
    table.remove(player.tail, 1)
  end
end

function drawPlayer(player)
  local PLAYER_SIZE = player.size
  
  love.graphics.setColor(player.colour)
  love.graphics.rectangle("fill", player.x, player.y, PLAYER_SIZE, PLAYER_SIZE)
  love.graphics.setColor(0, 0, 0)
end

function drawTail(tail)
  local TAIL_SIZE = tail.size
  
  love.graphics.setColor(tail.colour)
  love.graphics.rectangle("fill", tail.x, tail.y, TAIL_SIZE, TAIL_SIZE)
  love.graphics.setColor(0, 0, 0)
end

function updateAllPlayers(dt)
  for position, player in pairs(players) do
    updatePlayer(player, dt)
  end
end

function drawAllTails()
  for position, player in pairs(players) do
    for position, tail in pairs(player.tail) do
      drawTail(tail)
    end
  end
end

function drawAllPlayers()
  for position, player in pairs(players) do
    drawPlayer(player)
  end
end

function love.load()
  table.insert(players, createNewPlayer({isControllable = true}))
  table.insert(players, createNewPlayer({x = 10, y = 400, direction = math.rad(300)}))
end

function love.update(dt)
  updateAllPlayers(dt)
end

function love.draw()
  drawAllPlayers()
  drawAllTails()
end