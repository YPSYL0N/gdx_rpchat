ESX = nil
TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)

local timeout = false

-- If need this edited chat style in es_extended
-- AddEventHandler("es:invalidCommandHandler", function(source, command_args, user)
--     CancelEvent()
--     TriggerClientEvent("chat:addMessage", source, {
--         template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'> This is not a valid command!</font></div>",
--         args = {}
--     })
-- end)

-- L-OOC
AddEventHandler("chatMessage", function(source, name, message)
    if string.sub(message, 1, string.len('/')) ~= '/' then
        CancelEvent()

            name = GetPlayerName(source)

        if not timeout then
            TriggerClientEvent(Config.ResourcePrefix..":sendLocalOOC", -1, source, name, message, Config.LoocColor)
            timeout = true
        else
            TriggerClientEvent(Config.ResourcePrefix..":sendTimeoutMsg", -1, source)
        end

        SetTimeout(1000, function()
            timeout = false
        end)
    end
end)

-- ME command
RegisterCommand(Config.MeCMD, function(source, args, rawCommand)
    if source == 0 then
        Debug(_U('console_write_error'))
        return
    end

    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    if Config.EnableESXIdentity then
        name = GetRealPlayerName(source)
    end

    TriggerClientEvent(Config.ResourcePrefix..":sendMe", -1, source, name, args, Config.MeColor)
    TriggerClientEvent(Config.ResourcePrefix..":3dmeTriggerDisplay", -1, args, source)
end)

-- DO command
RegisterCommand(Config.DoCMD, function(source, args, rawCommand)
    if source == 0 then
        Debug(_U('console_write_error'))
        return
    end

    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    if Config.EnableESXIdentity then
        name = GetRealPlayerName(source)
    end

    TriggerClientEvent(Config.ResourcePrefix..":sendDo", -1, source, name, args, Config.DoColor)
    TriggerClientEvent(Config.ResourcePrefix..":3ddoTriggerDisplay", -1, args, source)
end)

-- DOC command
RegisterCommand(Config.DocCMD, function(source, args, rawCommand)
    if source == 0 then
        Debug(_U('console_write_error'))
        return
    end

    args = table.concat(args, ' ')

    if args == nil then
        TriggerClientEvent("chat:addMessage", source, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'> ".._U('doc_error').."</font></div>",
            args = {}
        })
        return
    end

    local name = GetPlayerName(source)

    if Config.EnableESXIdentity then
        name = GetRealPlayerName(source)
    end

    local docNumber = Config.docNumber
    local counter_doc = 0
    local repeatNumber = tonumber(args)
    if repeatNumber <= docNumber then
        while counter_doc < repeatNumber do
            counter_doc = counter_doc + 1
            TriggerClientEvent(Config.ResourcePrefix..":sendDo", -1, source, name, counter_doc .. "/" .. repeatNumber, Config.DocColor)
            TriggerClientEvent(Config.ResourcePrefix..":3ddocTriggerDisplay", -1, counter_doc .. "/" .. repeatNumber, source)
            Citizen.Wait(2000)
        end
    else
        TriggerClientEvent("chat:addMessage", source, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'> ".._U('doc_error_number', docNumber).."</font></div>",
            args = {}
         })
    end
end)

-- TRY command
RegisterCommand(Config.TryCMD, function(source, args, rawCommand)
    if source == 0 then
        Debug(_U('console_write_error'))
        return
    end

    args = table.concat(args, ' ')
    local luck = math.random(1,2)
    local name = GetPlayerName(source)
    if Config.EnableESXIdentity then
        name = GetRealPlayerName(source)
    end

    TriggerClientEvent(Config.ResourcePrefix..":sendTry", -1, source, name, args, Config.TryColor)

    if luck == 2 then
        TriggerClientEvent(Config.ResourcePrefix..":3ddoTriggerDisplay", -1, "~h~~g~[".._U('try_success').."]", source)
    elseif luck == 1 then
        TriggerClientEvent(Config.ResourcePrefix..":3ddoTriggerDisplay", -1, "~h~~r~[".._U('try_success').."]", source)
    else
        Citizen.Wait(5000)
    end

end)

RegisterServerEvent(Config.ResourcePrefix..":HereShareDisplay")
AddEventHandler(Config.ResourcePrefix..":HereShareDisplay", function(coords, msg, length)
	TriggerClientEvent(Config.ResourcePrefix..":HereTriggerDisplay", -1, coords, msg, length, source)
end)

