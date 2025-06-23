-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rayfield Example Window",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "bizimscriptler",
   LoadingSubtitle = "by Ekrem",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Bizimscriptler"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "Ekrem abiye sor", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"simpleCS2"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

-- ==== MAIN TAB ====
local MainTab = Window:CreateTab("Main")

local function createMainButton(name, url)
    MainTab:CreateButton({
        Name = name,
        Callback = function()
            loadstring(game:HttpGet(url))()
        end
    })
end

  MainTab:CreateButton({Name = "Infinite Yield", 
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end})

  MainTab:CreateButton({Name = "MM2 Script", 
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end})

  MainTab:CreateButton({Name = "Arsenal Script", 
  Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end})

  
MainTab:CreateButton({Name = "Fling ALL Script", 
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end})

  MainTab:CreateButton({Name = "Air Hub Script", 
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end})

  MainTab:CreateButton({Name = "Jerk off R6 Script", 
  Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end})

  MainTab:CreateButton({Name = "Jerk off R15 Script", 
  Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end})

  
MainTab:CreateButton({Name = "Azure Script", 
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end})

  MainTab:CreateButton({Name = "Blox Fruit Script", 
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end})

  
MainTab:CreateButton({Name = "Grow a Garden Script", 
Callback = function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end})

  MainTab:CreateButton({Name = "Forsaken Script", 
  Callback = function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end})

  MainTab:CreateButton({Name = "Bedwars Script", 
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end})

MainTab:CreateButton({
    Name = "Bee Swarm Simulator",
    Callback = function()
        local obj = game:GetObjects("rbxassetid://4384103988")[1]
        if obj then obj.Parent = game.Players.LocalPlayer.PlayerGui end
    end
})

MainTab:CreateButton({
    Name = "FE Emote",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
    end
})

-- ==== PLAYER TAB ====
local PlayerTab = Window:CreateTab("Player")

-- Walkspeed & Jumppower
PlayerTab:CreateSlider({ Name = "Walkspeed", Range = {16,500}, Increment=1, CurrentValue=16, 
Callback = function(s)
    local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = s end
end})
PlayerTab:CreateSlider({ Name = "Jumppower", Range = {50,500}, Increment=1, CurrentValue=50, 
Callback = function(s)
    local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then h.JumpPower = s end
end})

-- TP Tool
PlayerTab:CreateButton({ Name = "TP Tool", 
Callback = function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool",{RequiresHandle=false,Name="Tp tool"})
    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0,2.5,0)
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(pos.X,pos.Y,pos.Z) end
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end})

PlayerTab:CreateButton({ Name = "Instant React", 
Callback = function()
local ProximityPromptService = game:GetService("ProximityPromptService")
local instantInteractEnabled = true

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt, player)
    if instantInteractEnabled then
        fireproximityprompt(prompt)
    end
end)
end})

-- Noclip
PlayerTab:CreateButton({ Name = "Noclip Keybind N", 
Callback = function()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local noclipEnabled = false

-- Function to set collision for character parts
local function setCollision(state)
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.CanCollide ~= state then
			part.CanCollide = state
		end
	end
end

-- Toggle noclip on key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.N then
		noclipEnabled = not noclipEnabled
	end
end)

-- Apply noclip every frame if enabled
RunService.Stepped:Connect(function()
	if noclipEnabled and character then
		setCollision(false)
	end
end)

-- Reset collision on respawn
player.CharacterAdded:Connect(function(char)
	character = char
	wait(1) -- Small delay to ensure parts are loaded
	if noclipEnabled then
		setCollision(false)
	end
end)

end})

-- R15 → R6
PlayerTab:CreateButton({ Name = "R15 To R6 (FE)", 
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"))()
end})

-- Fly
do
    local flySpeed = 50; local flying = false
    local bv, bg, conn; local UIS = game:GetService("UserInputService")
    local Players, RS = game:GetService("Players"), game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer

    PlayerTab:CreateSlider({ Name = "Fly Speed", Range = {1,300}, Increment=1, CurrentValue=50, Callback = function(v) flySpeed=v end })
    PlayerTab:CreateButton({ Name = "Toggle Fly (V)", Callback = function()
        flying = not flying
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if flying then
            bv = Instance.new("BodyVelocity", hrp); bv.MaxForce=Vector3.new(1e9,1e9,1e9)
            bg = Instance.new("BodyGyro", hrp); bg.MaxTorque=Vector3.new(1e9,1e9,1e9)
            conn = RS.Heartbeat:Connect(function()
                local cam = workspace.CurrentCamera.CFrame
                local move = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.RightVector end
                bv.Velocity = (move.Magnitude>0 and move.Unit or Vector3.new()) * flySpeed
                bg.CFrame = cam
            end)
        else
            if conn then conn:Disconnect() end
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end})
end

-- ESP Toggle
do
    local espEnabled=false; local espCache={}
    PlayerTab:CreateButton({ Name = "ESP Toggle", Callback = function()
        espEnabled = not espEnabled
        for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                if espEnabled and not espCache[p] then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.FillTransparency = 0.8; hl.OutlineColor = Color3.new(1,0,0)
                    espCache[p] = hl
                elseif not espEnabled and espCache[p] then
                    espCache[p]:Destroy(); espCache[p]=nil
                end
            end
        end
    end})
end

-- Server Hop & Rejoin
PlayerTab:CreateButton({ Name = "Server Hop", Callback = function()
    local ts=game:GetService("TeleportService")
    local hs=game:GetService("HttpService")
    local succ,res=pcall(function()
        return hs:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"))
    end)
    if succ then for _,s in ipairs(res.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            return ts:TeleportToPlaceInstance(game.PlaceId, s.id)
        end
    end end
end})
PlayerTab:CreateButton({ Name = "Rejoin", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end})

PlayerTab:CreateButton({ Name = "Flyjump", 
Callback = function()
    local UIS = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local humanoid

local enabled = false

local function enableFlyJump()
	local character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	UIS.JumpRequest:Connect(function()
		if enabled and humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
		end
	end)
end

-- Toggle with F key
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.F then
		enabled = not enabled
		if enabled then
			enableFlyJump()
			print("FlyJump enabled")
		else
			print("FlyJump disabled")
		end
	end
end)

player.CharacterAdded:Connect(function()
	if enabled then
		wait(1)
		enableFlyJump()
	end
end)

end})

-- Anti-AFK
PlayerTab:CreateButton({ Name = "Anti-AFK Toggle", 
Callback = function()
    local pl = game:GetService("Players").LocalPlayer
    pl.Idled:Connect(function()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end})

-- ==== INFECTIOUS SMILE TAB ====
local InfectiousTab = Window:CreateTab("Infectious Smile")
for _,tool in ipairs({"Bat","Bottle","Branch","Katana","Spear","Chain","Hatchet","Knife"}) do
    InfectiousTab:CreateButton({
        Name = "No "..tool.." Cooldown",
        Callback = function()
            pcall(function()
                local char=game.Players.LocalPlayer.Character
                if char and char:FindFirstChild(tool) then
                    local cd=char[tool]:FindFirstChild("Cooldown")
                    if cd then cd.Value=0 end
                end
            end)
        end
    })
end

local ForsakenTab = Window:CreateTab("Forsaken")

ForsakenTab:CreateButton({Name = "Forsaken Infinite Stamina Script", 
Callback = function()
    require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaLossDisabled = true
end})
