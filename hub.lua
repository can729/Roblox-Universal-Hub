-- FURENT_LSC v22.2 - Character Creator & Green Theme Update

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [1] TEMİZLİK
if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end
if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end

-- [2] UI & BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Name = "FURENT_Blur"; Blur.Size = 15; Blur.Enabled = true

local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_PRO_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 680, 0, 480); Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- [RENK SABİTİ]
local MainGreen = Color3.fromRGB(0, 255, 0) -- Menüdeki tüm morlar artık YEŞİL

-- [3] KAR TANESİ EFEKTİ
local SnowFolder = Instance.new("Folder", Main)
local Snowflakes = {}
local SnowEnabled = true

for i = 1, 40 do
    local flake = Instance.new("Frame", SnowFolder)
    local size = math.random(2, 5)
    flake.Size = UDim2.new(0, size, 0, size); flake.BackgroundColor3 = Color3.new(1, 1, 1)
    flake.BackgroundTransparency = math.random(30, 70) / 100; flake.BorderSizePixel = 0
    flake.Position = UDim2.new(math.random(), 0, -math.random(), 0)
    flake.ZIndex = 0; Instance.new("UICorner", flake).CornerRadius = UDim.new(1, 0)
    local speed = math.random(10, 30) / 1000
    local sway = math.random(-10, 10) / 10000
    table.insert(Snowflakes, {obj = flake, spd = speed, swy = sway})
end

RunService.RenderStepped:Connect(function()
    if not SnowEnabled then return end
    for _, flakeData in ipairs(Snowflakes) do
        local f = flakeData.obj
        f.Position = f.Position + UDim2.new(flakeData.swy, 0, flakeData.spd, 0)
        if f.Position.Y.Scale > 1 then f.Position = UDim2.new(math.random(), 0, -0.1, 0) end
    end
end)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 160, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Sidebar.ZIndex = 2; Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "FURENT_LSC"; Title.TextColor3 = MainGreen
Title.Font = Enum.Font.GothamBold; Title.TextSize = 18; Title.BackgroundTransparency = 1; Title.ZIndex = 2

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -170, 1, -20); TabContainer.Position = UDim2.new(0, 170, 0, 10)
TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

-- [4] UI MOTORU
local Tabs = {}
local function CreateTab(iconText, yPos, isActiveDefault)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 140, 0, 35); TabBtn.Position = UDim2.new(0, 10, 0, yPos)
    TabBtn.Text = " " .. iconText; TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabBtn.BackgroundColor3 = isActiveDefault and Color3.fromRGB(25, 25, 35) or Color3.fromRGB(10, 10, 15)
    TabBtn.Font = Enum.Font.GothamSemibold; TabBtn.TextXAlignment = Enum.TextXAlignment.Left; TabBtn.ZIndex = 2
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    local TabPage = Instance.new("ScrollingFrame", TabContainer)
    TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 2; TabPage.Visible = isActiveDefault; TabPage.ZIndex = 2
    local UIListLayout = Instance.new("UIListLayout", TabPage)
    UIListLayout.Padding = UDim.new(0, 8); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    table.insert(Tabs, {Btn = TabBtn, Page = TabPage})
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Btn.BackgroundColor3 = Color3.fromRGB(10, 10, 15); t.Btn.TextColor3 = Color3.fromRGB(150,150,150); t.Page.Visible = false end
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35); TabBtn.TextColor3 = Color3.new(1,1,1); TabPage.Visible = true
    end)
    return TabPage
end

local function CreateToggle(parent, text, callback)
    local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -10, 0, 35); Container.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Container.ZIndex = 2
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.Gotham; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 2
    local ToggleBtn = Instance.new("TextButton", Container); ToggleBtn.Size = UDim2.new(0, 35, 0, 18); ToggleBtn.Position = UDim2.new(1, -45, 0.5, -9); ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); ToggleBtn.Text = ""; ToggleBtn.ZIndex = 2
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function() state = not state; ToggleBtn.BackgroundColor3 = state and MainGreen or Color3.fromRGB(50, 50, 50); task.spawn(function() pcall(callback, state) end) end)
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent); Btn.Size = UDim2.new(1, -10, 0, 35); Btn.BackgroundColor3 = MainGreen; Btn.Text = text; Btn.TextColor3 = Color3.new(0,0,0); Btn.Font = Enum.Font.GothamBold; Btn.ZIndex = 2; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() task.spawn(function() pcall(callback) end) end)
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -10, 0, 50); Container.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Container.ZIndex = 2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(1, -20, 0, 20); Label.Position = UDim2.new(0, 10, 0, 5); Label.Text = text .. " : " .. default; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.Gotham; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 2
    local SliderBG = Instance.new("Frame", Container); SliderBG.Size = UDim2.new(1, -20, 0, 10); SliderBG.Position = UDim2.new(0, 10, 0, 30); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 45); SliderBG.ZIndex = 2; Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)
    local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0); SliderFill.BackgroundColor3 = MainGreen; SliderFill.ZIndex = 2; Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
    local dragging = false
    SliderBG.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relX = math.clamp((UserInputService:GetMouseLocation().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
            SliderFill.Size = UDim2.new(relX, 0, 1, 0); local value = math.floor(min + (max - min) * relX)
            Label.Text = text .. " : " .. value; pcall(callback, value)
        end
    end)
end

local function CreateTextBox(parent, placeholder, callback)
    local TextBox = Instance.new("TextBox", parent); TextBox.Size = UDim2.new(1, -10, 0, 35)
    TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25); TextBox.PlaceholderText = placeholder; TextBox.Text = ""
    TextBox.TextColor3 = Color3.new(1,1,1); TextBox.Font = Enum.Font.Gotham; TextBox.ZIndex = 2
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)
    TextBox.FocusLost:Connect(function() callback(TextBox.Text) end)
