-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create main window
local Window = Library.CreateLib("bizim scriptler", "Sentinel")

-- MAIN TAB
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Scripts")

MainSection:NewButton("Infinite Yield", "Admin commands GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainSection:NewButton("MM2 Script", "Murder Mystery 2", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainSection:NewButton("Arsenal Script", "Arsenal hacks", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)

MainSection:NewButton("Fling ALL Script", "Fling everyone", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

MainSection:NewButton("Air Hub Script", "AirHub universal GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

MainSection:NewButton("Jerk off R6 Script", "NSFW R6 animation", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

MainSection:NewButton("Jerk off R15 Script", "NSFW R15 animation", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

MainSection:NewButton("Azure Script", "Azure GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:NewButton("Blox Fruit Script", "Blox Fruits GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:NewButton("Grow a Garden Script", "Grow a Garden (GAG)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"))()
end)

MainSection:NewButton("Forsaken Script", "Forsaken GUI", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainSection:NewButton("Bedwars Script", "Kill Aura, fly, etc.", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainSection:NewButton("Bee Swarm Simulator", "Auto Farm, auto find", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/PepsiSwarm/BeeSwarmSimulator/main/AutoFarm.lua"))()
end)

MainSection:NewButton("FE Emote", "Press comma (,) to open menu", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)

-- PLAYER TAB
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player Controls")

PlayerSection:NewSlider("Walkspeed", "Changes your walk speed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("Jump Power", "Changes your jump power", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("TP Tool", "Click to teleport", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GuBiX19e"))()
end)

PlayerSection:NewButton("Noclip", "Walk through walls", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:NewButton("R15 to R6 (FE)", "Switch animations to R6 style", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", true))()
end)
