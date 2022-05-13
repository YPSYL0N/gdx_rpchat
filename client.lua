local PlayerData = {}
local nbrDisplaying = 1
local staff = false
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData.job = job
end)

RegisterNetEvent(Config.ResourcePrefix..":sendLocalOOC")
AddEventHandler(Config.ResourcePrefix..":sendLocalOOC", function(playerId, title, message, color)
    local player = PlayerId()
    local target = GetPlayerFromServerId(playerId)
    if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
            TriggerEvent("chat:addMessage", {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: 500; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black;  border-right: 4px solid rgba("..color.."); border-radius: 6px;'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px; color: black;'>  L-OOC</font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b> </b> {0} </font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'>| {1} </font></div>",
                args = {title, message}
            })
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":sendTimeoutMsg")
AddEventHandler(Config.ResourcePrefix..":sendTimeoutMsg", function(playerId)
    local player = PlayerId()
    local target = GetPlayerFromServerId(playerId)
    if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 1 then
            TriggerEvent("chat:addMessage", {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'>".._U('cmd_cooldown').."</font></div>"
            })
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":sendMe")
AddEventHandler(Config.ResourcePrefix..":sendMe", function(playerId, title, message, color)
    local player = PlayerId()
    local target = GetPlayerFromServerId(playerId)
    if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
            TriggerEvent("chat:addMessage", {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black;  border-right: 4px solid rgba("..color.."); border-radius: 6px;'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'>  <b>/ME</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b> </b> {0} </font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'>| {1} </font></div>",
                args = {title, message}
            })
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":3dmeTriggerDisplay")
AddEventHandler(Config.ResourcePrefix..":3dmeTriggerDisplay", function(text, source)
    local offsetme = 2.04 + (nbrDisplaying*0.15)
    local player = PlayerId()
    local target = GetPlayerFromServerId(source)
    if target ~= -1 then
        local playerPed = PlayerPedId(source)
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
            DisplayMe(GetPlayerFromServerId(source), text, offsetme)
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":sendDo")
AddEventHandler(Config.ResourcePrefix..":sendDo", function(playerId, title, message, color)
    local player = PlayerId()
    local target = GetPlayerFromServerId(playerId)
    if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
            TriggerEvent("chat:addMessage", {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black;  border-right: 4px solid rgba("..color.."); border-radius: 6px;'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'>  <b>/DO</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b> </b> {0} </font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'>| {1} </font></div>",
                args = {title, message}
            })
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":3ddoTriggerDisplay")
AddEventHandler(Config.ResourcePrefix..":3ddoTriggerDisplay", function(text, source)
    local offsetdo = 2.04 + (nbrDisplaying*0.15)
    local player = PlayerId()
    local target = GetPlayerFromServerId(source)
    if target ~= -1 then
        local playerPed = PlayerPedId(source)
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
            DisplayDo(GetPlayerFromServerId(source), text, offsetdo)
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":3ddocTriggerDisplay")
AddEventHandler(Config.ResourcePrefix..":3ddocTriggerDisplay", function(text, source)
    local offsetdoc = 2.34 + (nbrDisplaying*0.15)
    local player = PlayerId()
    local target = GetPlayerFromServerId(source)
	if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
             DisplayDoc(GetPlayerFromServerId(source), text, offsetdoc)
        end
    end
end)

---------------------------------------------------

RegisterCommand(Config.CubeCMD, function(source, args, rawCommand)
    local number = math.random(1,6)
    ExecuteCommand(Config.MeCMD.." ".._U('cube_1'))
    ExecuteCommand(Config.DocCMD.." 2")
    Citizen.Wait(3000)
    ExecuteCommand(Config.DoCMD.." ".._U('cube_2').." "..number)
end)

RegisterCommand(Config.CoinCMD, function(source, args, rawCommand)
    local luck = math.random(1,2)
        ExecuteCommand(Config.MeCMD.." ".._U('coin_1'))
        ExecuteCommand(Config.DocCMD.." 2")
        Citizen.Wait(3000)
    if luck == 2 then
        ExecuteCommand(Config.DoCMD.." ".._U('coin_2'))
    elseif luck == 1 then
        ExecuteCommand(Config.DoCMD.." ".._U('coin_3'))
    else
        Citizen.Wait(5000)
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":sendTry")
AddEventHandler(Config.ResourcePrefix..":sendTry", function(playerId, title, message, color)
    local player = PlayerId()
    local target = GetPlayerFromServerId(playerId)
    if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
            TriggerEvent("chat:addMessage", {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black;  border-right: 4px solid rgba("..color.."); border-radius: 6px;'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'>  <b>/TRY</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b> </b> {0} </font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'>| {1} </font></div>",
                args = {title, message}
            })
        end
    end
end)

