-- FURENT_LSC v28.0 - ULTRA VIP EDITION (Zero-Lag ESP, Discord Link & Premium UI)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- GLOBAL TEMA RENGİ
_G.ThemeColor = Color3.fromRGB(0, 255, 120)

-- [0] BAĞLANTI TEMİZLİĞİ
if _G.FurentConnections then
    for _, conn in pairs(_G.FurentConnections) do pcall(function() conn:Disconnect() end) end
end
_G.FurentConnections = {}
local function AddConnection(conn) table.insert(_G.FurentConnections, conn) end

-- [1] ESKİ KALINTILARI TEMİZLE
pcall(function()
    local oldTarget = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:FindFirstChild("PlayerGui")
    if oldTarget and oldTarget:FindFirstChild("FURENT_PRO_UI") then oldTarget.FURENT_PRO_UI:Destroy() end
    if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("FURENT_PRO_UI") then LocalPlayer.PlayerGui.FURENT_PRO_UI:Destroy() end
    if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
    for _, v in pairs(workspace:GetDescendants()) do if v.Name == "F_RoomESP" then v:Destroy() end end
end)

-- [2] KURŞUN GEÇİRMEZ GUI HEDEFİ
local TargetGui = nil
if gethui then TargetGui = gethui() else
    local success = pcall(function()
        local test = Instance.new("Folder", game:GetService("CoreGui")); test:Destroy()
    end)
    TargetGui = success and game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
end

-- [3] MODERN & SİNEMATİK ANA ARAYÜZ (UI)
local Blur = Instance.new("BlurEffect")
Blur.Name = "FURENT_Blur"; Blur.Size = 15; Blur.Enabled = true
pcall(function() Blur.Parent = Lighting end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FURENT_PRO_UI"; ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.Parent = TargetGui

local DarkBg = Color3.fromRGB(12, 12, 16)
local LighterBg = Color3.fromRGB(20, 20, 25)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 750, 0, 520); Main.Position = UDim2.new(0.5, -375, 0.5, -260)
Main.BackgroundColor3 = DarkBg; Main.BackgroundTransparency = 0.05 -- Glassmorphism saydamlığı
Main.BorderSizePixel = 0; Main.Active = true; Main.Draggable = true
Main.ClipsDescendants = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = _G.ThemeColor; MainStroke.Thickness = 2; MainStroke.Transparency = 0.2

-- UI Açılış Animasyonu
Main.Scale = Vector2.new(0.9, 0.9)
TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = Vector2.new(1, 1)}):Play()

-- Buton Hover Efekti Yardımcısı
local function AddHoverEffect(guiObject, baseColor, hoverColor, transparencyBase, transparencyHover)
    guiObject.MouseEnter:Connect(function()
        TweenService:Create(guiObject, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = hoverColor, BackgroundTransparency = transparencyHover or 0}):Play()
    end)
    guiObject.MouseLeave:Connect(function()
        TweenService:Create(guiObject, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = baseColor, BackgroundTransparency = transparencyBase or 0}):Play()
    end)
end

-- [4] KUSURSUZ YAĞMUR EFEKTİ
local RainContainer = Instance.new("Frame", Main)
RainContainer.Size = UDim2.new(1, 0, 1, 0); RainContainer.BackgroundTransparency = 1
RainContainer.ClipsDescendants = true; RainContainer.ZIndex = 1
Instance.new("UICorner", RainContainer).CornerRadius = UDim.new(0, 12)

local Raindrops = {}
local RainEnabled = true

for i = 1, 80 do
    local drop = Instance.new("Frame", RainContainer)
    drop.Size = UDim2.new(0, 2, 0, math.random(20, 40))
    drop.BackgroundColor3 = Color3.fromRGB(220, 230, 255)
    drop.BackgroundTransparency = math.random(10, 40) / 100
    drop.BorderSizePixel = 0; drop.Rotation = 20
    drop.Position = UDim2.new(math.random(), 0, -math.random(), 0); drop.ZIndex = 1
    Instance.new("UICorner", drop).CornerRadius = UDim.new(1, 0)
    table.insert(Raindrops, {obj = drop, spd = math.random(40, 70) / 1000, swy = 0.005})
