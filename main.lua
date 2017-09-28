players = {}

function createNewPlayer(properties)
  local newPlayer = {}
  newPlayer.name = name
  newPlayer.ip = ip
  newPlayer.x = 0
  newPlayer.y = 0
  newPlayer.colour = {255, 0, 0} -- Purple (RGB)
  newPlayer.direction = 0
  newPlayer.speed = 200
  
  if properties then
    for k, v in pairs(properties) do
      newPlayer[k] = v
    end
  end
  
  return newPlayer
end

function updatePlayer(player, dt)
  player.x = player.x + ((math.cos(player.direction) * player.speed) * dt)
  player.y = player.y + ((math.sin(player.direction) * player.speed) * dt)
end

function drawPlayer(player)
  local PLAYER_SIZE = 10
  
  love.graphics.setColor(player.colour)
  love.graphics.rectangle("fill", player.x, player.y, PLAYER_SIZE, PLAYER_SIZE)
  love.graphics.setColor(0, 0, 0)
end

function updateAllPlayers(dt)
  for position, player in pairs(players) do
    updatePlayer(player, dt)
  end
end

function drawAllPlayers()
  for position, player in pairs(players) do
    drawPlayer(player)
  end
end

function love.load()
  table.insert(players, createNewPlayer({speed = 1, x = 10, y = 10}))
end

function love.update(dt)
  updateAllPlayers(dt)
end

function love.draw()
  drawAllPlayers()
end