lib.locale()
local N = require("config")

local spawnedPriests = {}

local function playerCoords()
    return GetEntityCoords(PlayerPedId())
end

local function hasRequiredItem()
    if N.Core.Inventory == "ox" then
        return exports.ox_inventory:Search("count", N.Options.Diggingitem) > 0
    elseif N.Core.Inventory == "esx" then
        local xPlayer = ESX.GetPlayerFromId(PlayerId())
        return xPlayer.getInventoryItem(N.Options.Diggingitem).count > 0
    elseif N.Core.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(PlayerId())
        return Player.Functions.GetItemByName(N.Options.Diggingitem) ~= nil
    end
    return false
end

local function spawnPriest()
    local npcModel = GetHashKey(N.PriestOptions.PriestModel)
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do Wait(100) end

    local pos = N.PriestOptions.Priestspawn
    local npc = CreatePed(4, npcModel, pos.x, pos.y, pos.z + 1.0, 0.0, true, true)

    SetEntityAsMissionEntity(npc, true, true)
    GiveWeaponToPed(npc, GetHashKey(N.PriestOptions.Priestweapon), 9999, true, true)
    SetEntityHealth(npc, 105)
    SetPedCombatAttributes(npc, 46, true)
    TaskCombatPed(npc, PlayerPedId(), 0, 16)

    spawnedPriests[#spawnedPriests + 1] = npc

    CreateThread(function()
        while DoesEntityExist(npc) and not IsEntityDead(npc) do
            Wait(1000) 
        end

        if DoesEntityExist(npc) then
            Wait(N.PriestOptions.Priestcleaning)
            if DoesEntityExist(npc) then DeleteEntity(npc) end
        end

        for i = #spawnedPriests, 1, -1 do
            if spawnedPriests[i] == npc then
                table.remove(spawnedPriests, i)
                break
            end
        end
    end)
end

local function handleGraveDigging(key)
    if lib.callback.await("N_gravedigging:policeCount", false) < N.PoliceOptions.Policeneeded then
        return Notify(locale("NotEnoughPolices"))
    end

    if lib.callback.await("N_gravedigging:checkCooldown", false, key) then
        return Notify(locale("CooldownNotify"))
    end

    if not lib.skillCheck(N.Minigame.Difficulty, N.Minigame.Keys) then
        return Notify(locale("FailNotify"))
    end

    ProgressBar(locale("ProgressbarLabel"))
    TriggerServerEvent("N_graves:giveLoot_Server", key, playerCoords())
    PoliceAlert()
    lib.callback.await("N_gravedigging:setCooldown", false, key)

    if math.random(100) <= N.PriestOptions.Priestchance then
        spawnPriest()
    end
end

if N.Core.InteractType == "target" then
    for key, grave in ipairs(N.Graves) do
        exports.ox_target:addBoxZone({
            coords = grave.coords,
            size = grave.size,
            rotation = grave.rotation,
            debug = false,
            options = {{
                icon = "fa-solid fa-skull",
                label = locale("TargetOption"),
                items = N.Options.Diggingitem,
                distance = N.Options.Distance,
                onSelect = function() handleGraveDigging(key) end
            }}
        })
    end

elseif N.Core.InteractType == "textui" then
    for key, grave in ipairs(N.Graves) do
        local point = lib.points.new({
            coords = grave.coords,
            distance = N.Options.Distance
        })

        function point:onEnter()
            if hasRequiredItem() then
                lib.showTextUI(locale("TextuiOption"), {
                    icon = "fa-solid fa-skull",
                    position = "right-center"
                })
            end
        end

        function point:onExit()
            lib.hideTextUI()
        end

        function point:nearby()
            if hasRequiredItem() and IsControlJustPressed(0, 38) then
                handleGraveDigging(key)
            end
        end
    end
end


CreateThread(function()
    local pos, blip = N.Blip.Position
    blip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(blip, N.Blip.Sprite)
    SetBlipDisplay(blip, N.Blip.Display)
    SetBlipScale(blip, N.Blip.Scale)
    SetBlipColour(blip, N.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(locale("Blipname"))
    EndTextCommandSetBlipName(blip)
end)
