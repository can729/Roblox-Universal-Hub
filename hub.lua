-- FURENT_LSC v24.0 - Rain UI, Perfect Egg ESP & Skin Changer Fix

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- [GUI KORUMASI VE BYPASS]
local TargetGui = nil
pcall(function() TargetGui = (gethui and gethui()) or game:GetService("CoreGui") end)
if not TargetGui or not pcall(function() local _ = TargetGui.Name end) then
    TargetGui = LocalPlayer:WaitForChild("PlayerGui")
end

-- [1] ESKİ KALINTILARI TEMİZLE (Spamları Yok Et)
pcall(function()
    if TargetGui:FindFirstChild("FURENT_PRO_UI") then TargetGui.FURENT_PRO_UI:Destroy() end
    if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "F_EggESP" or v.Name == "F_EggChams" then v:Destroy() end
    end
end)

-- [2] ANA ARAYÜZ
local Blur = Instance.new("BlurEffect")
Blur.Name = "FURENT_Blur"; Blur.Size = 15; Blur.Enabled = true
pcall(function() Blur.Parent = Lighting end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FURENT_PRO_UI"; ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = TargetGui

local MainGreen = Color3.fromRGB(0, 255, 100)
local DarkBg = Color3.fromRGB(15, 15, 20)
local LighterBg = Color3.fromRGB(25, 25, 30)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 700, 0, 500); Main.Position = UDim2.new(0.5, -350, 0.5, -250)
Main.BackgroundColor3 = DarkBg; Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = MainGreen; MainStroke.Thickness = 1.5; MainStroke.Transparency = 0.5

-- [3] YENİ YAĞMUR EFEKTİ (Animasyonlu)
local RainFolder = Instance.new("Folder", Main)
local Raindrops = {}
local RainEnabled = true

for i = 1, 70 do
    local drop = Instance.new("Frame", RainFolder)
    drop.Size = UDim2.new(0, 2, 0, math.random(15, 30))
    drop.BackgroundColor3 = Color3.fromRGB(150, 180, 255) -- Yağmur rengi
    drop.BackgroundTransparency = math.random(50, 80) / 100
    drop.BorderSizePixel = 0
    drop.Rotation = 15 -- Çapraz düşüş
    drop.Position = UDim2.new(math.random(), 0, -math.random(), 0)
    drop.ZIndex = 0
    Instance.new("UICorner", drop).CornerRadius = UDim.new(1, 0)
    
    local speed = math.random(30, 60) / 1000 -- Kar'dan daha hızlı
    local sway = 0.003 -- Rüzgar yönü
    table.insert(Raindrops, {obj = drop, spd = speed, swy = sway})
end

RunService.RenderStepped:Connect(function()
    if not RainEnabled then return end
    for _, dropData in ipairs(Raindrops) do
        local d = dropData.obj
        d.Position = d.Position + UDim2.new(dropData.swy, 0, dropData.spd, 0)
        if d.Position.Y.Scale > 1.1 then 
            d.Position = UDim2.new(math.random() - 0.2, 0, -0.2, 0) 
        end
    end
end)

-- [4] SOL MENÜ & DİSCORD YAZISI
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 170, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12); Sidebar.ZIndex = 2
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local SidebarLine = Instance.new("Frame", Sidebar)
SidebarLine.Size = UDim2.new(0, 2, 1, 0); SidebarLine.Position = UDim2.new(1, -2, 0, 0); SidebarLine.BackgroundColor3 = MainGreen; SidebarLine.BorderSizePixel = 0; SidebarLine.ZIndex = 3

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "FURENT LSC"; Title.TextColor3 = MainGreen
Title.Font = Enum.Font.GothamBlack; Title.TextSize = 18; Title.BackgroundTransparency = 1; Title.ZIndex = 2
Instance.new("UIStroke", Title).Color = Color3.new(0,0,0); Instance.new("UIStroke", Title).Thickness = 1.5

