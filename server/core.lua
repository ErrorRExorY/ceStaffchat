---@type adminData[]
AdminData = {}

---@type playerData[]
PlayerData = {}

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
  else
    PlayerData[tostring(source)] = player
    Debug(player.name, "was added to the PlayerData table.")
  end
end)

AddEventHandler("playerDropped", function(_reason)
  if AdminData[tostring(source)] then
    AdminData[tostring(source)] = nil
    Debug("[netEvent:playerDropped] Event was triggered, and the player was removed from the AdminData table.")
  end

  if PlayerData[tostring(source)] then
    PlayerData[tostring(source)] = nil
    Debug("[netEvent:playerDropped] Event was triggered, and the player was removed from the PlayerData table.")
  end
end)

SetTimeout(200, function()
  local OnlinePlayers = GetPlayers()

  Debug("AdminData table before looping through all players: ", json.encode(AdminData))
  Debug("PlayerData table before looping through all players: ", json.encode(PlayerData))

  for i = 1, #OnlinePlayers do
    local playerSource = OnlinePlayers[i]
    local player = CPlayer:new(playerSource)

    if not player then
      return Debug("[timeout:function] CPlayer:new is returning nil.")
    end

    if player.isStaff then
      AdminData[tostring(playerSource)] = player
      Debug(player.name, "was added to the AdminData table.")
    else
      PlayerData[tostring(playerSource)] = player
      Debug(player.name, "was added to the PlayerData table.")
    end
  end

  Debug("AdminData table after looping through all of the players: ", json.encode(AdminData))
  Debug("PlayerData table after looping through all of the players: ", json.encode(PlayerData))
end)