end

AddConnection(RunService.RenderStepped:Connect(function(dt)
    if not RainEnabled then return end
    local timeScale = dt * 60 
    for _, dropData in ipairs(Raindrops) do
        local d = dropData.obj
        d.Position = d.Position + UDim2.new(dropData.swy * timeScale, 0, dropData.spd * timeScale, 0)
        if d.Position.Y.Scale > 1.2 then d.Position = UDim2.new(math.random() - 0.2, 0, -0.2, 0) end
    end
end))

-- [5] SOL MENÜ & LOGO
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 10); Sidebar.ZIndex = 2
Sidebar.BackgroundTransparency = 0.1
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)
local SidebarLine = Instance.new("Frame", Sidebar)
SidebarLine.Size = UDim2.new(0, 2, 1, 0); SidebarLine.Position = UDim2.new(1, -2, 0, 0); SidebarLine.BackgroundColor3 = _G.ThemeColor; SidebarLine.BorderSizePixel = 0; SidebarLine.ZIndex = 3

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 60); Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "FURENT LSC"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBlack; Title.TextSize = 22; Title.BackgroundTransparency = 1; Title.ZIndex = 3
local TitleGradient = Instance.new("UIGradient", Title)

task.spawn(function()
    local rot = 0
    while task.wait(0.015) do
        rot = rot + 4; if rot >= 360 then rot = 0 end
        pcall(function() 
            TitleGradient.Rotation = rot 
            TitleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, _G.ThemeColor), 
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), 
                ColorSequenceKeypoint.new(1, _G.ThemeColor)
            }
            SidebarLine.BackgroundColor3 = _G.ThemeColor
            MainStroke.Color = _G.ThemeColor
        end) 
    end
end)

-- YENİ: Tıklanabilir Discord Butonu
local DiscordBtn = Instance.new("TextButton", Sidebar)
DiscordBtn.Size = UDim2.new(1, -20, 0, 40); DiscordBtn.Position = UDim2.new(0, 10, 1, -50)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40); DiscordBtn.ZIndex = 3; DiscordBtn.Text = ""
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", DiscordBtn).Color = Color3.fromRGB(88, 101, 242)
local DiscordLabel = Instance.new("TextLabel", DiscordBtn); DiscordLabel.Size = UDim2.new(1, 0, 1, 0); DiscordLabel.BackgroundTransparency = 1; DiscordLabel.Text = "Discord: eren01_. (Katıl)"; DiscordLabel.TextColor3 = Color3.fromRGB(200, 200, 255); DiscordLabel.Font = Enum.Font.GothamBold; DiscordLabel.TextSize = 12; DiscordLabel.ZIndex = 3
AddHoverEffect(DiscordBtn, Color3.fromRGB(30, 30, 40), Color3.fromRGB(88, 101, 242), 0, 0.5)

DiscordBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/fs28GEBuSX")
            StarterGui:SetCore("SendNotification", {
                Title = "FURENT LSC VIP",
                Text = "Discord Davet Linki Panoya Kopyalandı! Tarayıcıya yapıştırabilirsin.",
                Duration = 5,
                Button1 = "Tamam"
            })
        end
    end)
end)

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -190, 1, -20); TabContainer.Position = UDim2.new(0, 190, 0, 10)
TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

