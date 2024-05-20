-- client.lua
ESX = exports["es_extended"]:getSharedObject()

local playerIdx = GetPlayerFromServerId(source)
local ped = GetPlayerPed(playerIdx)

local police = false
local model = {'prop_parknmeter_02', 'prop_parknmeter_01'}

exports.ox_target:addModel(model, {
    {
        label = Projekti.locales["rob"],
        icon = 'fa-solid fa-tools',
        onSelect = function()
            if GetSelectedPedWeapon(ped) == GetHashKey("weapon_crowbar") then
                rob_parkmeter()
            else
                lib.notify({
                    title = Projekti.locales["need"],
                    position = 'center-right',
                    icon = 'fa-solid fa-tools',
                    iconColor = '#C53030'
                })
            end
        end,
    }
})

function rob_parkmeter()
    local cops = 0
    ESX.TriggerServerCallback('parkmeter:getPoliceCount', function(_cops)
        cops = _cops
    end)

    Wait(500)

    if cops < Projekti.police_count then
        lib.notify({
            title = Projekti.locales["nopolice"],
            position = 'center-right',
            icon = 'fa-solid fa-tools',
            iconColor = '#C53030'
        })
        return
    else
        TriggerServerEvent("projekti:log")
        local success = lib.skillCheck({'medium', 'medium', 'hard'}, {'e'})

        if success then
            local success2 = lib.progressBar({
                duration = (Projekti.progress_time * 1000),
                label = Projekti.locales["progressbar"],
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                    move = true
                },
                anim = {
                    dict = 'mini@repair',
                    clip = 'fixing_a_ped'
                },
            })
            if success2 then
                TriggerServerEvent("projekti:parkmeter:robbery")
                lib.notify({
                    title = Projekti.locales["robbery_success"],
                    position = 'center-right',
                    icon = 'check-double',
                    iconColor = '#34eb34'
                })
            else
                lib.notify({
                    title = Projekti.locales["fail"],
                    position = 'center-right',
                    icon = 'fa-solid fa-tools',
                    iconColor = '#C53030'
                })
            end
        else
            lib.notify({
                title = Projekti.locales["fail"],
                position = 'center-right',
                icon = 'fa-solid fa-tools',
                iconColor = '#C53030'
            })
        end

        local PlayerPed = PlayerPedId()
        local coords = GetEntityCoords(PlayerPed)

        if Projekti.dispatch == "qs-dispatch" then
            local playerData = exports['qs-dispatch']:GetPlayerInfo()

            if not playerData then
                print("Error getting player data")
                return
            end

            exports['qs-dispatch']:getSSURL(function(image)
                local dispatch = TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                    job = { 'police', 'sheriff', 'traffic', 'patrol' },
                    callLocation = playerData.coords,
                    callCode = { code = 'Parkingmeter', snippet = Projekti.locales["robbery"] },
                    message = Projekti.locales["Robbery desc"],
                    flashes = false,
                    image = "https://cdn.discordapp.com/attachments/1207717557637746759/1209514644750729276/image.png?ex=65e7334b&is=65d4be4b&hm=136f478ae6ec26be4e912e91bd70e50a781805cd1db27daeac80f0b3ba09f9ce&",
                    blip = {
                        sprite = 500,
                        scale = 1.9,
                        colour = 1,
                        flashes = true,
                        text = Projekti.locales["Robbery desc"],
                        time = (20 * 100000), -- 20 secs
                    }
                })
            end)
        elseif Projekti.dispatch == "cd-dispatch" then
            local data = exports['cd_dispatch']:GetPlayerInfo()
            local dispatch = TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = {'police'},
                coords = data.coords,
                title = Projekti.locales["Robbery title"],
                message = Projekti.locales["Robbery desc"],
                flash = 0,
                unique_id = data.unique_id,
                sound = 1,
                blip = {
                    sprite = 431,
                    scale = 1.2,
                    colour = 3,
                    flashes = false,
                    text = Projekti.locales["Robbery desc"],
                    time = 5,
                    radius = 0,
                }
            })
        elseif Projekti.dispatch == "core-dispatch" then
            TriggerServerEvent(
                "core_dispatch:addMessage",
                Projekti.locales["Robbery title"],
                {coords[1], coords[2], coords[3]},
                "police",
                5000,
                11,
                5
            )
        elseif Projekti.dispatch == "op-dispatch" then
            local job = "police" -- Jobs that will receive the alert
            local text = Projekti.locales["Robbery desc"] -- Main text alert
            local coords = GetEntityCoords(PlayerPedId()) -- Alert coords
            local id = GetPlayerServerId(PlayerId()) -- Player that triggered the alert
            local title = Projekti.locales["Robbery title"] -- Main title alert
            local panic = true -- Allow/Disable panic effect

            TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
        end
    end

    if Projekti.rob_only_once then
        exports.ox_target:removeModel(model)

        Wait(Projekti.cooldown_time * 60000)

        exports.ox_target:addModel(model, {
            {
                label = Projekti.locales["rob"],
                icon = 'fa-solid fa-tools',
                onSelect = function()
                    if GetSelectedPedWeapon(ped) == GetHashKey("weapon_crowbar") then
                        rob_parkmeter()
                    end
                end,
            }
        })
    end
end
