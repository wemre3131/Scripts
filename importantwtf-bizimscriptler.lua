-- Load Informant.wtf UI Library
local Informant = loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/main/2%20Informant.wtf%20Lib%20(FIXED)/informant.wtf%20Lib%20Example.lua"))()

local Window = Informant.Window("bizim scriptler")

-- Main Tab
local MainTab = Window:Tab("Main")
local MainSection = MainTab:Section("Scripts")

MainSection:Button("Infinite Yield", "Admin commands GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainSection:Button("MM2 Script", "Murder Mystery 2 script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainSection:Button("Arsenal Script", "Arsenal", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)

MainSection:Button("Fling ALL Script", "Fling all", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

MainSection:Button("Air Hub Script", "Air Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

MainSection:Button("Jerk off R6 Script", "Jerk Off", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

MainSection:Button("Jerk off R15 Script", "Jerk Off", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

MainSection:Button("Azure Script", "Azure", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:Button("Blox Fruit Script", "Blox Fruits", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:Button("Grow a Garden Script", "GAG", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)

MainSection:Button("Forsaken Script", "Forsaken", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainSection:Button("Bedwars Script", "Kill Aura and More", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainSection:Button("Bee Swarm Simulator", "Auto Farm and Auto Find!", function()
    loadstring(game:GetObjects("rbxassetid://4384103988")[1].Source)("Pepsi Swarm")
end)

-- Player Tab
local PlayerTab = Window:Tab("Player")
local PlayerSection = PlayerTab:Section("Player")

PlayerSection:Slider("Walkspeed", 16, 500, 16, function(s)
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = s
    end
end)

PlayerSection:Slider("Jumppower", 50, 500, 50, function(s)
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.JumpPower = s
    end
end)

PlayerSection:Button("TP Tool", "Click to teleport", function()
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

PlayerSection:Button("Noclip", "Walk through walls", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:Button("R15 To R6 (FE)", "Change animation", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"))()
end)

MainSection:Button("FE Emote", "All Emotes Keybind Open is Comma", function()
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

PlayerSection:Slider("Fly Speed", 50, 300, 50, function(val)
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
local InfectiousTab = Window:Tab("Infectious Smile")
local InfectiousSection = InfectiousTab:Section("Infectious Smile")

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
    InfectiousSection:Button("No " .. tool .. " Cooldown", "Removes cooldown when holding " .. tool, function()
        cooldownZero(tool)
    end)
end
