---@type adminData[]
AdminData = {}

---@type playerData[]
OnlinePlayersData = {}

---@param _source string
---@param _oldID string
AddEventHandler("playerJoining", function(_source, _oldID)
  if source <= 0 then
    return Debug("source is nil.")
  end

  local player = CPlayer:new(source)

  if not player then
    return Debug("CPlayer:new method is returning null.")
  end

  if player.isStaff then
    AdminData[tostring(source)] = player
    Debug(player.name, "was added to the AdminData table.")
  end

  OnlinePlayersData[tostring(source)] = player
  Debug(player.name, "was added to the OnlinePlayersData table.")
end)

AddEventHandler("playerDropped", function(_reason)
  if AdminData[tostring(source)] then
    AdminData[tostring(source)] = nil
    Debug("[netEvent:playerDropped] Event was triggered, and the player was removed from the AdminData table.")
  end

  OnlinePlayersData[tostring(source)] = nil
  Debug("[netEvent:playerDropped] Event was triggered, and the player was removed from the OnlinePlayersData table.")
end)

SetTimeout(200, function()
  local OnlinePlayers = GetPlayers()

  Debug("AdminData table before looping through all players: ", json.encode(AdminData))
  Debug("OnlinePlayersData table before looping through all players: ", json.encode(OnlinePlayersData))

  for i = 1, #OnlinePlayers do
    local playerSource = OnlinePlayers[i]
    local player = CPlayer:new(playerSource)

    if not player then
      return Debug("[timeout:function] CPlayer:new is returning nil.")
    end

    if player.isStaff then
      AdminData[tostring(playerSource)] = player
      Debug(player.name, "was added to the AdminData table.")
    end

    OnlinePlayersData[tostring(playerSource)] = player
    Debug(player.name, "was added to the OnlinePlayersData table.")
  end

  Debug("AdminData table after looping through all of the players: ", json.encode(AdminData))
  Debug("OnlinePlayersData table after looping through all of the players: ", json.encode(OnlinePlayersData))
end)