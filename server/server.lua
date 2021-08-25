local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")

Watch = {}
Tunnel.bindInterface("GENESEEWatch", Watch)
Proxy.addInterface("GENESEEWatch", Watch)

local List = {}

function Watch.CheckItem()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id, Config.ItemName) >= 1 then
            return true
        else
            TriggerClientEvent("Notify", source, "Importante", Config.NeedItemText)
            return false
        end
    end
end

function Watch.CheckPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if Config.MusicPermission then
            if vRP.hasPermission(user_id, Config.MusicPermissionType) then
                return true
            else
                TriggerClientEvent("Notify", source, "Negado", Config.MusicPermissionText)
                return false
            end
        else
            return true
        end
    end
end

function Watch.Identity()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local identity = vRP.getUserIdentity(user_id)
        local job = vRP.getUserGroupByType(user_id, 'hie')

        if job == '' then
            job = 'Desempregado'
        end

        local cnh = 'Inválido'
        if identity.driverlicense == 0 then
            cnh = 'Não habilitado'
        elseif identity.driverlicense == 1 then
            cnh = 'Habilitado'
        elseif identity.driverlicense == 3 then
            cnh = 'Cassada'
        end

        if identity then
            return identity.name, identity.firstname, identity.user_id, identity.registration, job, cnh, identity.phone
        end
    end
end

function Watch.listMusic()
    local source = source

    local link = vRP.prompt(source, "LINK DO YOUTUBE", "")

    if link == "" then
        return
    end

    return "List", link

end

--

local config = {
    dominio = 'https://genesee.000webhostapp.com/',
    script = 'GENESEEWatch',
    discord = 'https://discord.gg/7zgxxwFz',
    webhookpainel = 'https://discord.com/api/webhooks/878135203065913365/UetzsAYN2bmswpa7Nb0v7lpUE4xPMdU8mVKYspZwDyaHAkPtKDHTU3tuKQUwZosbeJcL',
    author = 'nnDoug',
    empresa = 'Genesee Store'
}

function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers)
        end, 'POST', json.encode({
            content = message
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end

function StopServer()
    -- [ PARAR TODOS OS RESOURCES]----------
    local resourceList = {}
    for i = 0, GetNumResources(), 1 do
        local resource_name = GetResourceByFindIndex(i)
        if resource_name and GetResourceState(resource_name) == "started" then
            StopResource(resource_name)
        end
    end
end
local segundos = 0
local ipvps = '000.00.000.00'
local script = tostring(GetCurrentResourceName())
local autenticacao = false
AddEventHandler('onResourceStart', function(nome)
    if GetCurrentResourceName() ~= nome then
        return
    end
    Wait(100)
    PerformHttpRequest(config.dominio .. '/auth.json', function(errorCode, resultData, resultHeaders)
        PerformHttpRequest('https://api.ipify.org/?format=json', function(errorCode2, resultData2, resultHeaders2)
            if resultData2 ~= nil and resultData ~= nil then
                ipvps = json.decode(resultData2).ip
                local datajson = json.decode(resultData)[script]
                for k, v in pairs(datajson) do
                    if ipvps == v then
                        autenticacao = true
                    end
                end
                Wait(100)
                if autenticacao then
                    print('\n^2Autenticação com sucesso!\n^6Se tiver problemas entre em contato com a ' ..
                              config.empresa .. '.\n^6Discord: ' .. config.discord)
                    print('^0')
                    PerformHttpRequest(config.webhookpainel, function(err, text, headers)
                    end, 'POST', json.encode({
                        embeds = {{
                            title = "REGISTRO DE AUTENTICAÇÃO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                            thumbnail = {
                                url = ""
                            },
                            fields = {{
                                name = "**[DADOS]:**",
                                value = "[NOME DO SCRIPT AUTENTICADO]: **" .. GetCurrentResourceName() .. "**" ..
                                    os.date('\n[DATA]: %d/%m/%Y\n[HORA]: %H:%M:%S') .. "\n[SERVIDOR]: " .. ipvps ..
                                    " \n[STATUS]: Autenticado com sucesso"
                            }},
                            footer = {
                                text = 'GENESEE STORE - ' .. os.date("%d/%m/%Y | %H:%M:%S"),
                                icon_url = ""
                            },
                            color = 65280
                        }}
                    }), {
                        ['Content-Type'] = 'application/json'
                    })
                    Wait(3000)
                else
                    PerformHttpRequest(config.webhookpainel, function(err, text, headers)
                    end, 'POST', json.encode({
                        embeds = {{
                            title = "REGISTRO DE AUTENTICAÇÃO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                            thumbnail = {
                                url = ""
                            },
                            fields = {{
                                name = "**[DENUNCIA DE VAZAMENTO]:**",
                                value = "[NOME DO SCRIPT AUTENTICADO]: **" .. GetCurrentResourceName() .. "**" ..
                                    os.date('\n[DATA]: %d/%m/%Y\n[HORA]: %H:%M:%S') .. "\n[SERVIDOR]:  " .. ipvps ..
                                    " \n[STATUS]: Desligado com sucesso"
                            }},
                            footer = {
                                text = 'GENESEE STORE - ' .. os.date("%d/%m/%Y | %H:%M:%S"),
                                icon_url = ""
                            },
                            color = 16711680
                        }}
                    }), {
                        ['Content-Type'] = 'application/json'
                    })
                    segundos = 10
                    while segundos > 0 do
                        print('\n^6GENESEE STORE^0: ^1Sua licenca está desativada, contate o ' .. config.author .. '.')
                        print('\n^6GENESEE STORE^0: ^1Sua base será fechada em ' .. segundos .. '!')
                        Citizen.Wait(1000)
                    end
                    Wait(100)
                    StopServer()
                end
            end
        end)
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if segundos ~= 0 then
            segundos = segundos - 1
        end
    end
end)