local DiscordLabel = Instance.new("TextLabel", Sidebar)
DiscordLabel.Size = UDim2.new(1, 0, 0, 30); DiscordLabel.Position = UDim2.new(0, 0, 1, -40)
DiscordLabel.Text = "Devamı için dc : eren01_."; DiscordLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
DiscordLabel.Font = Enum.Font.GothamSemibold; DiscordLabel.TextSize = 11; DiscordLabel.BackgroundTransparency = 1; DiscordLabel.ZIndex = 2

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -180, 1, -20); TabContainer.Position = UDim2.new(0, 180, 0, 10)
TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

-- [5] UI MOTORU
local Tabs = {}
local function CreateTab(iconText, yPos, isActiveDefault)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 150, 0, 35); TabBtn.Position = UDim2.new(0, 10, 0, yPos)
    TabBtn.Text = "  " .. iconText; TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabBtn.BackgroundColor3 = isActiveDefault and LighterBg or Color3.fromRGB(10, 10, 12)
    TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 13; TabBtn.TextXAlignment = Enum.TextXAlignment.Left; TabBtn.ZIndex = 2
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    local TabPage = Instance.new("ScrollingFrame", TabContainer)
    TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 3; TabPage.ScrollBarImageColor3 = MainGreen; TabPage.Visible = isActiveDefault; TabPage.ZIndex = 2
    local UIListLayout = Instance.new("UIListLayout", TabPage)
    UIListLayout.Padding = UDim.new(0, 10); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    table.insert(Tabs, {Btn = TabBtn, Page = TabPage})
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Btn.BackgroundColor3 = Color3.fromRGB(10, 10, 12); t.Btn.TextColor3 = Color3.fromRGB(150,150,150); t.Page.Visible = false end
        TabBtn.BackgroundColor3 = LighterBg; TabBtn.TextColor3 = Color3.new(1,1,1); TabPage.Visible = true
    end)
    return TabPage
end

local function CreateToggle(parent, text, callback)
    local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 40); Container.BackgroundColor3 = LighterBg; Container.ZIndex = 2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(40,40,50)
    local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 2
    local ToggleBtn = Instance.new("TextButton", Container); ToggleBtn.Size = UDim2.new(0, 40, 0, 20); ToggleBtn.Position = UDim2.new(1, -55, 0.5, -10); ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60); ToggleBtn.Text = ""; ToggleBtn.ZIndex = 2; Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function() state = not state; ToggleBtn.BackgroundColor3 = state and MainGreen or Color3.fromRGB(50, 50, 60); task.spawn(function() pcall(callback, state) end) end)
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent); Btn.Size = UDim2.new(1, -15, 0, 40); Btn.BackgroundColor3 = MainGreen; Btn.Text = text; Btn.TextColor3 = Color3.new(0, 0, 0); Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 13; Btn.ZIndex = 2; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() task.spawn(function() pcall(callback) end) end)
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 55); Container.BackgroundColor3 = LighterBg; Container.ZIndex = 2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(40,40,50)
    local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(1, -20, 0, 20); Label.Position = UDim2.new(0, 15, 0, 8); Label.Text = text .. " : " .. default; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1; Label.ZIndex = 2
    local SliderBG = Instance.new("Frame", Container); SliderBG.Size = UDim2.new(1, -30, 0, 8); SliderBG.Position = UDim2.new(0, 15, 0, 35); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50); SliderBG.ZIndex = 2; Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)
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
    local TextBox = Instance.new("TextBox", parent); TextBox.Size = UDim2.new(1, -15, 0, 40)
    TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25); TextBox.PlaceholderText = placeholder; TextBox.Text = ""
    TextBox.TextColor3 = Color3.new(1,1,1); TextBox.Font = Enum.Font.Gotham; TextBox.TextSize = 13; TextBox.ZIndex = 2
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", TextBox).Color = MainGreen
    TextBox.FocusLost:Connect(function() callback(TextBox.Text) end)
end

