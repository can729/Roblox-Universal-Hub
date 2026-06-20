-- FURENT_LSC v17.0 - Maximum Performance (Zero Lag) Framework
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [1] ARAYÜZ TEMİZLİĞİ
if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

-- [2] ANA ARAYÜZ OLUŞTURMA (Dark/Purple Theme)
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_PRO_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 350); Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "FURENT_LSC"; Title.TextColor3 = Color3.fromRGB(138, 43, 226)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -150, 1, -20); TabContainer.Position = UDim2.new(0, 150, 0, 10)
TabContainer.BackgroundTransparency = 1

-- [3] UI FRAMEWORK MANTIĞI
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
        task.spawn(function() pcall(callback, state) end) -- Hata olursa çökmeyi engeller
    end)
end

local TabVisuals = CreateTab("Visuals (ESP)", 70, true)
local TabPlayer = CreateTab("Player Mods", 115, false)

-- [4] SIFIR KASMA GARANTİLİ ESP MOTORU
local Settings = { ESP_Box = false, Item_ESP = false, Fullbright = false, WalkSpeed = 16 }
local ESP_Boxes = {}
local ItemConnection = nil

-- Oyuncu ESP (Sadece aktif oyuncuları tarar)
RunService.RenderStepped:Connect(function()
    if Settings.ESP_Box then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if not ESP_Boxes[player] then
                    local box = Drawing.new("Square")
                    box.Color = Color3.fromRGB(138, 43, 226); box.Thickness = 1.5; box.Filled = false
                    ESP_Boxes[player] = box
                end
                
                local box = ESP_Boxes[player]
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                    if onScreen then
                        box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z)
                        box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
                        box.Visible = true
                    else box.Visible = false end
                else box.Visible = false end
            end
        end
    else
        -- ESP kapatıldığında belleği temizle
        for _, box in pairs(ESP_Boxes) do box.Visible = false end
    end
end)

-- Item ESP (Optimize Edilmiş Event Bazlı Sistem)
local function HighlightItem(obj)
    if obj:IsA("Model") and (obj.Name:find("Coin") or obj.Name:find("Chest") or obj.Name:find("Egg")) then
        if not obj:FindFirstChild("FURENT_HL") then
            local hl = Instance.new("Highlight")
            hl.Name = "FURENT_HL"; hl.FillColor = Color3.fromRGB(255, 215, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.FillTransparency = 0.5
            hl.Parent = obj
        end
    end
end

CreateToggle(TabVisuals, "Player 2D Box ESP", function(state) Settings.ESP_Box = state end)
CreateToggle(TabVisuals, "Item/Coin ESP (No Lag)", function(state)
    Settings.Item_ESP = state
    if state then
        -- 1. Mevcut itemleri yavaşça (kasmadan) bul
        task.spawn(function()
            local items = workspace:GetDescendants()
            for i, obj in ipairs(items) do
                HighlightItem(obj)
                if i % 100 == 0 then task.wait() end -- Her 100 objede bir nefes al (Sıfır kasma)
            end
        end)
        -- 2. Yeni eklenenleri otomatik yakala (Tarama yapmaz)
        ItemConnection = workspace.DescendantAdded:Connect(HighlightItem)
    else
        -- Kapatıldığında temizle
        if ItemConnection then ItemConnection:Disconnect() end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "FURENT_HL" then obj:Destroy() end
        end
    end
end)

-- [5] PLAYER MODÜLLERİ (Bağımsız Motor)
CreateToggle(TabPlayer, "Fullbright (No Shadows)", function(state)
    if state then
        Lighting.GlobalShadows = false; Lighting.Brightness = 3
    else
        Lighting.GlobalShadows = true; Lighting.Brightness = 1
    end
end)

CreateToggle(TabPlayer, "Speed Hack (WalkSpeed 50)", function(state)
    Settings.WalkSpeed = state and 50 or 16
end)

-- Hızı Kasmadan Uygulama Motoru
task.spawn(function()
    while task.wait(0.5) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
        end
    end
end)

-- [6] ARAYÜZÜ AÇMA/KAPAMA (Sağ CTRL)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

print("FURENT_LSC v17 - Optimizasyon Başarılı!")
