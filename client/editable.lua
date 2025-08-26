local playerOnDuty = false

-- if you are using a tatto shop you may need to edit this code
function editHairOverlay(playerPed, val)
    local isMale = GetEntityModel(playerPed) == 1885233650
    local pedDecoration = GetPedDecorations(playerPed) -- Get Old Tattoo Value
    ClearPedDecorations(playerPed)                     -- Reset All Tattos

    if val > 0 then
        local configData = isMale and config.hairOverlaysMale[val] or config.hairOverlaysFemale[val]
        if configData then
            AddPedDecorationFromHashes(playerPed, joaat(configData.collection), joaat(configData.overlay)) -- Apply new hair overlay
        end
    end

    for i = 1, #pedDecoration do                                                            -- Restore Old Tattoos
        local hash = toSigned(pedDecoration[i][2])
        if not config.hairOverlaysHash[hash] then                                           -- If not old hair overlay value
            AddPedDecorationFromHashes(playerPed, pedDecoration[i][1], pedDecoration[i][2]) -- Aply old tattoo
        end
    end
end

---@return boolean
function getOnDutyState()
    if config.framework == "qb" then
        return playerOnDuty
    else
        -- ESX does not have a duty system
        return false
    end
end

-- QB Core update player onDuty state
RegisterNetEvent('QBCore:Client:SetDuty', function(newDuty)
    playerOnDuty = newDuty
end)

---@param name? string
function openOutfitMenu(name)
    if config.clothingAsItem then
        if not name then
            name = ("dolap_%s_%s"):format("default", PlayerData.citizenid or PlayerData.identifier)
        end
        TriggerServerEvent("tgiann-clothing:server:openOutfitMenu", name)
    else
        TriggerEvent("tgiann-clothing:openOutfitMenu")
    end
end

RegisterNetEvent('tgiann-clothing:openOutfitMenu')
---@param name? string
AddEventHandler('tgiann-clothing:openOutfitMenu', function(name)
    if not config.clothingAsItem then
        sendNui("changeStateOutfitMenu", {
            type = "playerwardrope",
            clientData = getClientData(),
        })
        SetNuiFocus(true, true)
    else
        -- Some paid scripts try to open the stash using this event.
        openOutfitMenu(name)
    end
end)

RegisterNetEvent('qb-clothing:client:openOutfitMenu') -- QB open outfit menu event
AddEventHandler('qb-clothing:client:openOutfitMenu', openOutfitMenu)

RegisterNetEvent('tgiann-clothing:openOutfitStash')
AddEventHandler('tgiann-clothing:openOutfitStash', openOutfitMenu)

RegisterNetEvent("tgiann-core:notifData")
---@param text string
---@param _ "primary" | "success" | "error"
---@param time? number
AddEventHandler("tgiann-core:notifData", function(text, _, time)
    sendNui("notif", { text = text, time = time or 5000 })
end)

RegisterNetEvent('qb-clothing:client:loadPlayerClothing') -- QB Multichar load ped
AddEventHandler('qb-clothing:client:loadPlayerClothing', loadPedClothing)

function removeWeapon()
    TriggerEvent("inventory:client:removeWeapon")
end

function canRefreshSkin()
    --return not exports["qb-customs"]:inMechanicMenu()
    return true
end

function uiIsOpen(open)
    if open then
        TriggerEvent("tgiann-hud:ui", false)
        TriggerEvent("tgiann-lumihud:ui", false)
    else
        TriggerEvent("tgiann-hud:ui", true)
        TriggerEvent("tgiann-lumihud:ui", true)
    end
    if config.displayRadar then
        DisplayRadar(not open)
    end
end

function genderToModel(PlayerData)
    if config.framework == "qb" then
        return PlayerData.charinfo.gender == 1 and `mp_f_freemode_01` or `mp_m_freemode_01`
    else
        return PlayerData.sex == "f" and `mp_f_freemode_01` or `mp_m_freemode_01`
    end
end

function setCamActive()
    --exports["tgiann-abskill"]:camActive()
end

function teleportPlayer(x, y, z)
    SetEntityCoords(PlayerPedId(), x, y, z)
    --exports["tgiann-abskill"]:teleportPlayer(false, x, y, z)
end

function canInspect()
    if exports["tgiann-hud"]:isDoingAction() then
        tgiCore.notif("Bir Şey Yaparken Kıyafet İncelemeyi Kullanamazsın!", "error")
        return false
    end
    return true
end

function setHealth(ped, health)
    SetEntityHealth(ped, health)
    --exports["tgiann-abskill"]:setHealth(ped, health)
end

function setArmour(ped, armor)
    SetPedArmour(ped, armor)
    --exports["tgiann-abskill"]:setArmour(ped, armor)
end

