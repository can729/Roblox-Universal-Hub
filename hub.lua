-- FURENT_LSC v16.0 - Pro UI & Drawing ESP Framework
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- 1. ESKİ KALINTILARI TEMİZLE
if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

-- 2. ANA ARAYÜZ (Görseldeki Tasarımı Taklit Eder)
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_PRO_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 650, 0, 400); Main.Position = UDim2.new(0.5, -325, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Sol Sidebar (Menü Sekmeleri)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 150, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "FURENT_LSC"; Title.TextColor3 = Color3.fromRGB(138, 43, 226) -- Mor Vurgu
Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -160, 1, -20); TabContainer.Position = UDim2.new(0, 160, 0, 10)
TabContainer.BackgroundTransparency = 1

-- UI Framework Mantığı
local Tabs = {}
local function CreateTab(name, yPos, isActiveDefault)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 130, 0, 35); TabBtn.Position = UDim2.new(0, 10, 0, yPos)
    TabBtn.Text = "  " .. name; TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabBtn.BackgroundColor3 = isActiveDefault and Color3.fromRGB(25, 25, 35) or Color3.fromRGB(10, 10, 15)
    TabBtn.Font = Enum.Font.GothamSemibold; TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    local TabPage = Instance.new("ScrollingFrame", TabContainer)
    TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 2; TabPage.Visible = isActiveDefault
    
    local UIListLayout = Instance.new("UIListLayout", TabPage)
    UIListLayout.Padding = UDim.new(0, 10); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    table.insert(Tabs, {Btn = TabBtn, Page = TabPage})
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Btn.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
            t.Btn.TextColor3 = Color3.fromRGB(150,150,150)
            t.Page.Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabPage.Visible = true
    end)
    return TabPage
end

local function CreateToggle(parent, text, callback)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(1, -10, 0, 40); Container.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
    
    local ToggleBtn = Instance.new("TextButton", Container)
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20); ToggleBtn.Position = UDim2.new(1, -55, 0.5, -10)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); ToggleBtn.Text = ""
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(50, 50, 50)
        pcall(callback, state)
    end)
end

-- 3. SEKMELERİ OLUŞTUR
local TabVisuals = CreateTab("Visuals", 80, true)
local TabPlayer = CreateTab("Player", 125, false)

-- [MANTIK DEĞİŞKENLERİ]
local Settings = {
    ESP_Box = false, ESP_Tracer = false, Item_ESP = false,
    Fullbright = false, AntiVoid = false, FOV = 70
}

-- 4. VISUALS MODÜLLERİ (DRAWING API)
local ESP_Boxes = {}
local ESP_Lines = {}

RunService.RenderStepped:Connect(function()
    -- Oyuncu ESP (Box & Tracer)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not ESP_Boxes[player] then
                ESP_Boxes[player] = Drawing.new("Square")
                ESP_Boxes[player].Color = Color3.fromRGB(255, 255, 255)
                ESP_Boxes[player].Thickness = 1.5; ESP_Boxes[player].Filled = false
                
                ESP_Lines[player] = Drawing.new("Line")
                ESP_Lines[player].Color = Color3.fromRGB(138, 43, 226)
                ESP_Lines[player].Thickness = 1
            end
            
            local box = ESP_Boxes[player]
            local line = ESP_Lines[player]
            
            if (Settings.ESP_Box or Settings.ESP_Tracer) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if onScreen then
                    if Settings.ESP_Box then
                        box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z)
                        box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
                        box.Visible = true
                    else box.Visible = false end
                    
                    if Settings.ESP_Tracer then
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Ekranın altı
                        line.To = Vector2.new(pos.X, pos.Y)
                        line.Visible = true
                    else line.Visible = false end
                else
                    box.Visible = false; line.Visible = false
                end
            else
                box.Visible = false; line.Visible = false
            end
        end
    end
    
    -- Item ESP (Pet Sim 99 için Güvenli Highlight)
    if Settings.Item_ESP then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Coin") or obj.Name:find("Chest") or obj.Name:find("Egg")) then
                if not obj:FindFirstChild("ItemESP_HL") then
                    local hl = Instance.new("Highlight", obj)
                    hl.Name = "ItemESP_HL"; hl.FillColor = Color3.fromRGB(255, 215, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.FillTransparency = 0.5
                end
            end
        end
    else
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "ItemESP_HL" then obj:Destroy() end
        end
    end
end)

CreateToggle(TabVisuals, "2D Box ESP", function(state) Settings.ESP_Box = state end)
CreateToggle(TabVisuals, "Tracer ESP (Bottom)", function(state) Settings.ESP_Tracer = state end)
CreateToggle(TabVisuals, "Item / Coin ESP", function(state) Settings.Item_ESP = state end)

-- 5. PLAYER MODÜLLERİ
-- Fullbright & No Shadows
CreateToggle(TabPlayer, "Fullbright & No Shadows", function(state)
    Settings.Fullbright = state
    if state then
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        Lighting.FogEnd = 100000
    else
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
        Lighting.FogEnd = 10000 -- Oyunun varsayılanına döner
    end
end)

-- Anti-AFK
CreateToggle(TabPlayer, "Anti-AFK", function(state)
    if state then
        local VirtualUser = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- Anti-Void (Boşluğa düşmeyi engeller)
local AntiVoidPart
CreateToggle(TabPlayer, "Anti-Void", function(state)
    if state then
        AntiVoidPart = Instance.new("Part", workspace)
        AntiVoidPart.Size = Vector3.new(2000, 5, 2000)
        AntiVoidPart.Position = Vector3.new(0, -50, 0) -- Haritanın altı
        AntiVoidPart.Anchored = true; AntiVoidPart.Transparency = 0.5
        AntiVoidPart.Color = Color3.fromRGB(138, 43, 226)
    else
        if AntiVoidPart then AntiVoidPart:Destroy() end
    end
end)

-- FOV Değiştirici (Geniş açı)
CreateToggle(TabPlayer, "FOV Changer (120)", function(state)
    Camera.FieldOfView = state and 120 or 70
end)

-- 6. MENÜ GİZLE/GÖSTER (Sağ CTRL)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

print("FURENT_LSC Professional Yüklendi!")
