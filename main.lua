players = {}

function createNewPlayer(properties)
  local newPlayer = {}
  
  newPlayer.name = name
  newPlayer.size = 10
  newPlayer.ip = ip
  newPlayer.x = 0
  newPlayer.y = 0
  newPlayer.colour = {255, 0, 0} -- RGB
  newPlayer.direction = 0
  newPlayer.speed = 200
  newPlayer.controlScheme = {left = "left", right = "right", jump = " "}
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
  player.x = player.x + ((math.cos(player.direction) * player.speed) * dt)
  player.y = player.y + ((math.sin(player.direction) * player.speed) * dt)
  
  table.insert(player.tail, createNewTailPiece({x = player.x, y = player.y, size = player.size, colour = player.colour}))
  
  if #player.tail >= 100 then
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
  table.insert(players, createNewPlayer())
end

function love.update(dt)
  updateAllPlayers(dt)
end

function love.draw()
  drawAllPlayers()
  drawAllTails()
end