-- FURENT_LSC v31.0 - KEY SYSTEM & CLUSTER FIX EDITION

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- [ GÜVENLİK ] ANAHTAR ŞİFRESİ
local CORRECT_KEY = "FURENT-VIP-2026"

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

-- YARDIMCI FONKSİYONLAR
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
    GetKeyBtn.Text = "Kopyalandı!"
    task.wait(2); GetKeyBtn.Text = "Anahtar Al (Discord Linkini Kopyala)"
end)

-- ANA YÜKLEME FONKSİYONU
local function LoadMainUI()
    -- ==========================================
    -- [ BÖLÜM 2: ANA MENÜ ]
    -- ==========================================
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

    -- UI MOTORU
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
    local TabAutoFarm   = CreateTab("⚡ AutoFarm", 170, false)
    local TabSettings   = CreateTab("⚙️ Settings", 215, false)

    -- [8] VISUALS (FIXED CLUSTER & LIMIT)
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

        for _, obj in ipairs(workspace:GetDescendants()) do
            count = count + 1
            if count % 5000 == 0 then task.wait() end 

            -- Sadece 3D dünyadaki yazılara bak (ScreenGui engeli)
            if obj:IsA("TextLabel") and obj:FindFirstAncestorWhichIsA("BillboardGui") or obj:FindFirstAncestorWhichIsA("SurfaceGui") then
                local txt = string.lower(obj.Text)
                if txt:find("x") or txt:find("şans") or txt:find("%%") then
                    local rootPart = obj:FindFirstAncestorWhichIsA("BasePart")
                    if rootPart then
                        table.insert(rawFound, {
                            part = rootPart,
                            model = obj:FindFirstAncestorWhichIsA("Model") or rootPart,
                            text = "🥚 " .. obj.Text,
                            color = obj.TextColor3 or Color3.fromRGB(255, 215, 0),
                            pos = rootPart.Position,
                            dist = (rootPart.Position - hrp.Position).Magnitude
                        })
                    end
                end
            end
        end

        -- 1. CLUSTERING (KÜMELEME) SİSTEMİ - ÜST ÜSTE BİNEN YAZILARI FİXLER!
        local clusteredData = {}
        for _, data in ipairs(rawFound) do
            local isDuplicate = false
            for _, c in ipairs(clusteredData) do
                -- Eğer 5 stud (adım) yakınında zaten bir yazı bulduysak, bu aynı yumurtanın diğer yazısıdır. Atla!
                if (c.pos - data.pos).Magnitude < 5 then
                    isDuplicate = true
                    break
                end
            end
            if not isDuplicate then table.insert(clusteredData, data) end
        end

        -- 2. MESAFEYE GÖRE SIRALAMA VE HIGHLIGHT LİMİTİ FİXİ
        table.sort(clusteredData, function(a, b) return a.dist < b.dist end)

        ClearRoomESP()
        
        -- Roblox max 31 Highlight sınırına takılmamak için sadece en yakın 30 taneye parlama veriyoruz
        local highlightCount = 0
        for _, data in ipairs(clusteredData) do
            CreateBillboard(data.part, data.text, data.color, Vector3.new(0, 6, 0))
            
            highlightCount = highlightCount + 1
            if highlightCount <= 30 then
                local hl = Instance.new("Highlight")
                hl.Name = "F_RoomESP_HL"
                hl.FillColor = data.color
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.4
                hl.OutlineTransparency = 0.1
                hl.Parent = data.model
                table.insert(FurentESPInstances, hl)
            end
        end
    end

    local isScanning = false
    local lastScanTick = 0
    task.spawn(function()
        while task.wait(1) do
            if VSettings.RoomESP and not isScanning then 
                if tick() - lastScanTick >= 30 then
                    isScanning = true; pcall(PerformScan); lastScanTick = tick(); isScanning = false
                end
            end
        end
    end)

    CreateToggle(TabVisuals, "2D Box ESP (Oyuncular)", function(s) VSettings.Box = s end)
    CreateToggle(TabVisuals, "Chams (Oyuncu Parla)", function(s) VSettings.Chams = s end)
    CreateToggle(TabVisuals, "Yumurta & Şifre ESP (Oda İçi)", function(s) 
        VSettings.RoomESP = s
        if s then lastScanTick = tick(); if not isScanning then isScanning = true; task.spawn(function() pcall(PerformScan); isScanning = false end) end else ClearRoomESP() end
    end)
    CreateButton(TabVisuals, "🔄 ESP Yazılarını Anında Yenile", function() if not isScanning then isScanning = true; lastScanTick = tick(); pcall(PerformScan); isScanning = false end end)

    -- ESP & CHAMS LOOP
    local DrawingSupported = pcall(function() local _ = Drawing.new("Line") end)
    local ESP_Boxes = {}
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
                    if not ESP_Boxes[player] then pcall(function() ESP_Boxes[player] = Drawing.new("Square"); ESP_Boxes[player].Thickness = 1.5; ESP_Boxes[player].Filled = false end) end
                    local box = ESP_Boxes[player]
                    if box then
                        if VSettings.Box and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                            if onScreen then box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z); box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2); box.Color = _G.ThemeColor; box.Visible = true else box.Visible = false end
                        else box.Visible = false end
                    end
                end
            end
        end
    end))

    -- PLAYER MODS
    local PSettings = { Speed = 16, Jump = 50 }
    CreateSlider(TabPlayer, "Walk Speed", 16, 300, 16, function(val) PSettings.Speed = val end)
    CreateSlider(TabPlayer, "Jump Power", 50, 400, 50, function(val) PSettings.Jump = val end)
    task.spawn(function()
        while task.wait(0.1) do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = PSettings.Speed; hum.JumpPower = PSettings.Jump end
        end
    end)

    -- AUTOFARM
    local AutoTapOn = false
    CreateToggle(TabAutoFarm, "Auto Clicker (Hızlı Tıklama)", function(state) AutoTapOn = state; task.spawn(function() while AutoTapOn do pcall(function() VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, true, game, 1); VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, false, game, 1) end); task.wait(0.01) end end) end)
    local AutoInteractOn = false
    CreateToggle(TabAutoFarm, "Auto Interact (E Tuşu Spam)", function(state) AutoInteractOn = state; task.spawn(function() while AutoInteractOn do pcall(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game) end); task.wait(0.1) end end) end)

    -- SETTINGS
    CreateColorPicker(TabSettings, "Arayüz Tema Rengini Ayarla")
    CreateToggle(TabSettings, "Arka Plan Yağmurunu Kapat", function(state) RainEnabled = not state; for _, drop in ipairs(Raindrops) do drop.obj.Visible = not state end end)
    
    local MenuKeybind = Enum.KeyCode.RightControl
    local KeybindBtn = Instance.new("TextButton", TabSettings); KeybindBtn.Size = UDim2.new(1, -15, 0, 45); KeybindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50); KeybindBtn.Text = "Menü Tuşu: RightControl (Değiştir)"; KeybindBtn.TextColor3 = Color3.new(1,1,1); KeybindBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 6)
    KeybindBtn.MouseButton1Click:Connect(function() KeybindBtn.Text = "Yeni tuşa basın..."; local conn; conn = UserInputService.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Keyboard then MenuKeybind = input.KeyCode; KeybindBtn.Text = "Menü Tuşu: " .. MenuKeybind.Name; conn:Disconnect() end end) end)

    AddConnection(UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == MenuKeybind then 
            if Main.Visible then
                local closeTween = TweenService:Create(MenuScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.8}); closeTween:Play(); Blur.Enabled = false; closeTween.Completed:Wait(); Main.Visible = false
            else
                MenuScale.Scale = 0.8; Main.Visible = true; Blur.Enabled = true; TweenService:Create(MenuScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
            end
        end
    end))
end

-- KEY KONTROL SİSTEMİ
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        VerifyBtn.Text = "DOĞRULANDI, YÜKLENİYOR..."
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.5)
        
        -- Key menüsünü yok et ve ana UI'ı yükle
        local closeTween = TweenService:Create(KeyScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.5})
        closeTween:Play()
        closeTween.Completed:Wait()
        KeyFrame:Destroy()
        
        LoadMainUI()
    else
        VerifyBtn.Text = "YANLIŞ ANAHTAR!"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(1.5)
        VerifyBtn.Text = "GİRİŞ YAP"
        VerifyBtn.BackgroundColor3 = _G.ThemeColor
    end
end)

print("FURENT_LSC v31.0 - KEY SİSTEMİ BAŞLATILDI. ŞİFRE: " .. CORRECT_KEY)
