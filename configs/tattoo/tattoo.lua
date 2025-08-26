local file = LoadResourceFile(GetCurrentResourceName(), "tattooList.json")
config.tattoo = {}
config.tattoo.active = true
config.tattoo.list = file and json.decode(file) or nil

-- If you change this setting, delete the tattooList.json file and restart the script! (when you do this the script will recreate the file.)
-- If the price of the tattoo is 0 in gta the following config(config.tattoo.randomPrice) works
config.tattoo.useGtaOnlinePrice = false

-- If you delete the tattooList.json file, when you start the script it will recreate the file and set the prices again (will not work if useGtaOnlinePrice is true)
config.tattoo.randomPrice = {
    ["torso"] = { min = 300, max = 400 },     -- torso
    ["head"] = { min = 300, max = 400 },      -- head
    ["left_arm"] = { min = 300, max = 400 },  -- left_arm
    ["right_arm"] = { min = 300, max = 4000 }, -- right_arm
    ["left_leg"] = { min = 300, max = 400 },  -- left_leg
    ["right_leg"] = { min = 300, max = 400 }, -- right_leg
}

config.tattoo.hashToZone = {
    ["-454273031"] = "torso",
    ["-1055976551"] = "right_arm",
    ["2136911405"] = "right_arm",
    ["633556653"] = "right_arm",
    ["1455567330"] = "right_arm",
    ["796226384"] = "right_arm",
    ["-484264198"] = "head",
    ["867587943"] = "left_arm",
    ["1192230427"] = "torso",
    ["1361645381"] = "right_leg",
    ["-1727932006"] = "left_arm",
    ["-1775023605"] = "left_arm",
    ["1679091791"] = "left_leg",
    ["-544464214"] = "right_arm",
    ["917950949"] = "left_arm",
    ["-1409061796"] = "torso",
    ["1484379715"] = "torso",
    ["-1716562576"] = "right_arm",
    ["1039283199"] = "left_leg",
    ["1725561361"] = "left_leg",
    ["-1560441083"] = "left_leg",
    ["-1670727628"] = "right_leg",
    ["1618133209"] = "torso",
    ["277073536"] = "torso",
    ["1261643197"] = "torso",
    ["2107621060"] = "torso",
    ["1469472731"] = "right_leg",
    ["-1202647020"] = "right_leg",
    ["1548327796"] = "torso",
    ["-382139768"] = "left_leg",
    ["-2119253768"] = "left_arm",
    ["-270504353"] = "left_leg",
    ["123428314"] = "right_arm",
    ["-1917346117"] = "left_leg",
    ["-277214012"] = "head",
    ["2060550302"] = "right_leg",
    ["129912816"] = "torso",
    ["918852313"] = "torso",
    ["1292025685"] = "torso",
    ["521226680"] = "torso",
    ["-1546663824"] = "left_arm",
    ["-1379110068"] = "torso",
    ["1089807219"] = "right_arm",
    ["-1170681301"] = "left_leg",
    ["-1178847967"] = "right_leg",
    ["849089063"] = "torso",
    ["1963750528"] = "right_arm",
    ["-292219126"] = "right_leg",
    ["1639951086"] = "left_arm",
    ["-311742370"] = "left_arm",
    ["2119905678"] = "head",
    ["1012782925"] = "right_arm", --?
    ["-405262373"] = "right_leg",
    ["-1684314297"] = "left_arm",
    ["1372660034"] = "left_arm",
    ["1565386395"] = "torso",
    ["-624267373"] = "left_leg",
    ["711089605"] = "torso",
    ["730193962"] = "right_leg",
    ["-266913369"] = "left_leg",
    ["1753976524"] = "torso",
    ["-737856380"] = "head",
    ["134497037"] = "left_leg",
    ["1034503747"] = "left_leg",
    ["1206993109"] = "right_arm",
    ["-1073830579"] = "right_arm",
    ["-227805513"] = "right_arm",
    ["1928884106"] = "torso",
    ["-2071970448"] = "left_arm",
    ["-1655348266"] = "head",
    ["-1469750959"] = "torso",
    ["1723822798"] = "torso",
    ["1708200656"] = "head",
    ["-80377674"] = "left_arm",
    ["769887067"] = "right_leg",
    ["1944550961"] = "right_arm",
    ["-1399656601"] = "left_leg",
    ["-1538681432"] = "head",
    ["-388268096"] = "torso",
    ["1071134407"] = "left_arm",
    ["-686545645"] = "left_arm",
    ["-1309595991"] = "right_arm",
    ["42711490"] = "right_arm",
    ["-763917073"] = "torso",
    ["436139458"] = "head",
    ["1115682042"] = "left_arm",
    ["32564956"] = "torso",
    ["1176640647"] = "head",
    ["-793495770"] = "torso",
    ["-2066166276"] = "torso"
}