function skinLoaded(firstChar)
    ClearPedScubaGearVariation(PlayerPedId())
    TriggerEvent("esx_tatoo:loadTattoo")
    TriggerEvent("tgiann-bettercombat:setLastWalking")
    if config.framework == "esx" and firstChar then
        Wait(2000)
        RenderScriptCams(false, false, 1, true, true)
        DoScreenFadeIn(0)
    end
    SetFocusEntity(PlayerPedId())
end

function createFirstCharacter()
    --exports["tgiann-wiki"]:startWiki()
    TriggerEvent("tgiann-main:afk-control", false)
    TriggerServerEvent("jsfour-idcard:give-idCard")
end

function FirstCharacterCreated()
    if config.framework == "esx" then
        Wait(2000)
        RenderScriptCams(false, false, 1, true, true)
        DoScreenFadeIn(0)
    end
    SetFocusEntity(PlayerPedId())
    TriggerEvent("tgiann-main:afk-control", true)
    TriggerEvent('tgiann-main:checkProfileSettings')
end

function getHealthAndArmor(fristLoaded)
    local health, armor = fristLoaded and PlayerData?.metadata?.health or GetEntityHealth(PlayerPedId()), fristLoaded and PlayerData?.metadata?.armor or GetPedArmour(PlayerPedId())
    return health, armor
end

---@return string, number
function getPlayerJobNameGrade()
    if not PlayerData.job then PlayerData = tgiCoreExports:getPlayerData() end
    if not PlayerData.job then return "unemployed", 0 end
    if config.framework == "esx" then
        return PlayerData.job.name, tonumber(PlayerData.job.grade)
    else
        return PlayerData.job.name, tonumber(PlayerData.job.grade.level)
    end
end

local zoneEnter = function(index)
    if zoneInterVal then return end

    local store = config.Stores[index]

    if store.jobs then
        local jobName = getPlayerJobNameGrade()
        if not lib.table.contains(store.jobs, jobName) then
            return
        end
    end

    exports["tgiann-core"]:contextOpen("tgiann_clothing_1", "H", store.shopType == "barber" and t("blipBarberShop") or store.shopType == "clothing" and t("blipClothingShop") or t("blipTattooShop"))

    zoneInterVal = SetInterval(function()
        if IsControlJustPressed(0, 74) then
            exports["tgiann-core"]:contextClose("tgiann_clothing_1")
            if store.shopType == "clothing" then
                openMenu({
                    allowedMenus = { [0] = false, [1] = true, [2] = false, [3] = true, [4] = false },
                    adminMode = false,
                    isBerberMenu = false,
                    clotheList = store.clotheList,
                    shopIndex = i,
                })
            elseif store.shopType == "barber" then
                --Para silme fonsk
                openMenu({
                    allowedMenus = { [0] = false, [1] = false, [2] = true, [3] = false, [4] = false },
                    adminMode = false,
                    isBerberMenu = true,
                    shopIndex = i,
                })
            elseif store.shopType == "tattoo" and config.tattoo.active then
                local removeList = {
                    propList = {
                        0, 1, 6, 7, 2
                    },
                    clothe = {
                        { type = "tshirt", id = 8 },
                        { type = "torso",  id = 11 },
                        { type = "arms",   id = 3 },
                        { type = "pants",  id = 4 },
                        { type = "shoes",  id = 6 },
                        { type = "mask",   id = 1,  drawableId = 0 },
                        { type = "bproof", id = 9,  drawableId = 0 },
                        { type = "chain",  id = 7,  drawableId = 0 },
                        { type = "bags",   id = 5,  drawableId = 0 },
                        { type = "decals", id = 10, drawableId = 0 },
                    }
                }
                local playerPed = PlayerPedId()
                openMenu({
                    allowedMenus = { [0] = false, [1] = false, [2] = false, [3] = false, [4] = true },
                    adminMode = false,
                    isTattooMenu = true,
                    disableLoadSkin = true,
                    shopIndex = i,
                })
                for p = 1, #removeList.propList do
                    ClearPedProp(playerPed, removeList.propList[p])
                end
                for c = 1, #removeList.clothe do
                    local element = removeList.clothe[c]
                    local typeName = element.type
                    if element.drawableId then
                        SetPedComponentVariation(playerPed, element.id, element.drawableId, 0, 2)
                    else
                        SetPedComponentVariation(playerPed, element.id, getNakedData(typeName .. "_1"), getNakedData(typeName .. "_2"), 2)
                    end
                end
            end
        end
    end)
end

local zoneExit = function()
    if zoneInterVal then zoneInterVal = ClearInterval(zoneInterVal) end
    exports["tgiann-core"]:contextClose("tgiann_clothing_1")
end

for i = 1, #config.Stores do
    local store = config.Stores[i]

    if (store.shopType == "tatto" and config.tattoo.active) or store.shopType ~= "tatto" then
        zone = store.zone()
        zone.onEnter = function() zoneEnter(i) end
        zone.onExit = function() zoneExit() end
    end
end