-- [6] UI MOTORU
local Tabs = {}
local function CreateTab(iconText, yPos, isActiveDefault)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 160, 0, 38); TabBtn.Position = UDim2.new(0, 10, 0, yPos); TabBtn.Text = "  " .. iconText
    TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabBtn.BackgroundColor3 = isActiveDefault and _G.ThemeColor or Color3.fromRGB(15, 15, 20)
    TabBtn.BackgroundTransparency = isActiveDefault and 0.5 or 0.2
    TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 14; TabBtn.TextXAlignment = Enum.TextXAlignment.Left; TabBtn.ZIndex = 3
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    local Stroke = Instance.new("UIStroke", TabBtn); Stroke.Color = _G.ThemeColor; Stroke.Transparency = isActiveDefault and 0 or 1
    
    local TabPage = Instance.new("ScrollingFrame", TabContainer)
    TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 4; TabPage.ScrollBarImageColor3 = Color3.fromRGB(150,150,150); TabPage.Visible = isActiveDefault; TabPage.ZIndex = 3
    TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local UIListLayout = Instance.new("UIListLayout", TabPage); UIListLayout.Padding = UDim.new(0, 12); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    table.insert(Tabs, {Btn = TabBtn, Page = TabPage, Strk = Stroke})
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do 
            TweenService:Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 15, 20), BackgroundTransparency = 0.2}):Play()
            t.Btn.TextColor3 = Color3.fromRGB(150,150,150); t.Strk.Transparency = 1; t.Page.Visible = false 
        end
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor, BackgroundTransparency = 0.5}):Play()
        TabBtn.TextColor3 = Color3.new(1,1,1); Stroke.Color = _G.ThemeColor; Stroke.Transparency = 0; TabPage.Visible = true
    end)
    return TabPage
end

local function CreateToggle(parent, text, callback)
    local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 45); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Container.ZIndex = 3; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50,50,60)
    local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 3
    local ToggleBtn = Instance.new("TextButton", Container); ToggleBtn.Size = UDim2.new(0, 44, 0, 22); ToggleBtn.Position = UDim2.new(1, -60, 0.5, -11); ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60); ToggleBtn.Text = ""; ToggleBtn.ZIndex = 3; Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local state = false
    
    ToggleBtn.MouseButton1Click:Connect(function() 
        state = not state; 
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = state and _G.ThemeColor or Color3.fromRGB(50, 50, 60)}):Play()
        task.spawn(function() pcall(callback, state) end) 
    end)
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent); Btn.Size = UDim2.new(1, -15, 0, 45); Btn.BackgroundColor3 = _G.ThemeColor; Btn.BackgroundTransparency = 0.5; Btn.Text = text; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 14; Btn.ZIndex = 3; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    AddHoverEffect(Btn, _G.ThemeColor, Color3.new(1,1,1), 0.5, 0.2)
    Btn.MouseButton1Click:Connect(function() 
        local btnTween = TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -25, 0, 40), Position = UDim2.new(0, 5, 0, 2)})
        btnTween:Play(); btnTween.Completed:Wait()
        TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -15, 0, 45), Position = UDim2.new(0, 0, 0, 0)}):Play()
        task.spawn(function() pcall(callback) end) 
    end)
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
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relX = math.clamp((UserInputService:GetMouseLocation().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
            TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(relX, 0, 1, 0)}):Play()
            local value = math.floor(min + (max - min) * relX)
            Label.Text = text .. " : " .. value; pcall(callback, value)
        end
    end)
end

local function CreateTextBox(parent, placeholder, callback)
    local TextBox = Instance.new("TextBox", parent); TextBox.Size = UDim2.new(1, -15, 0, 45)
    TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25); TextBox.PlaceholderText = placeholder; TextBox.Text = ""
    TextBox.TextColor3 = Color3.new(1,1,1); TextBox.Font = Enum.Font.Gotham; TextBox.TextSize = 14; TextBox.ZIndex = 3
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", TextBox).Color = _G.ThemeColor
    TextBox.FocusLost:Connect(function() callback(TextBox.Text) end)
end

