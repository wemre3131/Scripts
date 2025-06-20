-- Load Informant.wtf UI Library
local Informant = loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/main/2%20Informant.wtf%20Lib%20(FIXED)/informant.wtf%20Lib%20Source.lua"))()

-- Create Window
local Window = Informant:CreateWindow("bizim scriptler")

-- Main Tab
local MainTab = Window:AddTab("Main")
local MainSection = MainTab:AddSection("Scripts")

MainSection:AddButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainSection:AddButton("MM2 Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainSection:AddButton("Arsenal Script", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)

MainSection:AddButton("Fling ALL Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

MainSection:AddButton("Air Hub Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

MainSection:AddButton("Jerk off R6 Script", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

MainSection:AddButton("Jerk off R15 Script", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

MainSection:AddButton("Azure Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:AddButton("Blox Fruit Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:AddButton("Grow a Garden Script", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)

MainSection:AddButton("Forsaken Script", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainSection:AddButton("Bedwars Script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua"))()
end)

MainSection:AddButton("Bee Swarm Simulator", function()
    loadstring(game:GetObjects("rbxassetid://4384103988")[1].Source)("Pepsi Swarm")
end)

-- Player Tab
local PlayerTab = Window:AddTab("Player")
local PlayerSection = PlayerTab:AddSection("Player")

PlayerSection:AddSlider("Walkspeed", 16, 500, 16, function(val)
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = val
    end
end)

PlayerSection:AddSlider("Jumppower", 50, 500, 50, function(val)
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.JumpPower = val
    end
end)

PlayerSection:AddButton("TP Tool", function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Tp tool(Equip to Click TP)"
    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

PlayerSection:AddButton("Noclip", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:AddButton("R15 To R6 (FE)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"))()
end)

MainSection:AddButton("FE Emote", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)

-- Fly + Camera Lock Variables
local flySpeed = 50
local flying = false
local bv, bg, conn
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local camLocked = false
local flyingDir = { w = false, a = false, s = false, d = false }

PlayerSection:AddSlider("Fly Speed", 50, 300, 50, function(val)
    flySpeed = val
end)

local function startFlying()
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.CFrame = workspace.CurrentCamera.CFrame
    bg.Parent = hrp

    conn = RS.Heartbeat:Connect(function()
        local camCF = workspace.CurrentCamera.CFrame
        local moveVec = Vector3.new(0, 0, 0)
        if flyingDir.w then moveVec += camCF.LookVector end
        if flyingDir.s then moveVec -= camCF.LookVector end
        if flyingDir.a then moveVec -= camCF.RightVector end
        if flyingDir.d then moveVec += camCF.RightVector end
        bv.Velocity = (moveVec.Magnitude > 0) and moveVec.Unit * flySpeed or Vector3.new(0, 0, 0)
        bg.CFrame = camCF
    end)
end

local function stopFlying()
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if conn then conn:Disconnect() end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        flying = not flying
        if flying then startFlying() else stopFlying() end
    elseif input.KeyCode == Enum.KeyCode.E then
        camLocked = not camLocked
        game:GetService("UserSettings").GameSettings.CameraMode = camLocked and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
    end

    if input.KeyCode == Enum.KeyCode.W then flyingDir.w = true end
    if input.KeyCode == Enum.KeyCode.S then flyingDir.s = true end
    if input.KeyCode == Enum.KeyCode.A then flyingDir.a = true end
    if input.KeyCode == Enum.KeyCode.D then flyingDir.d = true end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then flyingDir.w = false end
    if input.KeyCode == Enum.KeyCode.S then flyingDir.s = false end
    if input.KeyCode == Enum.KeyCode.A then flyingDir.a = false end
    if input.KeyCode == Enum.KeyCode.D then flyingDir.d = false end
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hrp = char:WaitForChild("HumanoidRootPart")
end)

-- Infectious Smile Tab
local InfectiousTab = Window:AddTab("Infectious Smile")
local InfectiousSection = InfectiousTab:AddSection("Infectious Smile")

local function cooldownZero(toolName)
    pcall(function()
        local tool = game.Players.LocalPlayer.Character:FindFirstChild(toolName)
        if tool and tool:FindFirstChild("Cooldown") then
            tool.Cooldown.Value = 0
        end
    end)
end

local tools = {"Bat", "Bottle", "Branch", "Katana", "Spear", "Chain", "Hatchet", "Knife"}

for _, tool in ipairs(tools) do
    InfectiousSection:AddButton("No " .. tool .. " Cooldown", function()
        cooldownZero(tool)
    end)
end
