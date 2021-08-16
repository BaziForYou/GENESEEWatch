local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")

watch = {}
Tunnel.bindInterface("gene_watch", watch)
Proxy.addInterface("gene_watch", watch)

function watch.Identidade()
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
