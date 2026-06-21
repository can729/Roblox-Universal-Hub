-- FURENT_LSC v32.0 - FINAL BOSS EDITION (Owner Key, 150 Users, Full Features)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- [ GÜVENLİK ] ANAHTAR ŞİFRELERİ VE BİTİŞ TARİHİ
local OWNER_KEY = "FURENT-OWNER-KING"

-- 3 Hafta Sonrasının Tarihi (12 Temmuz 2026)
local EXPIRE_DATE = os.time({year = 2026, month = 7, day = 12, hour = 23, min = 59, sec = 59})

-- 150 Adet Geçerli Kullanıcı Anahtarı
local KeysString = "FURENT-A1B2-C3D4,FURENT-E5F6-G7H8,FURENT-I9J0-K1L2,FURENT-M3N4-O5P6,FURENT-Q7R8-S9T0,FURENT-U1V2-W3X4,FURENT-Y5Z6-A7B8,FURENT-C9D0-E1F2,FURENT-G3H4-I5J6,FURENT-K7L8-M9N0,FURENT-O1P2-Q3R4,FURENT-S5T6-U7V8,FURENT-W9X0-Y1Z2,FURENT-A3B4-C5D6,FURENT-E7F8-G9H0,FURENT-I1J2-K3L4,FURENT-M5N6-O7P8,FURENT-Q9R0-S1T2,FURENT-U3V4-W5X6,FURENT-Y7Z8-A9B0,FURENT-C1D2-E3F4,FURENT-G5H6-I7J8,FURENT-K9L0-M1N2,FURENT-O3P4-Q5R6,FURENT-S7T8-U9V0,FURENT-W1X2-Y3Z4,FURENT-A5B6-C7D8,FURENT-E9F0-G1H2,FURENT-I3J4-K5L6,FURENT-M7N8-O9P0,FURENT-Q1R2-S3T4,FURENT-U5V6-W7X8,FURENT-Y9Z0-A1B2,FURENT-C3D4-E5F6,FURENT-G7H8-I9J0,FURENT-K1L2-M3N4,FURENT-O5P6-Q7R8,FURENT-S9T0-U1V2,FURENT-W3X4-Y5Z6,FURENT-A7B8-C9D0,FURENT-E1F2-G3H4,FURENT-I5J6-K7L8,FURENT-M9N0-O1P2,FURENT-Q3R4-S5T6,FURENT-U7V8-W9X0,FURENT-Y1Z2-A3B4,FURENT-C5D6-E7F8,FURENT-G9H0-I1J2,FURENT-K3L4-M5N6,FURENT-O7P8-Q9R0,FURENT-S1T2-U3V4,FURENT-W5X6-Y7Z8,FURENT-A9B0-C1D2,FURENT-E3F4-G5H6,FURENT-I7J8-K9L0,FURENT-M1N2-O3P4,FURENT-Q5R6-S7T8,FURENT-U9V0-W1X2,FURENT-Y3Z4-A5B6,FURENT-C7D8-E9F0,FURENT-G1H2-I3J4,FURENT-K5L6-M7N8,FURENT-O9P0-Q1R2,FURENT-S3T4-U5V6,FURENT-W7X8-Y9Z0,FURENT-A1B2-C3D5,FURENT-E5F6-G7H9,FURENT-I9J0-K1L3,FURENT-M3N4-O5P7,FURENT-Q7R8-S9T1,FURENT-U1V2-W3X5,FURENT-Y5Z6-A7B9,FURENT-C9D0-E1F3,FURENT-G3H4-I5J7,FURENT-K7L8-M9N1,FURENT-O1P2-Q3R5,FURENT-S5T6-U7V9,FURENT-W9X0-Y1Z3,FURENT-A3B4-C5D7,FURENT-E7F8-G9H1,FURENT-I1J2-K3L5,FURENT-M5N6-O7P9,FURENT-Q9R0-S1T3,FURENT-U3V4-W5X7,FURENT-Y7Z8-A9B1,FURENT-C1D2-E3F5,FURENT-G5H6-I7J9,FURENT-K9L0-M1N3,FURENT-O3P4-Q5R7,FURENT-S7T8-U9V1,FURENT-W1X2-Y3Z5,FURENT-A5B6-C7D9,FURENT-E9F0-G1H3,FURENT-I3J4-K5L7,FURENT-M7N8-O9P1,FURENT-Q1R2-S3T5,FURENT-U5V6-W7X9,FURENT-Y9Z0-A1B3,FURENT-C3D4-E5F7,FURENT-G7H8-I9J1,FURENT-K1L2-M3N5,FURENT-O5P6-Q7R9,FURENT-S9T0-U1V3,FURENT-W3X4-Y5Z7,FURENT-A7B8-C9D1,FURENT-E1F2-G3H5,FURENT-I5J6-K7L9,FURENT-M9N0-O1P3,FURENT-Q3R4-S5T7,FURENT-U7V8-W9X1,FURENT-Y1Z2-A3B5,FURENT-C5D6-E7F9,FURENT-G9H0-I1J3,FURENT-K3L4-M5N7,FURENT-O7P8-Q9R1,FURENT-S1T2-U3V5,FURENT-W5X6-Y7Z9,FURENT-A9B0-C1D3,FURENT-E3F4-G5H7,FURENT-I7J8-K9L1,FURENT-M1N2-O3P5,FURENT-Q5R6-S7T9,FURENT-U9V0-W1X3,FURENT-Y3Z4-A5B7,FURENT-C7D8-E9F1,FURENT-G1H2-I3J5,FURENT-K5L6-M7N9,FURENT-O9P0-Q1R3,FURENT-S3T4-U5V7,FURENT-W7X8-Y9Z1,FURENT-B1C2-D3E4,FURENT-F5G6-H7I8,FURENT-J9K0-L1M2,FURENT-N3O4-P5Q6,FURENT-R7S8-T9U0,FURENT-V1W2-X3Y4,FURENT-Z5A6-B7C8,FURENT-D9E0-F1G2,FURENT-H3I4-J5K6,FURENT-L7M8-N9O0,FURENT-P1Q2-R3S4,FURENT-T5U6-V7W8,X9Y0-Z1A2,B3C4-D5E6,F7G8-H9I0,J1K2-L3M4,N5O6-P7Q8,R9S0-T1U2,V3W4-X5Y6"
local ValidKeys = string.split(KeysString, ",")

