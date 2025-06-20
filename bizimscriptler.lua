local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("bizim scriptler", "Sentinel")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Scripts")

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

MainSection:NewButton("Jerk off R6 Script", "Jerk Off", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

MainSection:NewButton("Jerk off R15 Script", "Jerk Off", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

MainSection:NewButton("Azure Script", "Azure", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:NewButton("Blox Fruit Script", "Azure", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
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

MainSection:NewButton("Bedwars Script", "Kill Aura and More" , function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainSection:NewButton("Bee Swarm Simulator", "Auto Farm and Auto Find!" , function()
    loadstring(game:GetObjects("rbxassetid://4384103988")[0X1].Source)("Pepsi Swarm")
end)

local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Player")
 
PlayerSection:NewSlider("Walkspeed", "Change's your speed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
 
PlayerSection:NewSlider("Jumppower", "Make's you jump High", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
 
PlayerSection:NewButton("TP Tool", "Click to Teleport" , function()
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
 
PlayerSection:NewButton("Noclip", "Walk threw Walls" , function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:NewButton("R15 To R6 (FE)", "Change's animation" , function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua'), true))()
end)

MainSection:NewButton("FE Emote", "All Emotes Keybind Open Is Comma" , function()
    --keybind to open is comma
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)

-- === Fly Script ===

local flySpeed = 50
local flying = false
local bv, bg, conn

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local flyingDir = {
    w = false,
    a = false,
    s = false,
    d = false
}

PlayerSection:NewSlider("Fly Speed", "Adjust fly speed (F to toggle)", 300, 50, function(val)
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

        if moveVec.Magnitude > 0 then
            bv.Velocity = moveVec.Unit * flySpeed
        else
            bv.Velocity = Vector3.new(0, 0, 0)
        end

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
        if flying then
            startFlying()
        else
            stopFlying()
        end
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
    if flying then
        stopFlying()
        startFlying()
    end
end)