-- Announcement A-T
RegisterCommand(Config.OznCMD, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = 'A-TEAM'
    local adminName = GetPlayerName(source)
    local color = Config.OznColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.group == "admin" or xPlayer.group == "superadmin" then
        for _, player in ipairs(GetPlayers()) do
            if Config.UseTNotify then
                TriggerClientEvent("t-notify:client:Custom", player, {
                    style = 'EMS',
                    title = "A-T Announcement",
                    message = toSay,
                    duration = 120000,
                    sound = true
                })
            end
            TriggerClientEvent("chat:addMessage", -1, {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black;  border-right: 4px solid rgba("..color.."); border-radius: 6px;'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'>  <b>"..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b> </b> {0} </font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'>| {1} </font></div>",
                args = {adminName, toSay}
            })
        end
    end
end, true)

-- THIEF command
RegisterCommand(Config.ThiefCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = "Thiefs"
    local color = Config.ThiefColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if not timeout then
        if xPlayer.job.name ~= "police" or xPlayer.job.name ~= "ambulance" then
            TriggerClientEvent("chat:addMessage", -1, {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba('..color..'); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
                args = {toSay}
            })
        else
            TriggerClientEvent("chat:addMessage", -1, {
                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'> ".._U('thief_error').."</font></div>"
            })
        end
        timeout = true
    else
        TriggerClientEvent(Config.ResourcePrefix..":sendTimeoutMsg", -1, source)
    end

    SetTimeout(5000, function()
        timeout = false
    end)
end)

-- POLICE
RegisterCommand(Config.PoliceCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = "POLICE"
    local color = Config.PoliceColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.job.name == "police" then
        for _, player in ipairs(GetPlayers()) do
            if Config.UseTNotify then
                TriggerClientEvent("t-notify:client:Custom", player, {
                    style = 'PD',
                    title = "POLICE",
                    message = toSay,
                    duration = 12000,
                    image = "https://i.imgur.com/jvLPXxi.png",
                    sound = true
                })
            end
        end
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba('..color..'); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
            args = {toSay}
        })
    else
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'>".._U('not_pd').."</font></div>"
        })
    end
end)

-- SHERIFF
RegisterCommand(Config.SheriffCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = "SHERIFF"
    local color = Config.SheriffColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.job.name == 'police' then
        for _, player in ipairs(GetPlayers()) do
            if Config.UseTNotify then
                TriggerClientEvent("t-notify:client:Custom", player, {
                    style = 'SD',
                    title = "SHERIFF",
                    message = toSay,
                    duration = 12000,
                    image = "https://i.imgur.com/jvLPXxi.png",
                    sound = true
                })
            end
        end
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba("..color.."); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
            args = {toSay}
        })
    else
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'>".._U('not_sd').."</font></div>"
        })
    end
end)


-- AMBULANCE
RegisterCommand(Config.AmbulanceCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = "AMBULANCE"
    local color = Config.AmbulanceColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.job.name == "ambulance" then
        for _, player in ipairs(GetPlayers()) do
            if Config.UseTNotify then
                TriggerClientEvent("t-notify:client:Custom", player, {
                    style = 'EMS',
                    title = "AMBULANCE",
                    message = toSay,
                    duration = 12000,
                    image = "https://i.imgur.com/iYUfzeS.png",
                    sound = true
                })
            end
        end
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba("..color.."); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
            args = {toSay}
        })
    else
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'>".._U('not_ems').."</font></div>"
        })
    end
end)

-- Jail command
RegisterCommand(Config.JailCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = "Jail"
    local color = Config.JailColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.job.name == "police" then
        for _, player in ipairs(GetPlayers()) do
            if Config.UseTNotify then
                TriggerClientEvent("t-notify:client:Custom", player, {
                    style = 'PD',
                    title = "Jail",
                    message = toSay,
                    duration = 12000,
                    image = 'https://i.imgur.com/jvLPXxi.png',
                    sound = true
                })
            end
        end
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba('..color..'); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
            args = {toSay}
        })
    else
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'>".._U('not_guard').."</font></div>"
        })
    end
end)

-- Government
RegisterCommand(Config.GovernmentCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = 'Government'
    local color = Config.GovernmentColor
    local toSay = ''

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.job.name == "goverment" then
        for _, player in ipairs(GetPlayers()) do
            if Config.UseTNotify then
                TriggerClientEvent('t-notify:client:Custom', player, {
                    style = 'SD',
                    title = "Government",
                    message = toSay,
                    duration = 12000,
                    image = "https://i.imgur.com/jvLPXxi.png",
                    sound = true
                })
            end
        end
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba("..color.."); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
            args = {toSay}
        })
    else
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'>".._U('not_government').."</font></div>"
        })
    end
end)