-- GLOBAL TEMA RENGİ
_G.ThemeColor = Color3.fromRGB(0, 255, 120)

if _G.FurentConnections then
    for _, conn in pairs(_G.FurentConnections) do pcall(function() conn:Disconnect() end) end
end
_G.FurentConnections = {}
local function AddConnection(conn) table.insert(_G.FurentConnections, conn) end

pcall(function()
    local oldTarget = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:FindFirstChild("PlayerGui")
    if oldTarget and oldTarget:FindFirstChild("FURENT_PRO_UI") then oldTarget.FURENT_PRO_UI:Destroy() end
    if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
    for _, v in pairs(workspace:GetDescendants()) do if v.Name == "F_RoomESP" or v.Name == "F_RoomESP_HL" then v:Destroy() end end
end)

local TargetGui = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FURENT_PRO_UI"; ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.Parent = TargetGui

local Blur = Instance.new("BlurEffect")
Blur.Name = "FURENT_Blur"; Blur.Size = 15; Blur.Enabled = true
pcall(function() Blur.Parent = Lighting end)

local DarkBg = Color3.fromRGB(12, 12, 16)
local LighterBg = Color3.fromRGB(20, 20, 25)

local function AddHoverEffect(guiObject, baseColor, hoverColor, transparencyBase, transparencyHover)
    guiObject.MouseEnter:Connect(function() TweenService:Create(guiObject, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = hoverColor, BackgroundTransparency = transparencyHover or 0}):Play() end)
    guiObject.MouseLeave:Connect(function() TweenService:Create(guiObject, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = baseColor, BackgroundTransparency = transparencyBase or 0}):Play() end)
end

-- ==========================================
-- [ BÖLÜM 1: KEY SİSTEMİ EKRANI ]
-- ==========================================
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 400, 0, 250); KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = DarkBg; KeyFrame.BackgroundTransparency = 0.05
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
local KeyStroke = Instance.new("UIStroke", KeyFrame); KeyStroke.Color = _G.ThemeColor; KeyStroke.Thickness = 2; KeyStroke.Transparency = 0.2

