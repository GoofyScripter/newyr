-- Ensure the game is loaded
while game.PlaceId ~= 15502339080 do 
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("GuildCastle_UnlockGate"):InvokeServer()
    task.wait(5)
    game:GetService("TeleportService"):Teleport(15502339080, game.Players.LocalPlayer)
end

repeat task.wait() until game:IsLoaded()
setfpscap(3)

-- Low Graphics Optimizations
local function LowGraphics()
    pcall(function()
        local Lighting = game:GetService("Lighting")
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            end
        end
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
    end)
end

-- Main Optimizer Function
local function Optimizer()
    LowGraphics()
    local Player = game.Players.LocalPlayer
    for _, v in Player.PlayerScripts:GetChildren() do
        pcall(function() v:Destroy() end)
    end

    for _, v in workspace:GetChildren() do
        if not (v.Name == "__THINGS" or v.Name == Player.Name) then
            pcall(function() v:Destroy() end)
        end
    end
end

Optimizer()

-- Timer and Lootbox Counter GUI
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

local backgroundFrame = Instance.new("Frame")
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
backgroundFrame.Parent = screenGui

local thingy = Instance.new("TextLabel")
thingy.Size = UDim2.new(0, 200, 0, 50)
thingy.Position = UDim2.new(0.5, -100, 0.5, -125)
thingy.BackgroundTransparency = 1
thingy.Text = "george droyd fent reactor"
thingy.TextColor3 = Color3.new(1, 1, 1)
thingy.TextScaled = true
thingy.Font = Enum.Font.SourceSansBold
thingy.Parent = screenGui

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0, 200, 0, 50)
timerLabel.Position = UDim2.new(0.5, -100, 0.5, -75)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "00:00:00"
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.TextScaled = true
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.Parent = screenGui

local lootboxCounterLabel = Instance.new("TextLabel")
lootboxCounterLabel.Size = UDim2.new(0, 200, 0, 50)
lootboxCounterLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
lootboxCounterLabel.BackgroundTransparency = 1
lootboxCounterLabel.Text = "2025 New Years Gifts: 0"
lootboxCounterLabel.TextColor3 = Color3.new(1, 1, 1)
lootboxCounterLabel.TextScaled = true
lootboxCounterLabel.Font = Enum.Font.SourceSansBold
lootboxCounterLabel.Parent = screenGui

screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Function to count "2025 New Years Gift" items in Lootbox inventory
local clientSave = require(library:WaitForChild("Client").Save).Get()

local function getLootboxGifts()
    local count = 0
    for _, v in pairs(clientSave["Inventory"]["Lootbox"] or {}) do
        if v.id == "2025 New Years Gift" then
            count += 1
        end
    end
    return count
end

-- Timer and Lootbox Gifts Counter Update
local startTime = os.time()
local lootboxUpdateInterval = 5 -- Update every 5 seconds
local lastLootboxUpdate = os.time()

while true do
    -- Calculate elapsed time
    local elapsedTime = os.time() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)

    -- Update timer
    timerLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)

    -- Update lootbox gift count every 5 seconds
    if os.time() - lastLootboxUpdate >= lootboxUpdateInterval then
        lootboxCounterLabel.Text = "2025 New Years Gifts: " .. tostring(getLootboxGifts())
        lastLootboxUpdate = os.time()
    end

    task.wait(1) -- Timer updates every second
end