-- [6] SEKMELER
local TabVisuals    = CreateTab("👁️ Visuals", 70, true)
local TabPlayer     = CreateTab("👤 Player", 110, false)
local TabWorld      = CreateTab("🌍 World", 150, false)
local TabTeleport   = CreateTab("📍 Teleport", 190, false)
local TabAutoFarm   = CreateTab("⚡ AutoFarm", 230, false)
local TabSkinChanger= CreateTab("🎭 Skin Changer", 270, false)
local TabSettings   = CreateTab("⚙️ Settings", 310, false)

-- [7] KUSURSUZ EGG ESP (SPAM FİX VE RENK/ŞANS OKUMA)
local VSettings = { Box = false, Tracer = false, Chams = false, EggChams = false }
local ESP_Boxes = {}; local ESP_Lines = {}

-- Oyuncu ESP (Kısaltıldı)
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

-- Gelişmiş Yumurta Tarayıcı
task.spawn(function()
    while task.wait(1) do
        if VSettings.EggChams then
            for _, obj in ipairs(workspace:GetDescendants()) do
                -- Sadece Modelleri tara (Paraları/Çöpleri es geçer)
                if obj:IsA("Model") then
                    local isEgg = false
                    local eggText = ""
                    local eggColor = Color3.fromRGB(255, 215, 0) -- Varsayılan Altın Sarısı
                    
                    local nameL = string.lower(obj.Name)
                    -- İsmi yumurta olanları bul
                    if nameL:find("egg") or nameL:find("yumurta") then isEgg = true end
                    
                    -- İçinde Şans/Çarpan yazısı varsa kesin yumurtadır, rengini de oradan al.
                    for _, desc in ipairs(obj:GetDescendants()) do
                        if desc:IsA("TextLabel") and (desc.Text:find("x") or desc.Text:find("Şans") or desc.Text:find("Yumurta")) then
                            isEgg = true
                            eggText = desc.Text
                            eggColor = desc.TextColor3 -- Oyunun o yumurta için belirlediği rengi kopyala
                            break
                        end
                    end
                    
                    if isEgg then
                        local rootPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if rootPart then
                            -- Daha önce çizilmemişse Çiz
                            if not rootPart:FindFirstChild("F_EggESP") then
                                local bgui = Instance.new("BillboardGui", rootPart)
                                bgui.Name = "F_EggESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 200, 0, 50); bgui.StudsOffset = Vector3.new(0, 4, 0)
                                
                                local lbl = Instance.new("TextLabel", bgui)
                                lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1
                                lbl.Text = "🥚 " .. (eggText ~= "" and eggText or "Yumurta")
                                lbl.TextColor3 = eggColor -- Rengi yansıt
                                lbl.Font = Enum.Font.GothamBlack; lbl.TextSize = 14; lbl.TextStrokeTransparency = 0; lbl.TextStrokeColor3 = Color3.new(0,0,0)
                            else
                                -- Varsa sadece yazıyı/rengi güncelle (Oda değişirse diye)
                                local lbl = rootPart.F_EggESP:FindFirstChildOfClass("TextLabel")
                                if lbl then
                                    lbl.Text = "🥚 " .. (eggText ~= "" and eggText or "Yumurta")
                                    lbl.TextColor3 = eggColor
                                end
                            end
                        end
                    end
                end
            end
        else
            -- Kapatıldığında tüm ESP'leri anında sil
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("F_EggESP") then
                    obj.F_EggESP:Destroy()
                end
            end
        end
    end
end)

CreateToggle(TabVisuals, "2D Box ESP", function(s) VSettings.Box = s end)
CreateToggle(TabVisuals, "Tracer ESP (Çizgi)", function(s) VSettings.Tracer = s end)
CreateToggle(TabVisuals, "Şans & Renk Uyumlu Egg ESP", function(s) VSettings.EggChams = s end)

-- [8] PLAYER MODS (FLY & SPIDER)
local PSettings = { Speed = 30, Jump = 75, Fly = false, FlySpeed = 50, Spider = false }