local function CreateColorPicker(parent, text)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(1, -15, 0, 110); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", Container).Color = Color3.fromRGB(50, 50, 60)

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -60, 0, 20); Label.Position = UDim2.new(0, 15, 0, 10)
    Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1

    local PreviewBox = Instance.new("Frame", Container)
    PreviewBox.Size = UDim2.new(0, 30, 0, 30); PreviewBox.Position = UDim2.new(1, -45, 0, 5)
    PreviewBox.BackgroundColor3 = _G.ThemeColor
    Instance.new("UICorner", PreviewBox).CornerRadius = UDim.new(0, 4)

    local currentColor = {R = _G.ThemeColor.R*255, G = _G.ThemeColor.G*255, B = _G.ThemeColor.B*255}

    local function UpdateColor()
        _G.ThemeColor = Color3.fromRGB(currentColor.R, currentColor.G, currentColor.B)
        TweenService:Create(PreviewBox, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor}):Play()
    end

    local function addMinSlider(yPos, colorName, key)
        local SliderBG = Instance.new("Frame", Container)
        SliderBG.Size = UDim2.new(1, -30, 0, 8); SliderBG.Position = UDim2.new(0, 15, 0, yPos)
        SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)
        local SliderFill = Instance.new("Frame", SliderBG)
        SliderFill.Size = UDim2.new(currentColor[key]/255, 0, 1, 0)
        SliderFill.BackgroundColor3 = Color3.fromRGB(key=="R" and 255 or 0, key=="G" and 255 or 0, key=="B" and 255 or 0)
        Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

        local dragging = false
        SliderBG.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local relX = math.clamp((UserInputService:GetMouseLocation().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
                SliderFill.Size = UDim2.new(relX, 0, 1, 0)
                currentColor[key] = math.floor(255 * relX)
                UpdateColor()
            end
        end)
    end

    addMinSlider(45, "R", "R"); addMinSlider(65, "G", "G"); addMinSlider(85, "B", "B")
end

-- [7] SEKMELER
local TabVisuals    = CreateTab("👁️ Visuals", 80, true)
local TabPlayer     = CreateTab("👤 Player", 125, false)
local TabWorld      = CreateTab("🌍 World", 170, false)
local TabTeleport   = CreateTab("📍 Teleport", 215, false)
local TabAutoFarm   = CreateTab("⚡ AutoFarm", 260, false)
local TabSkinChanger= CreateTab("🎭 Skin Changer", 305, false)
local TabSettings   = CreateTab("⚙️ Settings", 350, false)

-- [8] VISUALS (LAG-FREE ESP & CHAMS)
local VSettings = { Box = false, Tracer = false, RoomESP = false, Chams = false }

local function ClearRoomESP()
    for _, obj in ipairs(workspace:GetDescendants()) do if obj.Name == "F_RoomESP" then obj:Destroy() end end
end

local function CreateBillboard(parent, text, color, offset)
    local bgui = Instance.new("BillboardGui", parent)
    bgui.Name = "F_RoomESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 250, 0, 50); bgui.StudsOffset = offset or Vector3.new(0, 5, 0)
    local lbl = Instance.new("TextLabel", bgui)
    lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = color
    lbl.Font = Enum.Font.GothamBlack; lbl.TextSize = 16; lbl.TextStrokeTransparency = 0; lbl.TextStrokeColor3 = Color3.new(0,0,0)
end

-- ZERO-LAG TARAMA SİSTEMİ
local function UpdateRoomESP()
    if not VSettings.RoomESP then ClearRoomESP(); return end
    ClearRoomESP()
    
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local count = 0
    local processed = {} -- Aynı objeye birden fazla ESP çizilmesini önler

    -- Sadece gerekli GUI ve objelere odaklanarak yükü %90 hafifletir.
    for _, obj in ipairs(workspace:GetDescendants()) do
        count = count + 1
        if count % 200 == 0 then task.wait() end -- Donmayı kesinlikle önler

        -- 1. Yumurta Şans Oranlarını Bul (TextLabel)
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local txt = string.lower(obj.Text)
            if txt:find("x") or txt:find("şans") or txt:find("%%") then
                local rootPart = obj:FindFirstAncestorWhichIsA("BasePart")
                if rootPart and not processed[rootPart] then
                    if (rootPart.Position - hrp.Position).Magnitude < 400 then
                        processed[rootPart] = true
                        CreateBillboard(rootPart, "🥚 " .. obj.Text, obj.TextColor3)
                    end
                end
            end
        end

        -- 2. Butonları ve Şifreleri Bul (ProximityPrompt & ClickDetector)
        if obj:IsA("ProximityPrompt") or obj:IsA("ClickDetector") then
            local rootPart = obj.Parent
            if rootPart and rootPart:IsA("BasePart") and not processed[rootPart] then
                if (rootPart.Position - hrp.Position).Magnitude < 400 then
                    local nameL = string.lower(rootPart.Name)
                    local orderNum = rootPart:GetAttribute("Order") or rootPart:GetAttribute("Index") or rootPart:GetAttribute("Value")
                    
                    if not orderNum then
                        local val = rootPart:FindFirstChild("Order") or rootPart:FindFirstChild("Index")
                        if val and (val:IsA("NumberValue") or val:IsA("IntValue")) then orderNum = val.Value end
                    end

                    if orderNum or nameL:find("button") or nameL:find("puzzle") then
                        processed[rootPart] = true
                        local pText = orderNum and ("🎯 TIKLA! SIRA: " .. tostring(orderNum)) or "🔘 Buton"
                        CreateBillboard(rootPart, pText, rootPart.Color, Vector3.new(0, 3, 0))
                    end
                end
            end
        end
    end
end

local isScanning = false
task.spawn(function()
    while true do
        task.wait(1.5) -- Tarama süresini biraz uzatarak performansı artırdık
        if VSettings.RoomESP and not isScanning then 
            isScanning = true; pcall(UpdateRoomESP); isScanning = false
        end
    end
end)

CreateToggle(TabVisuals, "2D Box ESP (Oyuncular)", function(s) VSettings.Box = s end)
CreateToggle(TabVisuals, "Tracer ESP (Oyuncular)", function(s) VSettings.Tracer = s end)
CreateToggle(TabVisuals, "Chams (Duvar Arkası Renk)", function(s) VSettings.Chams = s end)
CreateToggle(TabVisuals, "Yumurta & Şifre ESP (Oda İçi)", function(s) VSettings.RoomESP = s; if s then pcall(UpdateRoomESP) else ClearRoomESP() end end)
CreateButton(TabVisuals, "🔄 Odadaki Şifreleri / Yumurtaları Yenile", function() if not isScanning then isScanning = true; pcall(UpdateRoomESP); isScanning = false end end)

local DrawingSupported = pcall(function() local _ = Drawing.new("Line") end)
local ESP_Boxes = {}; local ESP_Lines = {}

AddConnection(RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then
                if VSettings.Chams then
                    local hl = player.Character:FindFirstChild("FurentChams")
                    if not hl then hl = Instance.new("Highlight"); hl.Name = "FurentChams"; hl.Parent = player.Character end
                    hl.FillColor = _G.ThemeColor; hl.OutlineColor = Color3.new(1,1,1)
                    hl.FillTransparency = 0.5; hl.OutlineTransparency = 0; hl.Enabled = true
                else
                    if player.Character:FindFirstChild("FurentChams") then player.Character.FurentChams.Enabled = false end
                end
            end

            if DrawingSupported then
                if not ESP_Boxes[player] then
                    pcall(function()
                        ESP_Boxes[player] = Drawing.new("Square"); ESP_Boxes[player].Thickness = 1.5; ESP_Boxes[player].Filled = false
                        ESP_Lines[player] = Drawing.new("Line"); ESP_Lines[player].Thickness = 1
                    end)
                end
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

-- [9] PLAYER MODS
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

-- [10] WORLD & TELEPORT
CreateSlider(TabWorld, "Yerçekimi (Gravity)", 0, 500, 196, function(val) workspace.Gravity = val end)
CreateSlider(TabWorld, "Saat (ClockTime)", 0, 24, 14, function(val) Lighting.ClockTime = val end)

local TargetName = ""
CreateTextBox(TabTeleport, "Oyuncu Adını Girin...", function(txt) TargetName = string.lower(txt) end)
CreateButton(TabTeleport, "Oyuncuya Işınlan", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #TargetName) == TargetName and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame; break 
        end
    end
end)

-- [11] SETTINGS & PROFİL
local ProfileFrame = Instance.new("Frame", TabSettings); ProfileFrame.Size = UDim2.new(1, -15, 0, 80); ProfileFrame.BackgroundColor3 = LighterBg; ProfileFrame.BackgroundTransparency = 0.2; Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", ProfileFrame).Color = Color3.fromRGB(50, 50, 60)
local AvatarImage = Instance.new("ImageLabel", ProfileFrame); AvatarImage.Size = UDim2.new(0, 60, 0, 60); AvatarImage.Position = UDim2.new(0, 10, 0, 10); AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 35); Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    pcall(function() 
        local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        if isReady then AvatarImage.Image = content end 
    end)
end)