local KeyScale = Instance.new("UIScale", KeyFrame)
KeyScale.Scale = 0.8
TweenService:Create(KeyScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 50); KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.Text = "FURENT LSC - LOGIN"; KeyTitle.TextColor3 = _G.ThemeColor; KeyTitle.Font = Enum.Font.GothamBlack; KeyTitle.TextSize = 24; KeyTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -40, 0, 45); KeyInput.Position = UDim2.new(0, 20, 0, 70)
KeyInput.BackgroundColor3 = LighterBg; KeyInput.PlaceholderText = "Anahtarı (Key) Buraya Girin..."
KeyInput.Text = ""; KeyInput.TextColor3 = Color3.new(1,1,1); KeyInput.Font = Enum.Font.Gotham; KeyInput.TextSize = 14
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", KeyInput).Color = Color3.fromRGB(50,50,60)

local VerifyBtn = Instance.new("TextButton", KeyFrame)
VerifyBtn.Size = UDim2.new(1, -40, 0, 45); VerifyBtn.Position = UDim2.new(0, 20, 0, 130)
VerifyBtn.BackgroundColor3 = _G.ThemeColor; VerifyBtn.Text = "GİRİŞ YAP"; VerifyBtn.TextColor3 = Color3.new(0,0,0); VerifyBtn.Font = Enum.Font.GothamBold; VerifyBtn.TextSize = 16
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(1, -40, 0, 30); GetKeyBtn.Position = UDim2.new(0, 20, 0, 185)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,50); GetKeyBtn.Text = "Anahtar Al (Discord Linkini Kopyala)"; GetKeyBtn.TextColor3 = Color3.new(1,1,1); GetKeyBtn.Font = Enum.Font.GothamSemibold; GetKeyBtn.TextSize = 12
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard("https://discord.gg/fs28GEBuSX") end
    GetKeyBtn.Text = "Link Kopyalandı!"
    task.wait(2); GetKeyBtn.Text = "Anahtar Al (Discord Linkini Kopyala)"
end)