CreateToggle(TabPlayer, "Fly (Uçma - WASD & Boşluk)", function(s) PSettings.Fly = s end)
CreateSlider(TabPlayer, "Fly Hızı", 10, 300, 50, function(val) PSettings.FlySpeed = val end)
CreateToggle(TabPlayer, "Spider (Duvara Tırmanma)", function(s) PSettings.Spider = s end)
CreateSlider(TabPlayer, "Walk Speed", 30, 250, 30, function(val) PSettings.Speed = val end)
CreateSlider(TabPlayer, "Jump Power", 75, 300, 75, function(val) PSettings.Jump = val end)

task.spawn(function()
    while task.wait(0.1) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if not PSettings.Fly then
                LocalPlayer.Character.Humanoid.WalkSpeed = PSettings.Speed
                LocalPlayer.Character.Humanoid.JumpPower = PSettings.Jump
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
    local hrp = char.HumanoidRootPart
    local hum = char.Humanoid

    if PSettings.Fly then
        hum.PlatformStand = true
        local camCFrame = workspace.CurrentCamera.CFrame
        local moveDir = Vector3.new(0, 0, 0)
        
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
        local rayOrigin = hrp.Position
        local rayDirection = hrp.CFrame.LookVector * 2.5
        local params = RaycastParams.new(); params.FilterDescendantsInstances = {char}; params.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(rayOrigin, rayDirection, params)
        if result and UserInputService:IsKeyDown(Enum.KeyCode.W) then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
        end
    end
end)

-- [9] WORLD SEKMESİ
CreateSlider(TabWorld, "Yerçekimi (Gravity)", 0, 500, 196, function(val) workspace.Gravity = val end)
CreateSlider(TabWorld, "Saat (ClockTime)", 0, 24, 14, function(val) Lighting.ClockTime = val end)
CreateToggle(TabWorld, "Sisi Sil (No Fog)", function(state)
    Lighting.FogEnd = state and 100000 or 1000
    if Lighting:FindFirstChildWhichIsA("Atmosphere") then Lighting:FindFirstChildWhichIsA("Atmosphere").Density = state and 0 or 0.3 end
end)

-- [10] TELEPORT SEKMESİ
local TargetName = ""
CreateTextBox(TabTeleport, "Oyuncu Adını Girin...", function(txt) TargetName = string.lower(txt) end)
CreateButton(TabTeleport, "Oyuncuya Işınlan", function()
    if TargetName == "" then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #TargetName) == TargetName then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame; break end
        end
    end
end)

-- [11] AUTOFARM
local AutoTapOn = false
CreateToggle(TabAutoFarm, "Auto Clicker (1ms)", function(state)
    AutoTapOn = state
    task.spawn(function()
        while AutoTapOn do
            pcall(function() VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, true, game, 1); VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, false, game, 1) end)
            task.wait(0.001)
        end
    end)
end)

-- [12] SKIN CHANGER (DÜZELTİLDİ)
-- NOT: Kullanıcının Katalog Linki değil, "Görsel (Image) ID'si" girmesi gerekir.
local ChangerData = { Shirt = "", Pants = "" }
local function ApplySkin(character, id, className)
    pcall(function()
        local targetId = "rbxassetid://" .. id
        
        -- Karakterdeki eski kıyafeti sil
        for _, v in pairs(character:GetChildren()) do
            if v:IsA(className) then v:Destroy() end
        end
        
        -- Yeni kıyafeti oluştur ve uygula
        local newSkin = Instance.new(className)
        newSkin.Name = className
        if className == "Shirt" then newSkin.ShirtTemplate = targetId
        elseif className == "Pants" then newSkin.PantsTemplate = targetId end
        newSkin.Parent = character
    end)
end

