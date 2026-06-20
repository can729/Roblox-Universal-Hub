-- FURENT_LSC v18.0 - Teleport & Chams Update
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [1] ARAYÜZ TEMİZLİĞİ
if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

-- [2] ANA ARAYÜZ OLUŞTURMA
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_PRO_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380); Main.Position = UDim2.new(0.5, -260, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "FURENT_LSC"; Title.TextColor3 = Color3.fromRGB(138, 43, 226)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -150, 1, -20); TabContainer.Position = UDim2.new(0, 150, 0, 10)
TabContainer.BackgroundTransparency = 1

-- [3] UI FRAMEWORK (Genişletildi: TextBox ve Button eklendi)
local Tabs = {}
local function CreateTab(name, yPos, isActiveDefault)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 120, 0, 35); TabBtn.Position = UDim2.new(0, 10, 0, yPos)
    TabBtn.Text = "  " .. name; TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabBtn.BackgroundColor3 = isActiveDefault and Color3.fromRGB(25, 25, 35) or Color3.fromRGB(10, 10, 15)
    TabBtn.Font = Enum.Font.GothamSemibold; TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    local TabPage = Instance.new("ScrollingFrame", TabContainer)
    TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 2; TabPage.Visible = isActiveDefault
    
    local UIListLayout = Instance.new("UIListLayout", TabPage)
    UIListLayout.Padding = UDim.new(0, 8); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    table.insert(Tabs, {Btn = TabBtn, Page = TabPage})
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Btn.BackgroundColor3 = Color3.fromRGB(10, 10, 15); t.Btn.TextColor3 = Color3.fromRGB(150,150,150)
            t.Page.Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35); TabBtn.TextColor3 = Color3.new(1,1,1)
        TabPage.Visible = true
    end)
    return TabPage
end

local function CreateToggle(parent, text, callback)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(1, -10, 0, 35); Container.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
    
    local ToggleBtn = Instance.new("TextButton", Container)
    ToggleBtn.Size = UDim2.new(0, 35, 0, 18); ToggleBtn.Position = UDim2.new(1, -45, 0.5, -9)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); ToggleBtn.Text = ""
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(50, 50, 50)
        task.spawn(function() pcall(callback, state) end)
    end)
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 35); Btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    Btn.Text = text; Btn.TextColor3 = Color3.new(1,1,1); Btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() task.spawn(function() pcall(callback) end) end)
end

local function CreateTextBox(parent, placeholder, callback)
    local TextBox = Instance.new("TextBox", parent)
    TextBox.Size = UDim2.new(1, -10, 0, 35); TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TextBox.PlaceholderText = placeholder; TextBox.Text = ""
    TextBox.TextColor3 = Color3.new(1,1,1); TextBox.Font = Enum.Font.Gotham
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)
    TextBox.FocusLost:Connect(function() callback(TextBox.Text) end)
end

-- SEKMELER
local TabVisuals = CreateTab("Visuals", 70, true)
local TabPlayer = CreateTab("Player Mods", 115, false)
local TabTeleport = CreateTab("Teleport", 160, false)

-- [4] VISUALS MODÜLLERİ (Chams Eklendi)
local Settings = { Chams = false }

-- CHAMS (Duvar Arkası Gösterme)
task.spawn(function()
    while task.wait(1) do
        if Settings.Chams then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    if not player.Character:FindFirstChild("FURENT_Chams") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "FURENT_Chams"; hl.FillColor = Color3.fromRGB(138, 43, 226)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.FillTransparency = 0.3
                        hl.Parent = player.Character
                    end
                end
            end
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("FURENT_Chams") then
                    player.Character.FURENT_Chams:Destroy()
                end
            end
        end
    end
end)

CreateToggle(TabVisuals, "Player Chams (Duvar Arkası)", function(state) Settings.Chams = state end)

-- [5] TELEPORT SİSTEMİ (TAB 6 İSTEKLERİ)
local TargetPlayerName = ""
local SavedCFrame = nil

-- Oyuncu Işınlanma
CreateTextBox(TabTeleport, "Oyuncu Adını Girin (Kısmi yazılabilir)...", function(txt) TargetPlayerName = string.lower(txt) end)
CreateButton(TabTeleport, "Yazılan Oyuncuya Işınlan", function()
    if TargetPlayerName == "" then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #TargetPlayerName) == TargetPlayerName then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                break
            end
        end
    end
end)

-- Waypoint (Konum Kaydet/Yükle)
CreateButton(TabTeleport, "Mevcut Konumu Kaydet (Waypoint)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SavedCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

CreateButton(TabTeleport, "Kaydedilen Konuma Işınlan", function()
    if SavedCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
    end
end)

-- Sunucu İşlemleri (Rejoin & Server Hop)
CreateButton(TabTeleport, "Rejoin (Aynı Sunucuya Yeniden Bağlan)", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

CreateButton(TabTeleport, "Server Hop (Farklı Bir Sunucu Bul)", function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local function Hop()
        local success, result = pcall(function()
            return Http:JSONDecode(game:HttpGet(Api))
        end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    return
                end
            end
        end
    end
    Hop()
end)

-- [6] ARAYÜZÜ AÇMA/KAPAMA (Sağ CTRL)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)
