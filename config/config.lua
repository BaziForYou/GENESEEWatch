Config = {}

------------------------------------------------------------------
-- Comandos/bind
------------------------------------------------------------------
Config.Command = true -- ativa ou desativa o watch por comandos
Config.CommandControl = "watch" -- comando utilizado

Config.Bind = false -- ativa ou desativa o watch por bind 
Config.BindControl = 10 -- para saber o botão ideal siga as documentações em https://docs.fivem.net/docs/game-references/controls/

------------------------------------------------------------------
-- Item
------------------------------------------------------------------
Config.NeedItem = false -- ativar ou desativar a necessidade de item (watch)
Config.ItemName = "watch" -- comando utilizado
Config.NeedItemText = "Você não possui um Watch, adquire na Loja Digitalden."

------------------------------------------------------------------
-- Music
------------------------------------------------------------------
Config.MusicPermission = false -- ativar ou desativa a necessidade de permisao para usar o sistema de musica
Config.MusicPermissionType = "som.permissao" -- permissao necessario caso a opção acima seja TRUE
Config.MusicPermissionText = "Você não possui permissao para usar nosso player de musica."

------------------------------------------------------------------
-- Fome e Sede
------------------------------------------------------------------
Config.hungerthirst = "vrp_hud:update" -- função para fome e sede, normalmente voce encontra em VRP/MODULES/SURVIVAL.LUA

------------------------------------------------------------------
-- Outros
------------------------------------------------------------------
Config.Focus = true -- ativa ou desativa o movimento do player
Config.Cursor = true -- ativa ou desativa o cursor do mouse