-- ADVERT
RegisterCommand(Config.AdvertCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = "ADVERT"
    local color = Config.AdvertColor
    local toSay = ''
    local price = Config.AdvertPrice

    for i=1, #args do
        toSay = toSay .. args[i] .. ' '
    end

    if xPlayer.getMoney() >= price then
        TriggerClientEvent("chat:addMessage", -1, {
            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba("..color.."); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
            args = {toSay}
        })
        xPlayer.removeMoney(price)

        if Config.UseTNotify then
            TriggerClientEvent("t-notify:client:Custom", source, {
                style = 'info',
                title = "Maze Bank",
                message = _U('advert_pay', price),
                duration = 8000,
                image = "https://i.imgur.com/hh0LgUA.png",
                sound = true
            })
        else
            Notif(source, _U('advert_pay', price), 1)
        end
    else
        if Config.UseTNotify then
            TriggerClientEvent("t-notify:client:Custom", source, {
                style = 'info',
                title = "Maze Bank",
                message = _U('no_money'),
                duration = 8000,
                image = "https://i.imgur.com/hh0LgUA.png",
                sound = true
            })
        else
            Notif(source, _U('no_money'), 3)
        end
    end
end)

-- Custom chat groups messages
Citizen.CreateThread(function()
        for k,v in pairs(Config.JobsChat) do
            RegisterCommand(v.cmd, function(source, args, rawCommand)
                local xPlayer = ESX.GetPlayerFromId(source)
                local name = v.name
                local job = v.job
                local jobLabel = v.job_label
                local color = v.color
                local toSay = ""

                for i=1, #args do
                    toSay = toSay .. args[i] .. ''
                end

                if job ~= "" then
                    if xPlayer.job.name == job then
                        for _, player in ipairs(GetPlayers()) do
                            TriggerClientEvent("chat:addMessage", -1, {
                                template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba("..color.."); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
                                args = {toSay}
                            })
                        end
                    else
                        TriggerClientEvent("chat:addMessage", -1, {
                            template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba(255, 0, 0, 1.0); border-radius: 6px; border-right'> <font style='background-color:rgba(255, 0, 0, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> ERROR</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: bold; font-size: 16px; border-radius: 0px;'> ".._U('not_employee').." "..jobLabel.."!</font></div>"
                        })
                    end
                else
                    TriggerClientEvent("chat:addMessage", -1, {
                        template = "<div style='padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.95); font-weight: bold; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; border-right: 4px solid rgba("..color.."); border-radius: 6px; border-right'> <font style='background-color:rgba("..color.."); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 4px;'> <b> "..name.."</b></font><font style='font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;'><b></b></font><font style='font-weight: 500; font-size: 16px; border-radius: 0px;'> {0}</font></div>",
                        args = {toSay}
                    })
                end

            end)
        end
end)



















---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
                local first = xPlayer.get('firstName')
                first = string.sub(first, 1, 1)
                local second = xPlayer.get('lastName')
                second = string.sub(second, 1, 1)
                local shortName = first..". "..second..". "
                return shortName
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end

function Debug(msg)
    print("^2["..Config.Resource.."]^0 "..msg)
end

function Notif(source, msg, type)
    if Config.NotificationType == "esx" then
        if type == 1 then
            source.showNotification(msg, false, false, 40)
        elseif type == 2 then
            source.showNotification(msg, false, false, 210)
        elseif type == 3 then
            source.showNotification(msg, false, false, 130)
        end
    elseif Config.NotificationType == "t-notify" then
        if type == 1 then
            TriggerClientEvent('t-notify:client:Custom', source, {
                style = 'info',
                duration = 8000,
                message = msg,
                sound = true
            })
        elseif type == 2 then
            TriggerClientEvent('t-notify:client:Custom', source, {
                style = 'success',
                duration = 8000,
                message = msg,
                sound = true
            })
        elseif type == 3 then
            TriggerClientEvent('t-notify:client:Custom', source, {
                style = 'error',
                duration = 8000,
                message = msg,
                sound = true
            })
        end
    elseif Config.NotificationType == "okok" then
        if type == 1 then
            TriggerClientEvent('okokNotify:Alert', source, _U('jobname'), msg, 8000, 'info')
        elseif type == 2 then
            TriggerClientEvent('okokNotify:Alert', source, _U('jobname'), msg, 8000, 'success')
        elseif type == 3 then
            TriggerClientEvent('okokNotify:Alert', source, _U('jobname'), msg, 8000, 'error')
        end
    elseif Config.NotificationType == "other" then
        if type == 1 then
            -- set here your notification export (info)
        elseif type == 2 then
            -- set here your notification export (success)
        elseif type == 3 then
            -- set here your notification export (error)
        end
    else
        Debug("Error with check notification. Please check or set valid notification type in config")
    end
end