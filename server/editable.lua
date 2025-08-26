local adminPerm = config.tgiannServer and { "tgi" } or config.framework == "qb" and "god" or "admin"

tgiCore.CommandsAdd("skin", "Admin Skin Menu", { { name = "id", help = "Player Server Id" } }, false, function(source, args)
    local src = args[1] and tonumber(args[1]) or source
    local xPlayer = tgiCore.getPlayer(src)
    if not xPlayer then return end
    TriggerClientEvent("tgiann-clothing:client:openMenu", src)
end, adminPerm)

tgiCore.CommandsAdd("ped", "Change Player Ped", { { name = "id", help = "Player Server Id" }, { name = "hash", help = "Pad Name or Hash" } }, false, function(_, args)
    local xPlayer = tgiCore.getPlayer(tonumber(args[1]))
    if not xPlayer then return end
    TriggerClientEvent("tgiann-clothing:client:changePed", tgiCore.getSource(xPlayer), args[2])
end, adminPerm)

tgiCore.CommandsAdd("pskin", "Take Yourself the Skin Data of a Different Player", { { name = "citizenid/licanceId", help = "QB: Citizenid | ESX: licance Id" } }, false, function(source, args)
    if not args[1] then return end
    TriggerClientEvent("tgiann-clothing:loadOtherPlayerSkin", source, args[1])
end, adminPerm)

tgiCore.CommandsAdd("pcopy", "Creates a copy of you that only appears in your client", {}, false, function(source)
    TriggerClientEvent("tgiann-clothing:copyped", source)
end, adminPerm)

local propItems = {
    c_helmet = true,
    c_glasses = true,
    c_watch = true,
    c_bracelet = true,
    c_ear = true,
}

local clotheItems = {
    c_necklace = true, c_bproof = true, c_decal = true, c_torso = true, c_mask = true, c_helmet = true, c_glasses = true, c_bag = true, c_pants = true, c_shoes = true, c_bracelet = true, c_watch = true, c_ear = true
}

local function createClothe(src, model, data, item, isClotheSlot)
    if not clotheItems[item] then return false end

    local info = {
        type = "clothe",
        data = data,
        clotheType = item,
        model = model,
        prop = propItems[item]
    }
    return exports["tgiann-inventory"]:AddItem(src, item, 1, nil, info, isClotheSlot)
end

exports("createClothe", createClothe)
exports("CreateClothe", createClothe)

RegisterNetEvent('tgiann-clothing:giveClothe')
AddEventHandler('tgiann-clothing:giveClothe', function(model, data, item, isClotheSlot)
    createClothe(source, model, data, item, isClotheSlot)
end)

---@param src number
---@param webhook "changePlayerModel" | "logBoughtClothe" | "boughtClothe"
---@param msg string
function log(src, webhook, msg)
    TriggerEvent("tgiann-core:discordLog", config.webhooks[webhook], msg, src)
end

RegisterNetEvent('tgiann-clothing:server:openOutfitMenu')
AddEventHandler('tgiann-clothing:server:openOutfitMenu', function(name)
    local src = source

    tgiCore.OpenStash(src, {
        stashName = name,
        isPlayer = true,
        maxWeight = 100,
        slots = 500,
        label = "Wardrobe",
        whitelist = {
            "c_necklace", "c_bproof", "c_decal", "c_torso", "c_mask", "c_helmet", "c_glasses", "c_bag", "c_pants", "c_shoes", "c_bracelet", "c_watch", "c_ear", "kposet", "bkposet", "clothe_set"
        }
    })
end)
