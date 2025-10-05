lib.locale()
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


function Notify(notification)
    if N.Core.Notification == "ox" then
        lib.notify({
            title = locale("NotificationTitle"),
            description = notification,
            type = 'inform'
        })
    elseif N.Core.Notification == "esx" then
        ESX.ShowNotification(notification)
    end
end

function ProgressBar(label)
    if N.Core.Progressbar == "ox_square" then
        lib.progressBar({
            duration = N.Options.ProgressDuration,
            label = label,
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                combat = true,
                car = true,
            },
            anim = {
                dict = "random@burial",
                clip = "a_burial",
            },
            prop = {
                model = GetHashKey("prop_tool_shovel"),
                bone = 28422,
                pos = vector3(0.03, 0.01, 0.2),
                rot = vector3(0.0, 0.0, -9.5)
            },
        })
    elseif N.Core.Progressbar == "ox_circle" then
        lib.progressCircle({
            duration = N.Options.ProgressDuration,
            position = 'bottom',
            label = label,
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                combat = true,
                car = true,
            },
            anim = {
                dict = "random@burial",
                clip = "a_burial",
            },
            prop = {
                model = GetHashKey("prop_tool_shovel"),
                bone = 28422,
                pos = vector3(0.03, 0.01, 0.2),
                rot = vector3(0.0, 0.0, -9.5)
            },
        })
    end
end

function PoliceAlert()
    if not N.PoliceOptions.EnablePoliceAlert then return end
    if N.PoliceOptions.PoliceAlert == "opto-dispatch" then
        for k,v in pairs(N.PoliceOptions.PoliceJobs) do
        local job = v
        local text = "Somebody is digging a grave!"
        local coords = GetEntityCoords(PlayerPedId()) 
        local id = GetPlayerServerId(PlayerId()) 
        local title = "Gravedigging" 
        local panic = false 
        TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
        end
    elseif N.PoliceOptions.PoliceAlert == "aty-dispatch" then
        exports["aty_dispatch"]:SendDispatch("Gravedigging", "10-26", 310, N.PoliceOptions.PoliceJobs)
    elseif N.PoliceOptions.PoliceAlert == "cd_dispatch" then
            local data = exports['cd_dispatch']:GetPlayerInfo()
            TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = N.PoliceOptions.PoliceJobs,
                coords = data.coords,
                title = '10-15 - Gravedigging',
                message = ''..data.sex..' is digging a grave!', 
                flash = 0,
                unique_id = data.unique_id,
                sound = 1,
                blip = {
                sprite = 310,
                scale = 1.2,
                colour = 1,
                flashes = false,
                text = '911 - Gravedigging',
                time = 5,
                sound = 1,
            }
        })
    end
end