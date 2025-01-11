-- Auto Farm Script
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Function to teleport to NPC
local function teleportTo(targetPosition)
    rootPart.CFrame = CFrame.new(targetPosition)
end

-- Farming logic
local function autoFarm()
    while true do
        wait(1) -- Adjust delay as needed
        local npc = game.Workspace:FindFirstChild("Bandit") -- Example NPC name
        if npc and npc:FindFirstChild("HumanoidRootPart") then
            teleportTo(npc.HumanoidRootPart.Position)
            wait(0.5)
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(0.5)
            game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
    end
end

-- Run the auto farm function
autoFarm()