-- ==========================================
-- [ BÖLÜM 2: ANA MENÜ VE ÖZELLİKLER ]
-- ==========================================
local function LoadMainUI()
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 750, 0, 520); Main.Position = UDim2.new(0.5, -375, 0.5, -260)
    Main.BackgroundColor3 = DarkBg; Main.BackgroundTransparency = 0.05
    Main.BorderSizePixel = 0; Main.Active = true; Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = _G.ThemeColor; MainStroke.Thickness = 2; MainStroke.Transparency = 0.2

    local MenuScale = Instance.new("UIScale", Main)
    MenuScale.Scale = 0.8
    TweenService:Create(MenuScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

    -- YAĞMUR EFEKTİ
    local RainContainer = Instance.new("Frame", Main)
    RainContainer.Size = UDim2.new(1, 0, 1, 0); RainContainer.BackgroundTransparency = 1; RainContainer.ClipsDescendants = true; RainContainer.ZIndex = 1
    Instance.new("UICorner", RainContainer).CornerRadius = UDim.new(0, 12)
    local Raindrops = {}; local RainEnabled = true
    for i = 1, 80 do
        local drop = Instance.new("Frame", RainContainer); drop.Size = UDim2.new(0, 2, 0, math.random(20, 40)); drop.BackgroundColor3 = Color3.fromRGB(220, 230, 255); drop.BackgroundTransparency = math.random(10, 40) / 100; drop.BorderSizePixel = 0; drop.Rotation = 20; drop.Position = UDim2.new(math.random(), 0, -math.random(), 0); drop.ZIndex = 1
        Instance.new("UICorner", drop).CornerRadius = UDim.new(1, 0); table.insert(Raindrops, {obj = drop, spd = math.random(40, 70) / 1000, swy = 0.005})
    end
    AddConnection(RunService.RenderStepped:Connect(function(dt)
        if not RainEnabled then return end
        local timeScale = dt * 60 
        for _, dropData in ipairs(Raindrops) do
            local d = dropData.obj; d.Position = d.Position + UDim2.new(dropData.swy * timeScale, 0, dropData.spd * timeScale, 0)
            if d.Position.Y.Scale > 1.2 then d.Position = UDim2.new(math.random() - 0.2, 0, -0.2, 0) end
        end
    end))

    -- SOL MENÜ
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 180, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 10); Sidebar.ZIndex = 2; Sidebar.BackgroundTransparency = 0.1
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)
    local SidebarLine = Instance.new("Frame", Sidebar); SidebarLine.Size = UDim2.new(0, 2, 1, 0); SidebarLine.Position = UDim2.new(1, -2, 0, 0); SidebarLine.BackgroundColor3 = _G.ThemeColor; SidebarLine.BorderSizePixel = 0; SidebarLine.ZIndex = 3

    local Title = Instance.new("TextLabel", Sidebar); Title.Size = UDim2.new(1, 0, 0, 60); Title.Position = UDim2.new(0, 0, 0, 5); Title.Text = "FURENT LSC"; Title.TextColor3 = Color3.new(1,1,1); Title.Font = Enum.Font.GothamBlack; Title.TextSize = 22; Title.BackgroundTransparency = 1; Title.ZIndex = 3
    local TitleGradient = Instance.new("UIGradient", Title)

    task.spawn(function()
        local rot = 0
        while task.wait(0.015) do
            rot = rot + 4; if rot >= 360 then rot = 0 end
            pcall(function() TitleGradient.Rotation = rot; TitleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, _G.ThemeColor), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, _G.ThemeColor)}; SidebarLine.BackgroundColor3 = _G.ThemeColor; MainStroke.Color = _G.ThemeColor end) 
        end
    end)

    local TabContainer = Instance.new("Frame", Main)
    TabContainer.Size = UDim2.new(1, -190, 1, -20); TabContainer.Position = UDim2.new(0, 190, 0, 10); TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

    -- UI MOTORU & SEKMELER
    local Tabs = {}
    local function CreateTab(iconText, yPos, isActiveDefault)
        local TabBtn = Instance.new("TextButton", Sidebar); TabBtn.Size = UDim2.new(0, 160, 0, 38); TabBtn.Position = UDim2.new(0, 10, 0, yPos); TabBtn.Text = "  " .. iconText; TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150); TabBtn.BackgroundColor3 = isActiveDefault and _G.ThemeColor or Color3.fromRGB(15, 15, 20); TabBtn.BackgroundTransparency = isActiveDefault and 0.5 or 0.2; TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 14; TabBtn.TextXAlignment = Enum.TextXAlignment.Left; TabBtn.ZIndex = 3
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        local Stroke = Instance.new("UIStroke", TabBtn); Stroke.Color = _G.ThemeColor; Stroke.Transparency = isActiveDefault and 0 or 1
        local TabPage = Instance.new("ScrollingFrame", TabContainer); TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1; TabPage.ScrollBarThickness = 4; TabPage.ScrollBarImageColor3 = Color3.fromRGB(150,150,150); TabPage.Visible = isActiveDefault; TabPage.ZIndex = 3; TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local UIListLayout = Instance.new("UIListLayout", TabPage); UIListLayout.Padding = UDim.new(0, 12); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        table.insert(Tabs, {Btn = TabBtn, Page = TabPage, Strk = Stroke})
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do TweenService:Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 15, 20), BackgroundTransparency = 0.2}):Play(); t.Btn.TextColor3 = Color3.fromRGB(150,150,150); t.Strk.Transparency = 1; t.Page.Visible = false end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor, BackgroundTransparency = 0.5}):Play(); TabBtn.TextColor3 = Color3.new(1,1,1); Stroke.Color = _G.ThemeColor; Stroke.Transparency = 0; TabPage.Visible = true
        end)
        return TabPage
    end

    local function CreateToggle(parent, text, callback)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 45); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Container.ZIndex = 3; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50,50,60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 3
        local ToggleBtn = Instance.new("TextButton", Container); ToggleBtn.Size = UDim2.new(0, 44, 0, 22); ToggleBtn.Position = UDim2.new(1, -60, 0.5, -11); ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60); ToggleBtn.Text = ""; ToggleBtn.ZIndex = 3; Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
        local state = false
        ToggleBtn.MouseButton1Click:Connect(function() state = not state; TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = state and _G.ThemeColor or Color3.fromRGB(50, 50, 60)}):Play(); task.spawn(function() pcall(callback, state) end) end)
    end

    local function CreateButton(parent, text, callback)
        local Btn = Instance.new("TextButton", parent); Btn.Size = UDim2.new(1, -15, 0, 45); Btn.BackgroundColor3 = _G.ThemeColor; Btn.BackgroundTransparency = 0.5; Btn.Text = text; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 14; Btn.ZIndex = 3; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
        AddHoverEffect(Btn, _G.ThemeColor, Color3.new(1,1,1), 0.5, 0.2)
        Btn.MouseButton1Click:Connect(function() local btnTween = TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -25, 0, 40), Position = UDim2.new(0, 5, 0, 2)}); btnTween:Play(); btnTween.Completed:Wait(); TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -15, 0, 45), Position = UDim2.new(0, 0, 0, 0)}):Play(); task.spawn(function() pcall(callback) end) end)
    end

    local function CreateSlider(parent, text, min, max, default, callback)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 60); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Container.ZIndex = 3; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
        local Stroke = Instance.new("UIStroke", Container); Stroke.Color = Color3.fromRGB(50,50,60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(1, -20, 0, 20); Label.Position = UDim2.new(0, 15, 0, 10); Label.Text = text .. " : " .. default; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 3
        local SliderBG = Instance.new("Frame", Container); SliderBG.Size = UDim2.new(1, -30, 0, 8); SliderBG.Position = UDim2.new(0, 15, 0, 40); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50); SliderBG.ZIndex = 3; Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)
        local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0); SliderFill.BackgroundColor3 = _G.ThemeColor; SliderFill.ZIndex = 3; Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
        local dragging = false
        SliderBG.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
        UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local relX = math.clamp((UserInputService:GetMouseLocation().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1); TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(relX, 0, 1, 0)}):Play(); local value = math.floor(min + (max - min) * relX); Label.Text = text .. " : " .. value; pcall(callback, value) end end)
    end

    local function CreateTextBox(parent, placeholder, callback)
        local TextBox = Instance.new("TextBox", parent); TextBox.Size = UDim2.new(1, -15, 0, 45); TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25); TextBox.PlaceholderText = placeholder; TextBox.Text = ""; TextBox.TextColor3 = Color3.new(1,1,1); TextBox.Font = Enum.Font.Gotham; TextBox.TextSize = 14; TextBox.ZIndex = 3
        Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", TextBox).Color = _G.ThemeColor
        TextBox.FocusLost:Connect(function() callback(TextBox.Text) end)
    end

    local function CreateColorPicker(parent, text)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 110); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50, 50, 60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(1, -60, 0, 20); Label.Position = UDim2.new(0, 15, 0, 10); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
        local PreviewBox = Instance.new("Frame", Container); PreviewBox.Size = UDim2.new(0, 30, 0, 30); PreviewBox.Position = UDim2.new(1, -45, 0, 5); PreviewBox.BackgroundColor3 = _G.ThemeColor; Instance.new("UICorner", PreviewBox).CornerRadius = UDim.new(0, 4)
        local currentColor = {R = _G.ThemeColor.R*255, G = _G.ThemeColor.G*255, B = _G.ThemeColor.B*255}
        local function UpdateColor() _G.ThemeColor = Color3.fromRGB(currentColor.R, currentColor.G, currentColor.B); TweenService:Create(PreviewBox, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor}):Play() end
        local function addMinSlider(yPos, key)
            local SliderBG = Instance.new("Frame", Container); SliderBG.Size = UDim2.new(1, -30, 0, 8); SliderBG.Position = UDim2.new(0, 15, 0, yPos); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50); Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)
            local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(currentColor[key]/255, 0, 1, 0); SliderFill.BackgroundColor3 = Color3.fromRGB(key=="R" and 255 or 0, key=="G" and 255 or 0, key=="B" and 255 or 0); Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
            local dragging = false
            SliderBG.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
            UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local relX = math.clamp((UserInputService:GetMouseLocation().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1); SliderFill.Size = UDim2.new(relX, 0, 1, 0); currentColor[key] = math.floor(255 * relX); UpdateColor() end end)
        end
        addMinSlider(45, "R"); addMinSlider(65, "G"); addMinSlider(85, "B")
    end

    local TabVisuals    = CreateTab("👁️ Visuals", 80, true)
    local TabPlayer     = CreateTab("👤 Player", 125, false)
    local TabWorld      = CreateTab("🌍 World", 170, false)
    local TabTeleport   = CreateTab("📍 Teleport", 215, false)
    local TabAutoFarm   = CreateTab("⚡ AutoFarm", 260, false)
    local TabSkin       = CreateTab("🎭 Skin Changer", 305, false)
    local TabSettings   = CreateTab("⚙️ Settings", 350, false)

    -- [1] VISUALS
    local VSettings = { Box = false, Tracer = false, RoomESP = false, Chams = false }
    local FurentESPInstances = {}

    local function ClearRoomESP()
        for _, inst in ipairs(FurentESPInstances) do pcall(function() if inst then inst:Destroy() end end) end
        table.clear(FurentESPInstances)
    end

    local function CreateBillboard(parent, text, color, offset)
        local bgui = Instance.new("BillboardGui")
        bgui.Name = "F_RoomESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 250, 0, 50); bgui.StudsOffset = offset
        local lbl = Instance.new("TextLabel", bgui)
        lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = color; lbl.Font = Enum.Font.GothamBlack; lbl.TextSize = 18; lbl.TextStrokeTransparency = 0; lbl.TextStrokeColor3 = Color3.new(0,0,0)
        bgui.Parent = parent
        table.insert(FurentESPInstances, bgui)
    end

    local function PerformScan()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local rawFound = {}
        local count = 0
        local descendants = workspace:GetDescendants()
        for i = 1, #descendants do
            local obj = descendants[i]
            count = count + 1
            if count % 5000 == 0 then task.wait() end 
            if obj and obj.Parent then
                if obj:IsA("TextLabel") and (obj:FindFirstAncestorWhichIsA("BillboardGui") or obj:FindFirstAncestorWhichIsA("SurfaceGui")) then
                    pcall(function()
                        local txt = string.lower(obj.Text)
                        if txt:find("x") or txt:find("şans") or txt:find("%%") then
                            local rootPart = obj:FindFirstAncestorWhichIsA("BasePart")
                            local model = obj:FindFirstAncestorWhichIsA("Model")
                            if model == workspace then model = rootPart end
                            if rootPart then
                                table.insert(rawFound, {
                                    part = rootPart, model = model or rootPart, 
                                    text = "🥚 " .. obj.Text, color = obj.TextColor3 or Color3.fromRGB(255, 215, 0), 
                                    pos = rootPart.Position, dist = (rootPart.Position - hrp.Position).Magnitude
                                })
                            end
                        end
                    end)
                end
            end
        end

        local clusteredData = {}
        for _, data in ipairs(rawFound) do
            local isDuplicate = false
            for _, c in ipairs(clusteredData) do
                if (c.pos - data.pos).Magnitude < 5 then isDuplicate = true; break end
            end
            if not isDuplicate then table.insert(clusteredData, data) end
        end

        table.sort(clusteredData, function(a, b) return a.dist < b.dist end)
        ClearRoomESP()
        
        local highlightCount = 0
        for _, data in ipairs(clusteredData) do
            CreateBillboard(data.part, data.text, data.color, Vector3.new(0, 6, 0))
            highlightCount = highlightCount + 1
            if highlightCount <= 30 and data.model and data.model ~= workspace then
                pcall(function()
                    local hl = Instance.new("Highlight")
                    hl.Name = "F_RoomESP_HL"; hl.FillColor = data.color; hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.FillTransparency = 0.4; hl.OutlineTransparency = 0.1; hl.Parent = data.model
                    table.insert(FurentESPInstances, hl)
                end)
            end
        end
    end

    local isScanning = false
    local lastScanTick = 0
    task.spawn(function()
        while task.wait(1) do
            if VSettings.RoomESP and not isScanning then 
                if tick() - lastScanTick >= 30 then isScanning = true; pcall(PerformScan); lastScanTick = tick(); isScanning = false end
            end
        end
    end)

    CreateToggle(TabVisuals, "2D Box ESP (Oyuncular)", function(s) VSettings.Box = s end)
    CreateToggle(TabVisuals, "Tracer ESP (Oyuncular)", function(s) VSettings.Tracer = s end)
    CreateToggle(TabVisuals, "Chams (Oyuncu Parla)", function(s) VSettings.Chams = s end)
    CreateToggle(TabVisuals, "Yumurta & Şifre ESP (Oda İçi)", function(s) VSettings.RoomESP = s; if s then lastScanTick = tick(); if not isScanning then isScanning = true; task.spawn(function() pcall(PerformScan); isScanning = false end) end else ClearRoomESP() end end)
    CreateButton(TabVisuals, "🔄 ESP Yazılarını Anında Yenile", function() if not isScanning then isScanning = true; lastScanTick = tick(); pcall(PerformScan); isScanning = false end end)

    local DrawingSupported = pcall(function() local _ = Drawing.new("Line") end)
    local ESP_Boxes = {}; local ESP_Lines = {}
    AddConnection(RunService.RenderStepped:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    if VSettings.Chams then
                        local hl = player.Character:FindFirstChild("FurentChams")
                        if not hl then hl = Instance.new("Highlight"); hl.Name = "FurentChams"; hl.Parent = player.Character end
                        hl.FillColor = _G.ThemeColor; hl.OutlineColor = Color3.new(1,1,1); hl.FillTransparency = 0.5; hl.OutlineTransparency = 0; hl.Enabled = true
                    else
                        if player.Character:FindFirstChild("FurentChams") then player.Character.FurentChams.Enabled = false end
                    end
                end
                if DrawingSupported then
                    if not ESP_Boxes[player] then pcall(function() ESP_Boxes[player] = Drawing.new("Square"); ESP_Boxes[player].Thickness = 1.5; ESP_Boxes[player].Filled = false; ESP_Lines[player] = Drawing.new("Line"); ESP_Lines[player].Thickness = 1 end) end
                    local box = ESP_Boxes[player]; local line = ESP_Lines[player]
                    if box and line then
                        if (VSettings.Box or VSettings.Tracer) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                            if onScreen then
                                if VSettings.Box then box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z); box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2); box.Color = _G.ThemeColor; box.Visible = true else box.Visible = false end
                                if VSettings.Tracer then line.Color = _G.ThemeColor; line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); line.To = Vector2.new(pos.X, pos.Y); line.Visible = true else line.Visible = false end
                            else box.Visible = false; line.Visible = false end
                        else box.Visible = false; line.Visible = false end
                    end
                end
            end
        end
    end))

    -- [2] PLAYER MODS
    local PSettings = { Speed = 16, Jump = 50, Fly = false, FlySpeed = 50, Spider = false }
    CreateToggle(TabPlayer, "Fly (Uçma - WASD/Boşluk)", function(s) PSettings.Fly = s end)
    CreateSlider(TabPlayer, "Fly Hızı", 10, 300, 50, function(val) PSettings.FlySpeed = val end)
    CreateToggle(TabPlayer, "Spider (Duvara Tırmanma)", function(s) PSettings.Spider = s end)
    CreateSlider(TabPlayer, "Walk Speed", 16, 300, 16, function(val) PSettings.Speed = val end)
    CreateSlider(TabPlayer, "Jump Power", 50, 400, 50, function(val) PSettings.Jump = val end)

    task.spawn(function()
        while task.wait(0.1) do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum and not PSettings.Fly then hum.WalkSpeed = PSettings.Speed; hum.JumpPower = PSettings.Jump end
        end
    end)

    AddConnection(RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
        local hrp = char.HumanoidRootPart; local hum = char.Humanoid

        if PSettings.Fly then
            hum.PlatformStand = true
            local camCFrame = workspace.CurrentCamera.CFrame; local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            if moveDir.Magnitude > 0 then hrp.Velocity = moveDir.Unit * PSettings.FlySpeed else hrp.Velocity = Vector3.new(0, 0, 0) end
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camCFrame.LookVector)
        else
            if hum.PlatformStand then hum.PlatformStand = false end
        end

        if PSettings.Spider and not PSettings.Fly then
            local result = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 3, RaycastParams.new())
            if result and UserInputService:IsKeyDown(Enum.KeyCode.W) then hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z) end
        end
    end))

    -- [3] WORLD & TELEPORT
    CreateSlider(TabWorld, "Yerçekimi (Gravity)", 0, 500, 196, function(val) workspace.Gravity = val end)
    CreateSlider(TabWorld, "Saat (ClockTime)", 0, 24, 14, function(val) Lighting.ClockTime = val end)
    local TargetName = ""
    CreateTextBox(TabTeleport, "Oyuncu Adını Girin...", function(txt) TargetName = string.lower(txt) end)
    CreateButton(TabTeleport, "Oyuncuya Işınlan", function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #TargetName) == TargetName and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                break
            end
        end
    end)

    -- ==========================================
    -- [ EKSİK OLAN SEKMELERİN İÇERİKLERİ EKLENDİ ]
    -- ==========================================

    -- [4] AUTOFARM SEKMESİ (Temel Şablonlar)
    local AFSettings = { AutoTap = false, AutoCollect = false, AutoHatch = false }
    CreateToggle(TabAutoFarm, "Otomatik Tıklama (Auto Tap)", function(s) AFSettings.AutoTap = s end)
    CreateToggle(TabAutoFarm, "Otomatik Toplama (Auto Collect)", function(s) AFSettings.AutoCollect = s end)
    CreateToggle(TabAutoFarm, "Otomatik Yumurta Aç (Auto Hatch)", function(s) AFSettings.AutoHatch = s end)

    task.spawn(function()
        while task.wait(0.1) do
            if AFSettings.AutoTap then pcall(function() --[[ Auto Tap Mantığı Buraya ]] end) end
            if AFSettings.AutoCollect then pcall(function() --[[ Auto Collect Mantığı Buraya ]] end) end
        end
    end)

    -- [5] SKIN CHANGER SEKMESİ
    CreateButton(TabSkin, "👻 Görünmez Ol (Invisibility)", function()
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 1
                elseif v:IsA("Decal") then v.Transparency = 1 end
            end
        end
    end)
    CreateButton(TabSkin, "✨ Karakteri Parlat (ForceField)", function()
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.Material = Enum.Material.ForceField end
            end
        end
    end)
    CreateButton(TabSkin, "🔄 Görünümü Sıfırla", function()
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                    v.Transparency = 0; v.Material = Enum.Material.Plastic 
                elseif v:IsA("Decal") then v.Transparency = 0 end
            end
        end
    end)

    -- [6] SETTINGS SEKMESİ
    CreateColorPicker(TabSettings, "Tema Rengini Değiştir")
    CreateButton(TabSettings, "🌧️ Yağmur Efektini Aç/Kapat", function()
        RainEnabled = not RainEnabled
        RainContainer.Visible = RainEnabled
    end)
    CreateButton(TabSettings, "❌ Menüyü Tamamen Kapat (Destroy)", function()
        ScreenGui:Destroy()
        if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
    end)
