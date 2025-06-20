-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("bizim scriptler", "Sentinel")

-- Tabs
local MainTab = Window:NewTab("Main")
local PlayerTab = Window:NewTab("Player")
local SmileTab = Window:NewTab("Infectious Smile")

-- Sections
local MainSection = MainTab:NewSection("Scripts")
local PlayerSection = PlayerTab:NewSection("Player")
local InfectiousSmileSection = SmileTab:NewSection("Cooldown Removers")

-- Main Buttons
MainSection:NewButton("Infinite Yield", "Admin commands GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainSection:NewButton("MM2 Script", "Murder Mystery 2 script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainSection:NewButton("Arsenal Script", "Arsenal", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)

MainSection:NewButton("Fling ALL Script", "Fling all", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

MainSection:NewButton("Air Hub Script", "Air Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

MainSection:NewButton("Azure Script", "Azure", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:NewButton("Blox Fruit Script", "Blox Fruits", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:NewButton("Grow a Garden Script", "GAG", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)

MainSection:NewButton("Forsaken Script", "Forsaken", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainSection:NewButton("Bedwars Script", "Kill Aura and More", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainSection:NewButton("Bee Swarm Simulator", "Auto Farm and Auto Find!", function()
    loadstring(game:GetObjects("rbxassetid://4384103988")[1].Source)("Pepsi Swarm")
end)

MainSection:NewButton("FE Emote", "All Emotes Keybind Open Is Comma", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)

-- Player Controls
PlayerSection:NewSlider("Walkspeed", "Change's your speed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("Jumppower", "Make's you jump High", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("TP Tool", "Click to Teleport", function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Tp tool (Equip to Click TP)"
    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

PlayerSection:NewButton("Noclip", "Walk through Walls", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:NewButton("R15 To R6 (FE)", "Change's animation", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"))()
end)

-- Infectious Smile Cooldown Removers
local weapons = {"Bat", "Bottle", "Branch", "Katana", "Spear", "Chain", "Hatchet", "Knife"}
for _, weapon in pairs(weapons) do
    InfectiousSmileSection:NewButton("No " .. weapon .. " Cooldown (Hold " .. weapon .. ")", function()
        local char = game.Players.LocalPlayer.Character
        local tool = char and char:FindFirstChild(weapon)
        if tool and tool:FindFirstChild("Cooldown") then
            tool.Cooldown.Value = 0
        end
    end)
end

-- Fly and Camera Lock
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local flySpeed = 50
local flying = false
local camLocked = false
local bv, bg, flyConn
local flyDir = {w = false, a = false, s = false, d = false}

PlayerSection:NewSlider("Fly Speed", "Adjust fly speed (F to toggle)", 300, 50, function(val)
    flySpeed = val
end)

local function startFlying()
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.new()
    bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.CFrame = workspace.CurrentCamera.CFrame
    bg.Parent = hrp

    flyConn = RS.Heartbeat:Connect(function()
        local camCF = workspace.CurrentCamera.CFrame
        local moveVec = Vector3.new()
        if flyDir.w then moveVec += camCF.LookVector end
        if flyDir.s then moveVec -= camCF.LookVector end
        if flyDir.a then moveVec -= camCF.RightVector end
        if flyDir.d then moveVec += camCF.RightVector end
        bv.Velocity = moveVec.Magnitude > 0 and moveVec.Unit * flySpeed or Vector3.new()
        bg.CFrame = camCF
    end)
end

local function stopFlying()
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if flyConn then flyConn:Disconnect() end
end

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying then startFlying() else stopFlying() end
    elseif input.KeyCode == Enum.KeyCode.E then
        camLocked = not camLocked
        workspace.CurrentCamera.CameraType = camLocked and Enum.CameraType.Scriptable or Enum.CameraType.Custom
        if camLocked then
            workspace.CurrentCamera.CFrame = hrp.CFrame
        end
    elseif input.KeyCode == Enum.KeyCode.W then flyDir.w = true
    elseif input.KeyCode == Enum.KeyCode.A then flyDir.a = true
    elseif input.KeyCode == Enum.KeyCode.S then flyDir.s = true
    elseif input.KeyCode == Enum.KeyCode.D then flyDir.d = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then flyDir.w = false end
    if input.KeyCode == Enum.KeyCode.A then flyDir.a = false end
    if input.KeyCode == Enum.KeyCode.S then flyDir.s = false end
    if input.KeyCode == Enum.KeyCode.D then flyDir.d = false end
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hrp = char:WaitForChild("HumanoidRootPart")
    if flying then stopFlying(); startFlying() end
end)