local skinWarn = Instance.new("TextLabel", TabSkinChanger); skinWarn.Size = UDim2.new(1, -15, 0, 20); skinWarn.BackgroundTransparency = 1; skinWarn.Text = "Not: Lütfen 'Image ID' (Görsel ID) giriniz."; skinWarn.TextColor3 = Color3.fromRGB(200, 200, 200); skinWarn.Font = Enum.Font.Gotham; skinWarn.TextSize = 11
CreateTextBox(TabSkinChanger, "Kıyafet (Shirt) ID...", function(txt) ChangerData.Shirt = txt end)
CreateTextBox(TabSkinChanger, "Pantolon (Pants) ID...", function(txt) ChangerData.Pants = txt end)
CreateButton(TabSkinChanger, "Kıyafeti Uygula", function()
    local char = LocalPlayer.Character
    if not char then return end
    if ChangerData.Shirt ~= "" then ApplySkin(char, ChangerData.Shirt, "Shirt") end
    if ChangerData.Pants ~= "" then ApplySkin(char, ChangerData.Pants, "Pants") end
end)

-- [13] SETTINGS & YAĞMUR BUTONU
local ProfileFrame = Instance.new("Frame", TabSettings); ProfileFrame.Size = UDim2.new(1, -15, 0, 80); ProfileFrame.BackgroundColor3 = LighterBg; Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 6)
local AvatarImage = Instance.new("ImageLabel", ProfileFrame); AvatarImage.Size = UDim2.new(0, 60, 0, 60); AvatarImage.Position = UDim2.new(0, 10, 0, 10); AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 35); Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)
pcall(function() local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420); if isReady then AvatarImage.Image = content end end)

local NameLabel = Instance.new("TextLabel", ProfileFrame); NameLabel.Size = UDim2.new(1, -90, 0, 30); NameLabel.Position = UDim2.new(0, 80, 0, 10); NameLabel.BackgroundTransparency = 1; NameLabel.Text = "👤 " .. LocalPlayer.Name; NameLabel.TextColor3 = MainGreen; NameLabel.Font = Enum.Font.GothamBold; NameLabel.TextXAlignment = Enum.TextXAlignment.Left
local TimeLabel = Instance.new("TextLabel", ProfileFrame); TimeLabel.Size = UDim2.new(1, -90, 0, 30); TimeLabel.Position = UDim2.new(0, 80, 0, 40); TimeLabel.BackgroundTransparency = 1; TimeLabel.Text = "⏱️ Süre: 00:00:00"; TimeLabel.TextColor3 = Color3.new(1, 1, 1); TimeLabel.Font = Enum.Font.Gotham; TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

local StartTime = tick()
RunService.RenderStepped:Connect(function()
    local elapsed = tick() - StartTime
    TimeLabel.Text = string.format("⏱️ Oynama Süresi: %02d:%02d:%02d", math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), math.floor(elapsed % 60))
end)

local MenuKeybind = Enum.KeyCode.RightControl
CreateToggle(TabSettings, "Arka Plan Yağmur Efektini Kapat", function(state)
    RainEnabled = not state
    for _, drop in ipairs(Raindrops) do drop.obj.Visible = not state end
end)

local KeybindBtn = Instance.new("TextButton", TabSettings); KeybindBtn.Size = UDim2.new(1, -15, 0, 40); KeybindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50); KeybindBtn.Text = "Menü Tuşu: RightControl (Değiştir)"; KeybindBtn.TextColor3 = Color3.new(1,1,1); KeybindBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 6)
KeybindBtn.MouseButton1Click:Connect(function()
    KeybindBtn.Text = "Yeni tuşa basın..."
    local conn; conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then MenuKeybind = input.KeyCode; KeybindBtn.Text = "Menü Tuşu: " .. MenuKeybind.Name; conn:Disconnect() end
    end)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == MenuKeybind then if Main then Main.Visible = not Main.Visible; if Blur then Blur.Enabled = Main.Visible end end end
end)

print("FURENT_LSC v24.0 - Rain UI & Perfect Egg ESP Yüklendi!")