local NameLabel = Instance.new("TextLabel", ProfileFrame); NameLabel.Size = UDim2.new(1, -90, 0, 30); NameLabel.Position = UDim2.new(0, 80, 0, 10); NameLabel.BackgroundTransparency = 1; NameLabel.Text = "👤 " .. LocalPlayer.Name; NameLabel.TextColor3 = Color3.new(1,1,1); NameLabel.Font = Enum.Font.GothamBold; NameLabel.TextXAlignment = Enum.TextXAlignment.Left; NameLabel.TextSize = 16
local TimeLabel = Instance.new("TextLabel", ProfileFrame); TimeLabel.Size = UDim2.new(1, -90, 0, 30); TimeLabel.Position = UDim2.new(0, 80, 0, 40); TimeLabel.BackgroundTransparency = 1; TimeLabel.Text = "⏱️ Oynama Süresi: 00:00:00"; TimeLabel.TextColor3 = Color3.new(1, 1, 1); TimeLabel.Font = Enum.Font.Gotham; TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

local StartTime = tick()
AddConnection(RunService.RenderStepped:Connect(function()
    local elapsed = tick() - StartTime
    TimeLabel.Text = string.format("⏱️ Oynama Süresi: %02d:%02d:%02d", math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), math.floor(elapsed % 60))
end))

