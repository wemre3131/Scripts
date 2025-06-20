-- Load Discord UI Library
local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/main/Discord%20UI%20Lib/Discord%20Lib%20Source.lua"))()
local Window = DiscordLib:Window("bizim scriptler")

-- Main Tab
local MainTab = Window:Tab("Main")

-- We can add a label or section title since DiscordLib doesn't have explicit sections
MainTab:Label("Scripts")

MainTab:Button("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainTab:Button("MM2 Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainTab:Button("Arsenal Script", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)

MainTab:Button("Fling ALL Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

MainTab:Button("Air Hub Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

MainTab:Button("Jerk off R6 Script", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

MainTab:Button("Jerk off R15 Script", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

MainTab:Button("Azure Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainTab:Button("Blox Fruit Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainTab:Button("Grow a Garden Script", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)

MainTab:Button("Forsaken Script", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainTab:Button("Bedwars Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainTab:Button("Bee Swarm Simulator", function()
    loadstring(game:GetObjects("rbxassetid://4384103988")[1].Source)("Pepsi Swarm")
end)

-- Player Tab
local PlayerTab = Window:Tab("Player")

PlayerTab:Label("Player")

PlayerTab:Slider("Walkspeed", 16, 500, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

PlayerTab:Slider("Jumppower", 50, 500, 50, function(value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

PlayerTab:Button("TP Tool", function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Tp tool(Equip to Click TP)"
    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
        pos = CFrame.new(pos.X, pos.Y, pos.Z)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

PlayerTab:Button("Noclip", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerTab:Button("R15 To R6 (FE)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"))()
end)

MainTab:Button("FE Emote", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)

-- Fly + Camera Lock (logic stays the same, not part of UI)
-- [Keep your flying code as is]

-- Infectious Smile Tab
local InfectiousTab = Window:Tab("Infectious Smile")
InfectiousTab:Label("Infectious Smile")

local function cooldownZero(toolName)
    pcall(function()
        game.Players.LocalPlayer.Character[toolName].Cooldown.Value = 0
    end)
end

local tools = {"Bat", "Bottle", "Branch", "Katana", "Spear", "Chain", "Hatchet", "Knife"}

for _, tool in ipairs(tools) do
    InfectiousTab:Button("No " .. tool .. " Cooldown", function()
        cooldownZero(tool)
    end)
end