end

-- ==========================================
-- [ BÖLÜM 3: GÜVENLİK VE BUTON TETİKLEYİCİ ]
-- ==========================================
VerifyBtn.MouseButton1Click:Connect(function()
    local currentTime = os.time()
    if currentTime > EXPIRE_DATE then
        VerifyBtn.Text = "SÜRE DOLDU! (12 TEMMUZ 2026)"
        TweenService:Create(VerifyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play()
        return
    end

    local inputKey = KeyInput.Text
    local isValid = false

    if inputKey == OWNER_KEY then
        isValid = true
    else
        for _, key in ipairs(ValidKeys) do
            if key == inputKey then
                isValid = true
                break
            end
        end
    end

    if isValid then
        VerifyBtn.Text = "GİRİŞ BAŞARILI!"
        TweenService:Create(VerifyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 120)}):Play()
        task.wait(0.6)
        
        local closeTween = TweenService:Create(KeyScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
        closeTween:Play()
        closeTween.Completed:Wait()
        
        KeyFrame.Visible = false
        if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
        LoadMainUI()
    else
        VerifyBtn.Text = "HATALI ANAHTAR!"
        TweenService:Create(VerifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        
        local originalPos = KeyFrame.Position
        for i = 1, 6 do
            KeyFrame.Position = originalPos + UDim2.new(0, math.random(-8, 8), 0, math.random(-8, 8))
            task.wait(0.04)
        end
        KeyFrame.Position = originalPos
        
        task.wait(1)
        VerifyBtn.Text = "GİRİŞ YAP"
        TweenService:Create(VerifyBtn, TweenInfo.new(0.3), {BackgroundColor3 = _G.ThemeColor}):Play()
    end
end)
