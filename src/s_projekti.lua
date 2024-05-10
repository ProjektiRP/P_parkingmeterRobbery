-- server.lua
ESX = exports["es_extended"]:getSharedObject()

local logs = "WEBHOOK"
local communityname = "@projekti_logs"
local communitylogo = "https://cdn.discordapp.com/attachments/1120106903742193777/1234129582156681337/logo2.png?ex=662f9c3d&is=662e4abd&hm=38f35eaa367336b691ea95067e5e74c4085fb242a67fedee8160128b39e3a9ee&"

ESX.RegisterServerCallback('parkmeter:getPoliceCount', function(source, cb)
    local count = 0

    for _, playerId in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer.job.name == 'police' then
            count = count + 1
        end
    end

    cb(count)
end)

RegisterServerEvent("projekti:parkmeter:robbery")
AddEventHandler("projekti:parkmeter:robbery", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local items = {
        "black_money",
    }

    local randomIndex = math.random(#items)
    local randomItem = items[randomIndex]

    local black_money = math.random(150, 300)

    exports['ox_inventory']:AddItem(xPlayer.source, randomItem, black_money) -- ox_inventory log export
end)

RegisterServerEvent("projekti:log")
AddEventHandler("projekti:log", function()
    local name = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local ping = GetPlayerPing(source)
    local steamhex = GetPlayerIdentifier(source)
    local discordid, discordusername, discorddiscriminator = nil, nil, nil
    local identifiers = GetPlayerIdentifiers(source)
    for _, id in ipairs(identifiers) do
        if string.sub(id, 1, 8) == "discord:" then
            discordid = string.sub(id, 9)
            discordusername = string.sub(id, 10, -6)
            discorddiscriminator = string.sub(id, -5)
            break
        end
    end
    local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "PARKMETER ROBBERY",
            ["description"] = " **Steam name:** " .. name .. "\n **IP address:** " .. ip .. "\n **Steam HEX ID:** " .. steamhex .. "\n **Discord ID:** <@" .. discordid .. ">",
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communitylogo,
            },
        }
    }
    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Projekti Logs", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)
