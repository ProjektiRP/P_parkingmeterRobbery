Projekti = {}

Projekti.dispatch = "cd-dispatch" -- OPTIONS: 1 = "qs-dispatch",  2 = "cd-dispatch", 3 = "core-dispatch", 4 = "op-dispatch"

-- LOGS ARE IN s_projekti.lua 

Projekti.rob_only_once = true -- if set to FALSE then you can rob the same Parking Meter multiple times (no cooldowns etc)

Projekti.cooldown_time = 2 -- Cooldown is minutes Default = 2

Projekti.progress_time = 25 -- default = 25 seconds

Projekti.police_count = 1



Projekti.notify = {
    ["text_color"] = "#ffffff",
    ["background_color"] = "#000000",
    ["icon"] = "fa-solid fa-tools",

}


Projekti.locales = {
    ["rob"] = "Rob this Parking Meter",

    ["nopolice"] = "Not enough police!",

    ["robbery"] = "Robbery",

    ["Robbery title"] = "Parking Meter Robbery",
    ["Robbery desc"] = "Someone is breaking an Parking Meter",

    ["progressbar"] = "Robbing...",

    ["fail"] = "You failed.",
    ["robbery_success"] = "Robbery was a success!"
    
}



