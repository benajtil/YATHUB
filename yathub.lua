-- GUI Framework
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")

ScreenGui.Name = "CustomGUI"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Active = true
MainFrame.Draggable = true

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Active = true
TitleBar.Draggable = true

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 0.5

-- Tabs
local Tabs = {"Farm", "Visual", "Config", "Currency"}
local TabButtons = {}
local TabFrames = {}

for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "Button"
    TabButton.Parent = TitleBar
    TabButton.Text = tabName
    TabButton.Size = UDim2.new(0, 60, 0, 30)
    TabButton.Position = UDim2.new(0, (i - 1) * 60, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButtons[tabName] = TabButton

    local TabFrame = Instance.new("Frame")
    TabFrame.Name = tabName .. "Frame"
    TabFrame.Parent = ContentFrame
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = (i == 1)
    TabFrames[tabName] = TabFrame

    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(TabFrames) do
            frame.Visible = false
        end
        TabFrame.Visible = true
    end)
end

-- Close GUI Functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Auto Buy Fruit
local AutoBuyFruitButton = Instance.new("TextButton", TabFrames["Farm"])
AutoBuyFruitButton.Text = "Auto Buy & Store Fruit"
AutoBuyFruitButton.Size = UDim2.new(0, 200, 0, 30)
AutoBuyFruitButton.Position = UDim2.new(0.5, -100, 0.4, -15)
AutoBuyFruitButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AutoBuyFruitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoBuyFruitEnabled = false

AutoBuyFruitButton.MouseButton1Click:Connect(function()
    autoBuyFruitEnabled = not autoBuyFruitEnabled
    AutoBuyFruitButton.Text = autoBuyFruitEnabled and "Auto Buy: ON" or "Auto Buy: OFF"

    if autoBuyFruitEnabled then
        spawn(function()
            while autoBuyFruitEnabled do
                local fruitDealer = game.Workspace:FindFirstChild("Blox Fruit Dealer")
                if fruitDealer then
                    -- Buy the fruit
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseFruit", "Random")
                    
                    -- Store the fruit
                    local fruitName = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
                    if fruitName then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", fruitName.Name)
                        print(fruitName.Name .. " has been stored!")
                    end
                else
                    print("Fruit Dealer not found!")
                end
                wait(30) -- Check every 30 seconds
            end
        end)
    end
end)

-- Modify Bounty, Beli, and Fragments
local CurrencyFrame = TabFrames["Currency"]

local BountyButton = Instance.new("TextButton", CurrencyFrame)
BountyButton.Text = "Modify Bounty"
BountyButton.Size = UDim2.new(0, 200, 0, 30)
BountyButton.Position = UDim2.new(0.5, -100, 0.2, -15)
BountyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
BountyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

BountyButton.MouseButton1Click:Connect(function()
    local newBounty = 1000000 -- Modify to your desired bounty
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetBounty", newBounty)
    print("Bounty set to:", newBounty)
end)

local BeliButton = Instance.new("TextButton", CurrencyFrame)
BeliButton.Text = "Modify Beli"
BeliButton.Size = UDim2.new(0, 200, 0, 30)
BeliButton.Position = UDim2.new(0.5, -100, 0.4, -15)
BeliButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
BeliButton.TextColor3 = Color3.fromRGB(255, 255, 255)

BeliButton.MouseButton1Click:Connect(function()
    local newBeli = 10000000 -- Modify to your desired beli
    game.Players.LocalPlayer.Data.Beli.Value = newBeli
    print("Beli set to:", newBeli)
end)

local FragmentsButton = Instance.new("TextButton", CurrencyFrame)
FragmentsButton.Text = "Modify Fragments"
FragmentsButton.Size = UDim2.new(0, 200, 0, 30)
FragmentsButton.Position = UDim2.new(0.5, -100, 0.6, -15)
FragmentsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
FragmentsButton.TextColor3 = Color3.fromRGB(255, 255, 255)

FragmentsButton.MouseButton1Click:Connect(function()
    local newFragments = 5000 -- Modify to your desired fragments
    game.Players.LocalPlayer.Data.Fragments.Value = newFragments
    print("Fragments set to:", newFragments)
end)
