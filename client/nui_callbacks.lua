RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false)
  Debug('NUI Frame hidden.')
  cb({})
end)

---@param data messageInfo
RegisterNUICallback("staffchat:nui:cb:firemessage", function(data, cb)
  if not next(data) then
    return Debug("[staffchat:nui:cb:firemessage] Event was called but the first param is either null or not a table.")
  end

  Debug("[staffchat:nui:cb:firemessage] First param: ", json.encode(data))
  TriggerServerEvent("staffchat:server:firemessage", data)

  cb({})
end)

RegisterNuiCallback("staffchat:nui:cb:settings", function(settings, cb)
  local settings = json.encode(settings)
  SetResourceKvp("staffchat:settings", settings)
  UIMessage("staffchat:nui:settings", json.decode(settings))
  cb({})
end)

RegisterNUICallback("staffchat:nui:cb:clear", function(_body, cb)
  Debug("[staffchat:nui:cb:clear] called.")
  UIMessage("staffchat:clear")
  cb({})
end)

-- Buckets

RegisterNUICallback('teleportToPlayer', function(data, cb)
  TriggerServerEvent('teleportToPlayer', data)
  cb('ok')
end)

RegisterNUICallback('teleportPlayerToMe', function(data, cb)
  TriggerServerEvent('teleportPlayerToMe', data)
  cb('ok')
end)

RegisterNUICallback('jailPlayer', function(data, cb)
  TriggerServerEvent('esx_jail:sendToJail1', data.playerId, data.jailTime, data.jailReason)
  cb('ok')
end)
