local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
Watch = Tunnel.getInterface("GENESEEWatch")

local onNui = false
local watch = false

local hour = 0
local minute = 0

local life = 0
local hunger = 100
local thirst = 100

xSound = exports.xsound

RegisterNUICallback("action", function(data)
    local source = source
    local pos = GetEntityCoords(PlayerPedId())

    if data.action == "play" then
        if xSound:soundExists("name") then
            if xSound:isPaused("name") then
                xSound:Resume("name")
            end
        else
            local name, link = Watch.listMusic()

            xSound:PlayUrl("name", link, 0.1, 0)
        end
    elseif data.action == "pause" then
        if xSound:soundExists("name") then
            if xSound:isPlaying("name") then
                xSound:Pause("name")
            end
        end
    elseif data.action == "volume-" then
        xSound:setVolume("name", -0.1)
    elseif data.action == "volume+" then
        xSound:setVolume("name", 0.1)
    elseif data.action == "timeplay" then
        local name, link = Watch.listMusic()

        xSound:PlayUrl("name", link, 0.1, 0)
    end
end)

RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst)
    hunger, thirst = 1.0 - (rHunger / 100), 1.0 - (rThirst / 100)
end)

function calculateTimeDisplay()

    hour = GetClockHours()
    minute = GetClockMinutes()

    if hour <= 9 then
        hour = "0" .. hour
    end

    if minute <= 9 then
        minute = "0" .. minute
    end
end

RegisterCommand('watch', function()

    calculateTimeDisplay()

    local ped = PlayerPedId()
    local life = (GetEntityHealth(ped) - 100) / 300 * 100

    onNui = not onNui

    local name, firsname, user_id, registration, job, cnh, phone = Watch.Identity()

    if onNui then
        SetNuiFocus(true, true)
        SendNUIMessage({
            watch = true,

            hour = hour,
            minute = minute,

            life = life,
            hunger = hunger,
            thirst = thirst,

            name = name,
            firsname = firsname,
            user_id = user_id,
            registration = registration,
            job = job,
            cnh = cnh,
            phone = phone,

            vRP._playAnim(true, {{"anim@random@shop_clothes@watches", "idle_d"}}, true)

        })
    else
        SetNuiFocus(false)
        SendNUIMessage({
            watch = false,

            hour = hour,
            minute = minute,

            life = life,
            hunger = hunger,
            thirst = thirst,

            name = name,
            firsname = firsname,
            user_id = user_id,
            registration = registration,
            job = job,
            cnh = cnh,
            phone = phone,

            vRP._stopAnim(source, false)
        })
    end

end)
