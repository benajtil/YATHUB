-- Main Configuration
local config = {
    AutoFarm = false,
    AutoCollectFruits = false,
    AutoCollectChests = false,
    AutoHop = false,
    SelectedSea = "First Sea", -- Options: "First Sea", "Second Sea", "Third Sea"
    WebhookURL = "", -- Optional: Set your webhook URL here
}

-- GUI Library Setup
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoFarmButton = Instance.new("TextButton")
local AutoCollectFruitsButton = Instance.new("TextButton")
local AutoCollectChestsButton = Instance.new("TextButton")
local AutoHopButton = Instance.new("TextButton")
local SeaSelector = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BorderSizePixel = 0

Title.Parent = MainFrame
Title.Text = "Blox Fruits Script"
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

local function createButton(parent, text, position)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Text = text
    button.Size = UDim2.new(0.8, 0, 0.1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.BorderSizePixel = 0
    return button
end

AutoFarmButton = createButton(MainFrame, "Toggle Auto Farm", UDim2.new(0.1, 0, 0.2, 0))
AutoCollectFruitsButton = createButton(MainFrame, "Toggle Auto Collect Fruits", UDim2.new(0.1, 0, 0.35, 0))
AutoCollectChestsButton = createButton(MainFrame, "Toggle Auto Collect Chests", UDim2.new(0.1, 0, 0.5, 0))
AutoHopButton = createButton(MainFrame, "Toggle Auto Hop", UDim2.new(0.1, 0, 0.65, 0))

SeaSelector.Parent = MainFrame
SeaSelector.Text = "Current Sea: " .. config.SelectedSea
SeaSelector.Size = UDim2.new(0.8, 0, 0.1, 0)
SeaSelector.Position = UDim2.new(0.1, 0, 0.8, 0)
SeaSelector.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SeaSelector.TextColor3 = Color3.fromRGB(255, 255, 255)
SeaSelector.Font = Enum.Font.SourceSansBold
SeaSelector.TextScaled = true

-- Farming Function
local function autoFarm()
    while config.AutoFarm do
        local npc = game.Workspace:FindFirstChild("Bandit") -- Example NPC name
        if npc and npc:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
            wait(0.5)
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
        wait(1)
    end
end

-- Collect Fruits Function
local function autoCollectFruits()
    while config.AutoCollectFruits do
        for _, fruit in pairs(workspace:GetChildren()) do
            if fruit:IsA("Model") and fruit.Name == "Fruit" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = fruit.PrimaryPart.CFrame
                wait(0.5)
            end
        end
        wait(5)
    end
end

-- Collect Chests Function
local function autoCollectChests()
    while config.AutoCollectChests do
        for _, chest in pairs(workspace:GetChildren()) do
            if chest:IsA("Model") and chest.Name == "Chest" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame
                wait(0.5)
            end
        end
        wait(5)
    end
end

-- Server Hop Function
local function autoHop()
    while config.AutoHop do
        wait(60) -- Example interval for server hop
        -- Add server hop logic here (e.g., teleport to another server)
    end
end

-- Button Callbacks
AutoFarmButton.MouseButton1Click:Connect(function()
    config.AutoFarm = not config.AutoFarm
    if config.AutoFarm then
        spawn(autoFarm)
    end
end)

AutoCollectFruitsButton.MouseButton1Click:Connect(function()
    config.AutoCollectFruits = not config.AutoCollectFruits
    if config.AutoCollectFruits then
        spawn(autoCollectFruits)
    end
end)

AutoCollectChestsButton.MouseButton1Click:Connect(function()
    config.AutoCollectChests = not config.AutoCollectChests
    if config.AutoCollectChests then
        spawn(autoCollectChests)
    end
end)

AutoHopButton.MouseButton1Click:Connect(function()
    config.AutoHop = not config.AutoHop
    if config.AutoHop then
        spawn(autoHop)
    end
end)

print("Blox Fruits GUI Loaded")
