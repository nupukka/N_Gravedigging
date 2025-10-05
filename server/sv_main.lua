local N = require("config")

if N.Core.Framework == "ESX" then
    if N.Core.UseNewESX then
        ESX = exports["es_extended"]:getSharedObject()
    else
        ESX = nil
        CreateThread(function()
            while ESX == nil do
                TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
                Wait(100)
            end
        end)
    end
elseif N.Core.Framework == "QB" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif N.Core.Framework == "QBX" then
    QBCore = exports["qbx-core"]:GetCoreObject()
end

local Cooldown = {}

lib.callback.register('N_gravedigging:policeCount', function(source)
    if N.Core.Framework == "ESX" then
        local policeCount = 0
        for _, job in ipairs(N.PoliceOptions.PoliceJobs) do
            local players = ESX.GetExtendedPlayers('job', job)
            policeCount = policeCount + #players
        end
        return policeCount
    elseif N.Core.Framework == "QB" then
        local policeCount = 0
        for _, job in ipairs(N.PoliceOptions.PoliceJobs) do
            local players = QBCore.Functions.GetPlayers()
            for _, playerId in ipairs(players) do
                local Player = QBCore.Functions.GetPlayer(playerId)
                if Player and Player.PlayerData.job.name == job then
                    policeCount = policeCount + 1
                end
            end
        end
        return policeCount
    elseif N.Core.Framework == "QBX" then
        local policeCount = 0
        for _, job in ipairs(N.PoliceOptions.PoliceJobs) do
            local players = exports['qbx-core']:GetPlayers()
            for _, playerId in ipairs(players) do
                local Player = exports['qbx-core']:GetPlayer(playerId)
                if Player and Player.PlayerData.job.name == job then
                    policeCount = policeCount + 1
                end
            end
        end
        return policeCount
    end
end)

lib.callback.register('N_gravedigging:checkCooldown', function(source, key)
    if Cooldown[key] then 
        return true 
    end
end)

lib.callback.register('N_gravedigging:setCooldown', function(source, key)
    if not N.Options.EnableCooldown then
        return
    end

    if not Cooldown[key] then            
        Cooldown[key] = true 
        SetTimeout(60000 * N.Options.Cooldown, function()
            Cooldown[key] = false
        end)
    end
end)

RegisterNetEvent("N_graves:giveLoot_Server", function(key, playerCoords)

    local grave = N.Graves[key]
    if not N.Graves[key] then
        return
    end

    local distance = #(playerCoords - grave.coords)

    if distance > 5.0 then
        print("[GRAVEDIGGING] ID " .. source .. " tried to dug a grave too far away! (possible cheater!)")
        return
    end

    if N.Core.Inventory == "ox" then 
        for _, item in ipairs(N.Graveloot) do
            local roll = math.random(1, 100)
            if roll <= item.chance then
                local amount = math.random(item.min, item.max)
                exports.ox_inventory:AddItem(source, item.name, amount)
            end
        end
    elseif N.Core.Inventory == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            for _, item in ipairs(N.Graveloot) do
                local roll = math.random(1, 100)
                if roll <= item.chance then
                    local amount = math.random(item.min, item.max)
                    xPlayer.addInventoryItem(item.name, amount)
                end
            end
        end
    elseif N.Core.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            for _, item in ipairs(N.Graveloot) do
                local roll = math.random(1, 100)
                if roll <= item.chance then
                    local amount = math.random(item.min, item.max)
                    Player.Functions.AddItem(item.name, amount)
                end
            end
        end
    end
end)




