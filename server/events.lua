--server/events.lua
RegisterNetEvent("staffchat:server:admins", function()
  if not source then
    return Debug("[staffchat:server:admins] Event was called but source is nil.")
  end

  if not AdminData[tostring(source)] then
    -- TODO: Notification system.
    return Debug("[netEvent:staffchat:server:admins] Player is not a staff member.")
  end

  TriggerClientEvent("staffchat:client:admins", source, AdminData)
end)

RegisterNetEvent("staffchat:server:users", function()
  if not source then
    return Debug("[staffchat:server:users] Event was called but source is nil.")
  end

  if PlayerData[tostring(source)] then
    -- TODO: Notification system.
    return Debug("[netEvent:staffchat:server:users] Player is member.")
  end

  TriggerClientEvent("staffchat:client:users", source, PlayerData)
end)

---@param data messageInfo
RegisterNetEvent("staffchat:server:firemessage", function(data)
  if not source or not AdminData[tostring(source)] then
    return Debug("source is nil or the player isn't a staff member.")
  end

  if not next(data) then
    return Debug("[netEvent:staffchat:server:firemessage] Event was called, but the first param is null/missing.")
  end


  data.adminData = AdminData[tostring(source)]

  Debug("[netEvent:staffchat:server:firemessage] Data: ", json.encode(data))

  for _, v in pairs(AdminData) do
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent("staffchat:client:firemessage", v.id, data)
  end
end)


RegisterNetEvent("staffchat:server:permissions", function()
  if not AdminData[tostring(source)] then
    Debug("[netEvent:staffchat:server:permissions] Player is not staff.")

    -- Not the best, but it works.

    local exData = {
      id = source,
      name = GetPlayerName(source),
      isStaff = false
    }

    TriggerClientEvent("staffchat:client:permissions", source, exData)
    return
  end

  Debug("[netEvent:staffchat:server:permissions] AdminData[tostring(source)]:", json.encode(AdminData[tostring(source)]))
  TriggerClientEvent("staffchat:client:permissions", source, AdminData[tostring(source)])
end)

RegisterServerEvent('staffchat:server:requestPlayerList')
AddEventHandler('staffchat:server:requestPlayerList', function()
    local source = source  -- Der Spieler, der das Event ausgelöst hat
    local players = GetPlayers()
    local playerList = {}

    for _, playerId in ipairs(players) do
        local playerName = GetPlayerName(playerId)
        local routingBucket = GetPlayerRoutingBucket(playerId)
        -- Ändern Sie hier die Eigenschaftsnamen zu playerId und routingBucket
        table.insert(playerList, {playerId = playerId, routingBucket = routingBucket, playerName = playerName})
    end

    TriggerClientEvent('staffchat:client:receivePlayersRoutingBuckets', source, playerList)
end)

RegisterServerEvent('staffchat:server:getPlayersRoutingBuckets')
AddEventHandler('staffchat:server:getPlayersRoutingBuckets', function()
    local players = GetPlayers()
    local playerBuckets = {}

    for _, playerId in ipairs(players) do
        local bucket = GetPlayerRoutingBucket(playerId)
        table.insert(playerBuckets, {playerId = playerId, routingBucket = bucket})
    end

    TriggerClientEvent('staffchat:client:receivePlayersRoutingBuckets', source, playerBuckets)
end)

RegisterServerEvent('staffchat:server:getClientRoutingBucket')
AddEventHandler('staffchat:server:getClientRoutingBucket', function()
    local source = source
    local playerRoutingBucket = GetPlayerRoutingBucket(source)
    TriggerClientEvent('staffchat:client:setClientRoutingBucket', source, playerRoutingBucket)
end)

AddEventHandler('playerJoining', function(playerId)
  -- Hier könnten Sie Logik einfügen, um alle Spieler zu durchlaufen und ihre Daten zu sammeln
  local players = GetPlayers()
  local playerBuckets = {}

  for _, id in pairs(players) do
      local bucket = GetPlayerRoutingBucket(id)
      table.insert(playerBuckets, {playerId = id, routingBucket = bucket})
  end

  -- Dann senden Sie diese aktualisierte Liste an alle Clients
  TriggerClientEvent('updatePlayerList', -1, playerBuckets) -- -1 sendet an alle verbundenen Clients
end)