end

-- [5] SEKMELER
local TabVisuals = CreateTab("👁️ Visuals", 70, true)
local TabPlayer  = CreateTab("👤 Player", 115, false)
local TabWorld   = CreateTab("🌍 World", 160, false)
local TabTeleport= CreateTab("📍 Teleport", 205, false)
local TabAutoFarm= CreateTab("⚡ AutoFarm", 250, false)
local TabSettings= CreateTab("⚙️ Settings", 295, false)

-- [6] VISUALS (ESP & SMART EGG ESP)
local VSettings = { Box = false, Tracer = false, Chams = false, EggChams = false }
local ESP_Boxes = {}; local ESP_Lines = {}

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not ESP_Boxes[player] then
                ESP_Boxes[player] = Drawing.new("Square"); ESP_Boxes[player].Color = Color3.fromRGB(255, 255, 255); ESP_Boxes[player].Thickness = 1.5; ESP_Boxes[player].Filled = false
                ESP_Lines[player] = Drawing.new("Line"); ESP_Lines[player].Color = MainGreen; ESP_Lines[player].Thickness = 1
            end
            local box = ESP_Boxes[player]; local line = ESP_Lines[player]
            if (VSettings.Box or VSettings.Tracer) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if onScreen then
                    if VSettings.Box then box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z); box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2); box.Visible = true else box.Visible = false end
                    if VSettings.Tracer then line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); line.To = Vector2.new(pos.X, pos.Y); line.Visible = true else line.Visible = false end
                else box.Visible = false; line.Visible = false end
            else box.Visible = false; line.Visible = false end
        end
    end
end)

-- EGG ESP OPTIMIZASYON (Kasalar hariç, şanslar her yerde)
task.spawn(function()
    while task.wait(3) do
        if VSettings.EggChams then
            for _, obj in ipairs(workspace:GetDescendants()) do
                local name = string.lower(obj.Name)
                if obj:IsA("Model") and (name:find("egg")) and not (name:find("crate") or name:find("chest") or name:find("safe")) then
                    if not obj:FindFirstChild("F_EggESP") then
                        local multiplierText = "Yumurta"
                        local match = string.match(obj.Name, "%d+x") or string.match(obj.Name, "x%d+")
                        if match then multiplierText = multiplierText .. " ["..match.."]" end
                        
                        local bgui = Instance.new("BillboardGui", obj); bgui.Name = "F_EggESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 100, 0, 30); bgui.StudsOffset = Vector3.new(0, 3, 0)
                        local lbl = Instance.new("TextLabel", bgui); lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = multiplierText; lbl.TextColor3 = MainGreen; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 14; lbl.TextStrokeTransparency = 0
                    end
                end
            end
        else
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("F_EggESP") then obj.F_EggESP:Destroy() end
            end
        end
    end
end)

CreateToggle(TabVisuals, "2D Box ESP", function(s) VSettings.Box = s end)
CreateToggle(TabVisuals, "Tracer ESP (Çizgi)", function(s) VSettings.Tracer = s end)
CreateToggle(TabVisuals, "Yumurta Çarpan ESP", function(s) VSettings.EggChams = s end)

-- [7] PLAYER MODS
local PSettings = { Speed = 30, Jump = 75 }
CreateSlider(TabPlayer, "Walk Speed", 30, 250, 30, function(val) PSettings.Speed = val end)
CreateSlider(TabPlayer, "Jump Power", 75, 300, 75, function(val) PSettings.Jump = val end)

-- [11] SETTINGS & CHARACTER CREATOR
local MenuKeybind = Enum.KeyCode.RightControl
local CharData = { Shirt = "", Pants = "", Acc = "" }

CreateTextBox(TabSettings, "Shirt ID", function(id) CharData.Shirt = id end)
CreateTextBox(TabSettings, "Pants ID", function(id) CharData.Pants = id end)
CreateTextBox(TabSettings, "Accessory ID", function(id) CharData.Acc = id end)
CreateButton(TabSettings, "Karakteri Uygula (Identity)", function()
    local char = LocalPlayer.Character
    if char then
        if CharData.Shirt ~= "" then
            local s = char:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", char)
            s.ShirtTemplate = "rbxassetid://" .. CharData.Shirt
        end
        if CharData.Pants ~= "" then
            local p = char:FindFirstChildOfClass("Pants") or Instance.new("Pants", char)
            p.PantsTemplate = "rbxassetid://" .. CharData.Pants
        end
        if CharData.Acc ~= "" then
            local acc = game:GetObjects("rbxassetid://" .. CharData.Acc)[1]
            if acc then acc.Parent = char end
        end
    end
end)

CreateToggle(TabSettings, "Arka Plan Karını Kapat", function(state) SnowEnabled = not state end)

-- [12] MENÜ KONTROL
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == MenuKeybind then Main.Visible = not Main.Visible; Blur.Enabled = Main.Visible end
end)

FURENT_LSC v22.2 güncellemesi hazır! Yeni yeşil arayüz ve karakter oluşturucu ile deneyiminizi kişiselleştirebilirsiniz. Herhangi bir düzenleme isterseniz buradayım!
