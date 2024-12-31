while game.PlaceId ~= 15502339080 do 
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("GuildCastle_UnlockGate"):InvokeServer()
    task.wait(5)
    game:GetService("TeleportService"):Teleport(15502339080, game.Players.LocalPlayer)
end

task.wait(5)

repeat task.wait() until game:IsLoaded()
    setfpscap(3)

local function LowGraphics()
    pcall(function()
        Lighting = game:GetService("Lighting")
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for i,v in pairs(game:GetDescendants()) do
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
        for i,v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        workspace.DescendantAdded:Connect(function(child)
            task.spawn(function()
                if child:IsA('ForceField') then
                    game.RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Sparkles') then
                    game.RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Smoke') or child:IsA('Fire') then
                    game.RunService.Heartbeat:Wait()
                    child:Destroy()
                end
            end)
        end) 
    end)

    -- Low Processing
    for i, v in workspace:GetChildren() do
        pcall(function()
            if v.Name == "animate" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "PhantrancDGtp" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "ALWAYS_RENDERING" then
                v.Parent = game.ReplicatedStorage
            end
        end)
    end

    for i, v in pairs(workspace.__THINGS:GetChildren()) do
        pcall(function()
            if v.Name == "Sounds" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "RandomEvents" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "Flags" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "Hoverboards" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "Booths" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "ExclusiveEggs" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "ExclusiveEggPets" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "BalloonGifts" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "Sprinklers" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "Eggs" then
                v.Parent = game.ReplicatedStorage
            end
        end)
        pcall(function()
            if v.Name == "ShinyRelics" then
                v.Parent = game.ReplicatedStorage
            end
        end)
    end

    pcall(function()
        workspace.__THINGS.__INSTANCE_CONTAINER.ServerOwned.Parent = game.ReplicatedStorage
    end)

    local entities = {
        "Stats", 
        "Chat", 
        "Debris",
        "CoreGui",
    }
    for _, entity in entities do
        pcall(function()
            for i, v in game[entity]:GetDescendants() do
                pcall(function() v:Destroy() end)
            end
        end)
    end
end

local function Optimizer()

    LowGraphics()
    local Player = game.Players.LocalPlayer
    for i, v in Player.PlayerScripts:GetChildren() do
        pcall(function()
            v:Destroy()
        end)
    end

    for i, v in workspace:GetChildren() do
        if not (v.Name == "__THINGS" or v.Name == Player.Name)  then
            pcall(function()
                v:Destroy()
            end)
        end
    end

    for i, v in workspace.__THINGS:GetChildren() do
        if not (v.Name == "__INSTANCE_CONTAINER" or v.Name == "Instances") then
            pcall(function()
                v:Destroy()
            end)
        end
    end

    local Player = game.Players.LocalPlayer
    for i, v in Player.PlayerGui:GetDescendants() do
        pcall(function() v.Enabled = false end)
    end
end

-- Delete other player characters for less processing
spawn(function()
    while true do
        task.wait(30)
        for i, v in game.Players:GetPlayers() do
            if v ~= game.Players.LocalPlayer then
                pcall(function()
                    local Character = v.Character
                    Character:Destroy()
                end)
            end
        end
    end
end)

    local vu = game:GetService("VirtualUser")
    game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    
Optimizer()


local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

local backgroundFrame = Instance.new("Frame")
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
backgroundFrame.Parent = screenGui

local thingy = Instance.new("TextLabel")
thingy.Size = UDim2.new(0, 200, 0, 50)
thingy.Position = UDim2.new(0.5, -100, 0.5, -75)
thingy.BackgroundTransparency = 1
thingy.Text = "george droyd fent reactor"
thingy.TextColor3 = Color3.new(1, 1, 1)
thingy.TextScaled = true
thingy.Font = Enum.Font.SourceSansBold
thingy.Parent = screenGui

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0, 200, 0, 50)
timerLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "00:00:00"
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.TextScaled = true
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.Parent = screenGui

screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local startTime = os.time()
while true do
    local elapsedTime = os.time() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = elapsedTime % 60

    timerLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)

    task.wait(1)
end

