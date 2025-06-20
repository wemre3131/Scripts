-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create the window
local Window = Library.CreateLib("bizim scriptler", "Sentinel")

-- Main Scripts Tab
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Scripts")

MainSection:NewButton("Infinite Yield", "Admin commands GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainSection:NewButton("MM2 Script", "Murder Mystery 2 script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainSection:NewButton("Azure Script", "Azure GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:NewButton("Blox Fruit Script", "Blox Fruits GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:NewButton("Grow a Garden Script", "Grow A Garden GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"))()
end)

MainSection:NewButton("Forsaken Script", "Forsaken GUI", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainSection:NewButton("Bedwars Script", "Kill Aura and More", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainSection:NewButton("Bee Swarm Simulator", "Auto Farm and More", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/PepsiSwarm/BeeSwarmSimulator/main/AutoFarm.lua"))()
end)

MainSection:NewButton("FE Emote", "Keybind to open is comma (,)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)

-- Player Tab
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")

PlayerSection:NewSlider("Walkspeed", "Change your speed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("JumpPower", "Make you jump higher", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("TP Tool", "Click to teleport", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GuBiX19e"))()
end)

PlayerSection:NewButton("Noclip", "Walk through walls", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:NewButton("R15 to R6 (FE)", "Change animations", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", true))()
end)
