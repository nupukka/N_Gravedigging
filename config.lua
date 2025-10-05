return {
Core = {
    Framework = "ESX", --  ESX, QB, QBX
    UseNewESX = true, -- If you use old esx set this to false
    Inventory = "ox", --  ox, esx, qb,
    Notification = "ox", --  ox, esx
    Progressbar = "ox_circle", -- ox_circle, ox_square
    InteractType = "target" --  target, textui
},

Options = {
    Distance = 2.5, -- The distance how far you can see the option dig grave
    Diggingitem = 'shovel', -- Item needed to dig the graves
    ProgressDuration = 10000, -- Progressbar duration in milliseconds
    EnableCooldown = true, -- Do you want to use cooldown?
    Cooldown = 1 -- Cooldown in minutes
},

Minigame = {
    Difficulty = {'easy', 'easy', 'easy', 'easy', 'easy'}, -- How many checks and how hard options = easy, medium, hard
    Keys = {'w', 'a', 's', 'd'} -- What keys comes at the checks
},

PriestOptions = {
    Priestchance = 100, -- In %
    Priestspawn = vector3(-1685.1382, -292.1583, 51.8916), -- Where does the priest spawn?
    Priestweapon = "WEAPON_BAT", -- What weapon priest has
    Priestcleaning = 10000, -- How often dead priests will disappear
    PriestModel = "cs_priest"
},

PoliceOptions = {
    Policeneeded = 1,
    EnablePoliceAlert = true, -- Do you want it to alert the polices?
    PoliceAlert = "aty-dispatch", -- Options opto-dispatch, aty-dispatch, cd_dispatch
    PoliceJobs = { -- Your police jobs
        "police"
    }
},

Blip = {
    Position = vector3(-1712.7029, -258.9352, 52.5533), 
    Sprite = 310,
    Display = 4,
    Scale = 0.7,
    Colour = 30,
},

Graveloot = { -- What comes from the graves
    { name = 'garbage', min = 1, max = 3, chance = 100 }, 
    { name = 'radio', min = 1, max = 1, chance = 30 },
},

Graves = { -- You can add more graves if needed
    { coords = vector3(-1746.9925, -298.8715, 46.700), size = vec3(3, 2, 1), rotation = 15 },
    { coords = vector3(-1739.6700, -298.0983, 47.400), size = vec3(3, 2, 1), rotation = 5 },
    { coords = vector3(-1729.9938, -286.7019, 48.700), size = vec3(3, 2, 1), rotation = 15 },
    { coords = vector3(-1748.1823, -277.3698, 47.850), size = vec3(3, 2, 1), rotation = 15 },
    { coords = vector3(-1756.2678, -284.0565, 46.350), size = vec3(3, 2, 1), rotation = 15 },
    { coords = vector3(-1749.0580, -222.3682, 54.000), size = vec3(3, 2, 1), rotation = 70 },
    { coords = vector3(-1767.0088, -220.7798, 52.700), size = vec3(3, 2, 1), rotation = 50 },
    { coords = vector3(-1758.6318, -209.1949, 55.100), size = vec3(3, 2, 1), rotation = 50 },
    { coords = vector3(-1756.2487, -203.3668, 55.700), size = vec3(3, 2, 1), rotation = 50 },
    { coords = vector3(-1769.2462, -240.4719, 50.800), size = vec3(3, 2, 1), rotation = 55 },
    { coords = vector3(-1758.2073, -247.9044, 50.800), size = vec3(3, 2, 1), rotation = 55 },
    { coords = vector3(-1750.3447, -253.3627, 50.400), size = vec3(3, 2, 1), rotation = 55 },
    { coords = vector3(-1765.6440, -259.2705, 48.200), size = vec3(3, 2, 1), rotation = 55 },
    { coords = vector3(-1780.7812, -204.2325, 53.150), size = vec3(3, 2, 1), rotation = 45 },
    { coords = vector3(-1781.5288, -257.9944, 46.400), size = vec3(3, 2, 1), rotation = 55 },
    { coords = vector3(-1797.6538, -251.8842, 43.700), size = vec3(3, 2, 1), rotation = 45 },
    { coords = vector3(-1803.8341, -264.9317, 42.700), size = vec3(3, 2, 1), rotation = 50 },
    { coords = vector3(-1714.7914, -233.3422, 54.200), size = vec3(3, 2, 1), rotation = 1 },
    { coords = vector3(-1731.2772, -224.1729, 55.100), size = vec3(3, 2, 1), rotation = 1 },
    { coords = vector3(-1640.4315, -182.1141, 54.700), size = vec3(3, 2, 1), rotation = 35 },
    { coords = vector3(-1663.0459, -138.3098, 58.200), size = vec3(3, 2, 1), rotation = 25 },
    { coords = vector3(-1685.5643, -137.7877, 58.400), size = vec3(3, 2, 1), rotation = 15 },
    { coords = vector3(-1793.3661, -236.3069, 48.000), size = vec3(3, 2, 1), rotation = 25 },
    { coords = vector3(-1657.5354, -159.4310, 56.400), size = vec3(3, 2, 1), rotation = 35 }
}
}