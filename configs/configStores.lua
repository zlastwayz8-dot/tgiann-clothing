config.Stores = {
    
    {
        blip = true,
        shopType = "clothing",
        clotheList = false,
        blipCoords = vector2(-1200.5401611328, -784.46215820312),
        playerOwnable = {
            active = true,                                    -- if true players can buy the shop
            shopUniqueName = "clotheshop3",                   -- must be unique
            earnPercent = 0.1,                                -- The value is multiplayer (0.1 = 10%) (the money spent by the player * earnPercent)
            coords = vector3(-1194.2552, -766.9985, 17.3159), -- Control menu coords
            price = 10000,                                    -- The rent price of the shop company
            rentMoneyPercent = 0.1,                           -- The value is multip
            rentPeriodDay = 3,                                -- Period in days that the players can rent company
            rentPayBeforeDay = 1,                             -- Period in days that the player can renew his rent before it ends
        },
        zone = function()
            return lib.zones.poly({
                points = {
                    vector3(1702.0, 2607.0, -44.0),
                    vector3(1712.7600097656, 2607.6398925781, -44.0),
                    vector3(1711.1600341797, 2625.5500488281, -44.0),
                    vector3(1702.0, 2625.0, -44.0),
                    vector3(1702.0, 2625.0, -44.0),
                },
                thickness = 5,
                --debug = true
            })
        end
    },
   
    {
        blip = true,
        shopType = "barber",
        blipCoords = vector2(-808.67687988281, -178.70150756836),
        zone = function()
            return lib.zones.poly({
                points = {
                    vector3(-808.67687988281, -178.70150756836, 25),
                    vector3(-807.02545166016, -181.61875915527, 25),
                    vector3(-809.30401611328, -182.96809387207, 25),
                    vector3(-808.05523681641, -185.14138793945, 25),
                    vector3(-819.75915527344, -193.23866271973, 25),
                    vector3(-825.87567138672, -182.23979187012, 25),
                },
                thickness = 4,
            })
        end
    },
   
    -- Tattoo
    {
        blip = true,
        shopType = "tattoo",
        blipCoords = vector2(1323.1323, -1652.5693),
        zone = function()
            return lib.zones.poly({
                points = {
                    vector3(1324.5218505859, -1648.1640625, 52),
                    vector3(1327.8626708984, -1652.2667236328, 52),
                    vector3(1321.3908691406, -1657.6013183594, 52),
                    vector3(1317.8269042969, -1653.3630371094, 52),
                },
                thickness = 3,
            })
        end
    },
}