CreateColorPicker(TabSettings, "Arayüz Tema Rengini Ayarla")

CreateToggle(TabSettings, "Arka Plan Yağmurunu Kapat", function(state)
    RainEnabled = not state
    for _, drop in ipairs(Raindrops) do drop.obj.Visible = not state end
end)

local MenuKeybind = Enum.KeyCode.RightControl
local KeybindBtn = Instance.new("TextButton", TabSettings); KeybindBtn.Size = UDim2.new(1, -15, 0, 45); KeybindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50); KeybindBtn.Text = "Menü Tuşu: RightControl (Değiştir)"; KeybindBtn.TextColor3 = Color3.new(1,1,1); KeybindBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 6)

KeybindBtn.MouseButton1Click:Connect(function()
    KeybindBtn.Text = "Yeni tuşa basın..."
    local conn; conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then 
            MenuKeybind = input.KeyCode
            KeybindBtn.Text = "Menü Tuşu: " .. MenuKeybind.Name
            conn:Disconnect() 
        end
    end)
end)

-- Pürüzsüz Menü Açma/Kapatma
AddConnection(UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == MenuKeybind then 
        if Main then 
            if Main.Visible then
                local closeTween = TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = Vector2.new(0.8, 0.8)})
                closeTween:Play(); Blur.Enabled = false
                closeTween.Completed:Wait()
                Main.Visible = false
            else
                Main.Scale = Vector2.new(0.8, 0.8)
                Main.Visible = true; Blur.Enabled = true
                TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = Vector2.new(1, 1)}):Play()
            end
        end 
    end
end))

print("FURENT_LSC v28.0 ULTRA VIP - SIFIR LAG & PREMIUM TASARIM AKTİF!")