RegisterNetEvent(Config.ResourcePrefix..":tryTriggerDisplay")
AddEventHandler(Config.ResourcePrefix..":tryTriggerDisplay", function(text, source)
    local offsettry = 2.24 + (nbrDisplaying*0.15)
    local player = PlayerId()
    local target = GetPlayerFromServerId(source)
	if target ~= -1 then
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(target)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if target == player or #(playerCoords - targetCoords) < 20 then
             DisplayTry(GetPlayerFromServerId(source), text, offsettry)
        end
    end
end)

-- Functions
function DisplayMe(mePlayer, text, offsetme)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Dme(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetme-1.150, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DisplayDo(mePlayer, text, offsetdo)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(4000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Ddo(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdo-1.150, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDoc(mePlayer, text, offsetdoc)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(1900)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Ddoc(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdoc-1.150, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3Dme(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
    SetTextScale(0.35, 0.35)
    SetTextFont(Config.FontId or 13)
    SetTextProportional(1)
    SetTextColour(251, 0, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    if Config.UseCustomFont then
	AddTextComponentString("<font face='"..Config.FontName.."'>"..text.."</font>")
    else
	AddTextComponentString(text)
    end
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
    end
end

function DrawText3Ddo(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
	SetTextScale(0.35, 0.35)
    SetTextFont(Config.FontId or 13)
    SetTextProportional(1)
    SetTextColour(0, 116, 255, 255)
    SetTextEntry("STRING")
    SetTextOutline()
    SetTextCentre(1)
    if Config.UseCustomFont then
        AddTextComponentString("<font face='"..Config.FontName.."'>"..text.."</font>")
    else
    	AddTextComponentString(text)
    end
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
    end
end

function DrawText3Ddoc(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
    SetTextScale(0.35, 0.35)
    SetTextFont(Config.FontId or 13)
    SetTextProportional(1)
    SetTextColour(0, 116, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    if Config.UseCustomFont then
    	AddTextComponentString("<font face='"..Config.FontName.."'>"..text.."</font>")
    else
    	AddTextComponentString(text)
    end
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0145, 0.030+ factor, 0.03, 0, 0, 0, 68)
    end
end

function DisplayTry(mePlayer, text, offsetdo)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(4000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Dtry(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsettry-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3Dtry(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
      SetTextScale(0.35, 0.35)
      SetTextFont(Config.FontId or 13)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextEntry("STRING")
      SetTextCentre(1)
      if Config.UseCustomFont then
      	AddTextComponentString("<font face='"..Config.FontName.."'>"..text.."</font>")
      else
      	AddTextComponentString(text)
      end
      DrawText(_x,_y)
          local factor = (string.len(text)) / 370
          DrawRect(_x,_y+0.0145, 0.030+ factor, 0.03, 0, 0, 0, 68)
      end
  end

RegisterCommand(Config.HereCMD, function(source, args, rawCommand)
    local argString = table.concat(args, " ")
    local zprava = rawCommand:sub(7)
    local delka = args[1] * "60000"
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent(Config.ResourcePrefix..":HereShareDisplay", coords, zprava, delka)
end)

RegisterNetEvent(Config.ResourcePrefix..":HereTriggerDisplay")
AddEventHandler(Config.ResourcePrefix..":HereTriggerDisplay", function(coords, zprava, delka, source)
    tout = true

    Citizen.CreateThread(function()
        Wait(delka)
		tout = false
	end)

    while tout do 
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local distance = #(pedCoords - coords)
        if distance < 10.0 then
            Draw3DText(coords.x, coords.y, coords.z, zprava)
        end
    end
end)

function Draw3DText(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (2 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
          SetTextScale(0.0*scale, 0.50*scale)
          SetTextFont(Config.FontId or 13)
          SetTextProportional(1)
          SetTextColour(255, 255, 255, 255)
          SetTextDropshadow(0, 0, 0, 255)
          SetTextDropShadow()
          SetTextOutline()
          SetTextEntry("STRING")
          SetTextCentre(1)
          if Config.UseCustomFont then
          	AddTextComponentString("<font face='"..Config.FontName.."'>"..text.."</font>")
          else
          	AddTextComponentString(text)
          end
          DrawText(_x,_y)
      end
  end



