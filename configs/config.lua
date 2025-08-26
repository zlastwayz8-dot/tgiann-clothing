--[[
    - this script needs tgiann-core script to work, you can download the script from your keymaster account
      Start tgiann-core script after es_extented/qb-core script and before tgiann-* scripts
      Adjust the tgiann-core config file according to the framework you are using

    Docs: https://tgiann.gitbook.io/tgiann/scripts/tgiann-clothing
]]

tgiCoreExports = exports["tgiann-core"]
config = tgiCoreExports:getConfig()
config.langs = {}

-- When set to false, players can save their outfits
-- Set this setting to false if you are not using tgiann-inventory or do not want clothes to be items
-- if you are using tgiann-inventory, make this and the Config.clothingAsItem setting in inventory the same
-- false version; https://youtu.be/IflmFDyMCnE?t=80
config.clothingAsItem = true

config.pedListEnable = false                     -- if true, the player can change the ped, change the ped list from "pedList.lua"
config.showClotheImg = true                      -- shows a picture of clothes in ui (https://docs.tgiann.com/scripts/tgiann-clothing/how-to-take-clothes-images)
config.fadeOutScreenWhenCreatingCharacter = true -- If true, the screen will fade out when the character creation menu is opened
config.fadeOutScreenWhenLoadingCharacter = true  -- If true, the screen will fade out when the character is loading

config.moneyType = "cash"

config.refreshSkin = {                  -- Command to refresh the character
    active = true,
    command = "fixpj",            -- command name
    eventName = "tgiann-clothing:refreshSkin",
    rate = 2000,                        -- how many miliseconds after the player uses the command can he use it again
    deleteAttachedObjectWhenUsed = true -- when the player uses the refreshskin command, if there is an object attached to the character, it deletes it (prevents the probe in the hand from falling to the ground in some animations)
}

-- If one of the following masks is worn by the character, it will change the face type and prevent it from protruding beyond the mask.
-- If you have a mask removal command, add this export at the end of the command. https://docs.tgiann.com/scripts/tgiann-clothing/events-exports#checkmask
config.maskNumber = {
    man = { 266, 265, 263, 255, 254, 253, 252, 251, 250, 249, 248, 247, 246, 245, 244, 243, 242, 241, 240, 237, 236, 234, 233, 232, 231, 230, 228, 227, 225, 224, 223, 222, 221, 220, 219, 214, 213, 212, 211, 205, 203, 200, 194, 193, 192, 191, 190, 189, 188, 185, 184, 183, 182, 181, 180, 179, 178, 177, 176, 174, 173, 172, 171, 170, 168, 167, 165, 164, 163, 162, 161, 160, 159, 158, 157, 156, 155, 154, 153, 152, 151, 150, 149, 147, 146, 144, 143, 142, 141, 140, 139, 138, 137, 136, 135, 134, 133, 132, 131, 130, 129, 128, 127, 126, 125, 124, 123, 119, 118, 117, 115, 113, 112, 110, 108, 106, 105, 104, 103, 102, 100, 99, 98, 97, 96, 95, 94, 93, 92, 91, 89, 88, 87, 86, 85, 84, 83, 82, 81, 80, 79, 78, 77, 76, 75, 74, 72, 71, 70, 69, 68, 67, 66, 65, 64, 63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 35, 34, 33, 32, 31, 30, 29, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 10, 9, 8, 7, 6, 5, 4, 3, 2 },
    woman = { 248, 244, 243, 242, 241, 240, 239, 238, 237, 236, 235, 234, 233, 232, 231, 230, 229, 228, 227, 226, 225, 223, 222, 221, 220, 219, 217, 216, 214, 213, 212, 211, 210, 209, 202, 198, 196, 195, 194, 193, 192, 191, 189, 188, 185, 184, 183, 182, 181, 180, 179, 178, 177, 176, 174, 173, 172, 171, 170, 168, 167, 165, 164, 163, 162, 161, 160, 159, 158, 157, 156, 155, 154, 153, 152, 151, 150, 149, 147, 146, 144, 143, 142, 141, 140, 139, 138, 137, 136, 135, 134, 133, 132, 131, 130, 129, 128, 127, 126, 125, 124, 123, 119, 118, 117, 115, 113, 112, 110, 108, 106, 105, 104, 103, 102, 100, 99, 98, 97, 96, 95, 94, 93, 92, 91, 89, 88, 87, 86, 85, 84, 83, 82, 81, 80, 79, 78, 77, 76, 75, 74, 72, 71, 70, 69, 68, 67, 66, 65, 64, 63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 35, 34, 33, 32, 31, 30, 29, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 }
}

config.creatingChar = {
    -- If you enter a value here, the clothes you set in the config/clotheList/'your cujstom shop name' folder will appear.
    -- By default, there is only a definition called 'global'.
    -- If you want to activate global, you should change this setting to clotheList = "global".
    clotheList = false,
    showClotheOptions = false,                          -- Allow the player to choose clothes when creating a character
    wait = 4000,                                        -- The time the menu opens after x milliseconds when the createFirstCharacter event is triggered
    coords =  vector4(1744.42, 2506.50, 45.58, 58.49),   -- Character creation location
    spawn = {
        spawnBack = false,                              -- If true then player will spawn back to last location after creating character (if u are using qb-apartment set this to true)
        coords = vector4(1639.78, 2502.61, 46.59, 323.41) -- Cord to spawn Player after character creation
    }
}

-- only works on clothing shops
config.clothingPrice = {
    enable = true, --if this is true, the clothing prices are set according to the ‘configs/clohingPrice’ file. if false, the default price is the one below (If clotheList is set for config.Stores, this setting is ignored.)
    defaultPrice = 10,
}

config.disableIdleCam = true -- If true it disables the Idle Cam
config.displayRadar = false  -- If true it closes the minimap when the clothing menu is opened and opens it again when the clothing menu is closed, if false the minimap is never touched

-- if you are using esx you may need to set this to true or trigger the createFirstCharacter event
-- if you used to use a different clothe script on your server and have an active(If you have old script skin data of old players) server, set this setting to true
-- config.autoOpenCreateMenu = false
-- config.autoOpenCreateMenu = true
config.autoOpenCreateMenu = true -- true | false > When this is true, the creation menu opens when the character load event is triggered and you have no skin data. false when the “createFirstCharacter” event is triggered

config.events = {
    qb = {
        onPlayerLoaded = "QBCore:Client:OnPlayerLoaded",
        createFirstCharacter = "qb-clothes:client:CreateFirstCharacter"
    },
    esx = {
        onPlayerLoaded = "esx:playerLoaded",
        createFirstCharacter = "tgiann-clothing:esx:createNew"
    }
}

-- You can adit clothing list from configs/clothingRoomsOutfits.lua
config.clothingRooms = {
    { outfitName = "police1", job = 'police',    maxDistance = 3, pressDistance = 3, coords = vector3(454.68, -990.89, 29.69), },
    { outfitName = "police1", job = 'ambulance', maxDistance = 3, pressDistance = 3, coords = vector4(342.47, -586.15, 43.32, 342.56), },
    { outfitName = "police1", job = 'police',    maxDistance = 3, pressDistance = 3, coords = vector3(314.76, 671.78, 14.73), },
    { outfitName = "police1", job = 'ambulance', maxDistance = 3, pressDistance = 3, coords = vector3(338.70, 659.61, 14.71), },
    { outfitName = "police1", job = 'ambulance', maxDistance = 3, pressDistance = 3, coords = vector3(-1098.45, 1751.71, 23.35), },
    { outfitName = "police1", job = 'police',    maxDistance = 3, pressDistance = 3, coords = vector3(-77.59, -129.17, 5.03), },
}

-- if clothingAsItem is true it opens an inventory for clothes, if false it opens a menu where you can change your registered clothes
-- Also u can edit openOutfitMenu function from client/editable.lua
config.outfitChangers = {
    { coords = vector3(-32.6164, -1112.1201, 26.4224), maxDistance = 3, pressDistance = 3 },
}

config.showArmor = {
    active = false,      -- If true Players will be able to wear an Armour if the Armour has a value
    defaultMan = {       -- If player has no specific armour on this will be shown as armour(Male)
        drawableId = 10, -- Vest/Armour/Bulletproof number on your clothings
        textureId = 0,
    },
    defaultFemale = {    -- If player has no specific armour on this will be shown as armour(Female)
        drawableId = 10, -- Vest/Armour/Bulletproof number on your clothings
        textureId = 1,
    }
}

config.blips = {
    clothing = {
        activeAfterLogin = true,                       -- If true, clothingshop blips will automatically turn on when player joins game
        event = "tgiann-clothing:clothing:blip:onOff", -- You can use this event to toggle the blips
        sprite = 73,
        color = 46,
        scale = 0.5
    },
    barber = {
        activeAfterLogin = true,                     -- If true, Barber blips will automatically turn on when player joins game
        event = "tgiann-clothing:barber:blip:onOff", -- You can use this event to toggle the blips
        sprite = 71,
        color = 51,
        scale = 0.5
    },
    tattoo = {
        activeAfterLogin = true,                     -- If true, Tattoo blips will automatically turn on when player joins game
        event = "tgiann-clothing:tattoo:blip:onOff", -- You can use this event to toggle the blips
        sprite = 75,
        color = 1,
        scale = 0.5
    },
}

config.maxValues = {
    mom = 45, -- if your are using this script(https://community-store.onx.gg/package/6187602) set to 91 (Default 45)
    dad = 45, -- if your are using this script(https://community-store.onx.gg/package/6187602) set to 91 (Default 45)
}

-- Command for players to tie up hair
config.hairClips = {
    command = "hair", -- Command name
    male = 12,        -- Default hair number
    female = 11,      -- Default hair number
}

-- default clothes that the character will be wearing when the character creation menu opens
config.creatingMenuClothe = {
    male = {
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 15,
        torso_2 = 0,
        arms = 15,
        arms_2 = 0,
        pants_1 = 21,
        pants_2 = 0,
        shoes_1 = 34,
        shoes_2 = 0,
    },
    female = {
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 15,
        torso_2 = 0,
        arms = 15,
        arms_2 = 0,
        pants_1 = 21,
        pants_2 = 0,
        shoes_1 = 35,
        shoes_2 = 0,
    }
}

-- the new clothe number to be changed when the character takes off clothes
config.naked = {
    male = {
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 15,
        torso_2 = 0,
        arms_1 = 15,
        arms_2 = 0,
        pants_1 = 61,
        pants_2 = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }, -- random for color
        shoes_1 = 34,
        shoes_2 = 0
    },
    female = {
        tshirt_1 = 0,
        tshirt_2 = 0,
        torso_1 = 1420,
        torso_2 = 0,
        arms_1 = 4,
        arms_2 = 0,
        pants_1 = 37,
        pants_2 = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }, -- random for color
        shoes_1 = 198,
        shoes_2 = 0,
    }
}

-- bottom left animations in the menu
config.defaultAnimation = { dict = 'anim@amb@clubhouse@mini@darts@', name = 'wait_idle' }
config.animations = {
    {
        img = "anim_2",
        anim = {
            dict = "airforce@attention",
            name = "base"
        }
    },
    {
        img = "anim_4",
        anim = {
            dict = "anim@mp_corona_idles@female_b@idle_a",
            name = "idle_a"
        }
    },
    {
        img = "anim_1",
        anim = {
            dict = "rcmnigel1a",
            name = "base"
        }
    },
    {
        img = "anim_3",
        anim = {
            dict = "random@shop_tattoo",
            name = "_idle_a"
        }
    },
}

-- After Player created Character, these clothes will be worn by default (If config.creatingChar.showClotheOptions is true, this config will not work)
config.defaultClothe = {
    male = {
        ['tshirt_1'] = 15,
        ['tshirt_2'] = 0,
        ['torso_1'] = 22,
        ['torso_2'] = 1,
        ['arms'] = 0,
        ['arms_2'] = 0,
        ['pants_1'] = 37,
        ['pants_2'] = 2,
        ['shoes_1'] = 42,
        ['shoes_2'] = 1,
    },
    female = {
        ['tshirt_1'] = 0,
        ['tshirt_2'] = 0,
        ['torso_1'] = 1593,
        ['torso_2'] = 4,
        ['arms'] = 4,
        ['arms_2'] = 0,
        ['pants_1'] = 22,
        ['pants_2'] = 0,
        ['shoes_1'] = 72,
        ['shoes_2'] = 1,
    }
}

config.clothelist = {}         -- Don't Edit
config.blacklist = {}          -- Don't edit
config.defaultClothePrice = {} -- Don't edit

config.warDropSaveData = {     -- Don't Edit
    "tshirt_1", "tshirt_2", "torso_1", "torso_2", "decals_1", "decals_2", "arms", "arms_2", "pants_1", "pants_2", "shoes_1", "shoes_2", "mask_1", "mask_2", "bproof_1", "bproof_2", "chain_1", "chain_2", "helmet_1", "helmet_2", "glasses_1", "glasses_2", "watches_1", "watches_2", "bracelets_1", "bracelets_2", "ears_1", "ears_2", "bags_1", "bags_2", "hairOverlay"
}
