-- config.lua
Projekti = {}

Projekti.dispatch = "cd-dispatch" -- OPTIONS: 1 = "qs-dispatch", 2 = "cd-dispatch", 3 = "core-dispatch", 4 = "op-dispatch"

-- LOGS ARE IN s_projekti.lua

Projekti.rob_only_once = true -- if set to FALSE, you can rob the same Parking Meter multiple times (no cooldowns etc)

Projekti.cooldown_time = 2 -- Cooldown in minutes, Default = 2

Projekti.progress_time = 25 -- in seconds, default = 25

Projekti.police_count = 1

Projekti.notify = {
    ["text_color"] = "#ffffff",
    ["background_color"] = "#000000",
    ["icon"] = "fa-solid fa-tools",
}

Projekti.locales = {
    ["rob"] = "Rob Parking Meter",
    ["need"] = "You need something longer than your arm",
    ["nopolice"] = "Not enough police around!",
    ["robbery"] = "Robbery",
    ["Robbery title"] = "Parking Meter Robbery",
    ["Robbery desc"] = "Someone is robbing a parking meter",
    ["progressbar"] = "Robbing...",
    ["fail"] = "Failed!",
    ["robbery_success"] = "You successfully robbed it!"
}
