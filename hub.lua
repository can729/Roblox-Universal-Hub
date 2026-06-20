-- FURENT_LSC v22.5 - Skin Fixer & Profile/Playtime Tracker Update

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- [GUI KORUMASI VE BYPASS SİSTEMİ]
local TargetGui = nil
pcall(function() TargetGui = (gethui and gethui()) or game:GetService("CoreGui") end)
if not TargetGui or not pcall(function() local _ = TargetGui.Name end) then
    TargetGui = LocalPlayer:WaitForChild("PlayerGui")
end

-- [1] ESKİ KALINTILARI TEMİZLE
pcall(function()
    if TargetGui:FindFirstChild("FURENT_PRO_UI") then TargetGui.FURENT_PRO_UI:Destroy() end
    if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
end)

-- [2] ANA ARAYÜZ VE BLUR
local Blur = Instance.new("BlurEffect")
Blur.Name = "FURENT_Blur"; Blur.Size = 15; Blur.Enabled = true
pcall(function() Blur.Parent = Lighting end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FURENT_PRO_UI"; ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = TargetGui

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 680, 0, 480); Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local MainGreen = Color3.fromRGB(0, 255, 0) -- Ana Tema Rengi: Yeşil

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
Title.Text = "FURENT_LSC v22.5"; Title.TextColor3 = MainGreen
Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1; Title.ZIndex = 2

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -170, 1, -20); TabContainer.Position = UDim2.new(0, 170, 0, 10)
TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

-- [4] UI FRAMEWORK MOTORU
local Tabs = {}
local function CreateTab(iconText, yPos, isActiveDefault)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 140, 0, 32); TabBtn.Position = UDim2.new(0, 10, 0, yPos)
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
    local Btn = Instance.new("TextButton", parent); Btn.Size = UDim2.new(1, -10, 0, 35); Btn.BackgroundColor3 = MainGreen; Btn.Text = text; Btn.TextColor3 = Color3.new(0, 0, 0); Btn.Font = Enum.Font.GothamBold; Btn.ZIndex = 2; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
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
            SliderFill.Size = UDim2.new(relX, 0, 1, 0)
            local value = math.floor(min + (max - min) * relX)
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

-- [5] İKONLU SEKMELER
local TabVisuals    = CreateTab("👁️ Visuals", 60, true)
local TabPlayer     = CreateTab("👤 Player", 100, false)
local TabWorld      = CreateTab("🌍 World", 140, false)
local TabTeleport   = CreateTab("📍 Teleport", 180, false)
local TabAutoFarm   = CreateTab("⚡ AutoFarm", 220, false)
local TabSkinChanger= CreateTab("🎭 Skin Changer", 260, false)
local TabSettings   = CreateTab("⚙️ Settings", 300, false)

-- [6] VISUALS (ESP & CHAMS & VE YUMURTA ESP)
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

Players.PlayerRemoving:Connect(function(player)
    if ESP_Boxes[player] then ESP_Boxes[player]:Remove(); ESP_Boxes[player] = nil end
    if ESP_Lines[player] then ESP_Lines[player]:Remove(); ESP_Lines[player] = nil end
end)

task.spawn(function()
    while task.wait(1) do
        if VSettings.Chams then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("F_Chams") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "F_Chams"; hl.FillColor = MainGreen; hl.FillTransparency = 0.4; hl.OutlineColor = Color3.new(1,1,1)
                end
            end
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("F_Chams") then p.Character.F_Chams:Destroy() end
            end
        end
    end
end)

-- Gelişmiş Yumurta Tarama Fonksiyonu
local function isValidEgg(obj)
    if not obj:IsA("Model") then return false end
    local name = string.lower(obj.Name)
    if not name:find("egg") then return false end
    local badNames = {"crate", "safe", "chest", "present", "gift", "loot", "safe_locker"}
    for _, bad in ipairs(badNames) do if name:find(bad) then return false end end
    local hasPrompt = false
    for _, prompt in ipairs(obj:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local promptText = string.lower(prompt.ObjectText .. " " .. prompt.ActionText)
            if promptText:find("open") or promptText:find("egg") then hasPrompt = true; break end
        end
    end
    return hasPrompt
end

task.spawn(function()
    while task.wait(5) do
        if VSettings.EggChams then
            local allObjects = workspace:GetDescendants()
            for index, obj in ipairs(allObjects) do
                if index % 200 == 0 then task.wait() end
                if isValidEgg(obj) then
                    if not obj:FindFirstChild("F_EggChams") then
                        local hl = Instance.new("Highlight", obj)
                        hl.Name = "F_EggChams"; hl.FillColor = Color3.fromRGB(255, 215, 0); hl.FillTransparency = 0.4; hl.OutlineColor = MainGreen
                    end
                    if not obj:FindFirstChild("F_EggESP") then
                        local multiplierText = ""
                        local matchText = string.match(obj.Name, "%d+x") or string.match(obj.Name, "x%d+")
                        if matchText then multiplierText = matchText else
                            for _, child in ipairs(obj:GetDescendants()) do
                                if child:IsA("TextLabel") and (string.find(string.lower(child.Text), "x") or string.match(child.Text, "%d+")) then
                                    multiplierText = child.Text; break
                                end
                            end
                        end
                        local eggText = "Yumurta" .. (multiplierText ~= "" and (" (" .. multiplierText .. ")") or "")
                        
                        local bgui = Instance.new("BillboardGui", obj)
                        bgui.Name = "F_EggESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 150, 0, 40); bgui.StudsOffset = Vector3.new(0, 5, 0)
                        local lbl = Instance.new("TextLabel", bgui)
                        lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = eggText; lbl.TextColor3 = Color3.fromRGB(0, 255, 255); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 16; lbl.TextStrokeTransparency = 0
                    end
                end
            end
        else
            for index, obj in ipairs(workspace:GetDescendants()) do
                if index % 200 == 0 then task.wait() end
                if obj:IsA("Model") then
                    if obj:FindFirstChild("F_EggChams") then obj.F_EggChams:Destroy() end
                    if obj:FindFirstChild("F_EggESP") then obj.F_EggESP:Destroy() end
                end
            end
        end
    end
end)

CreateToggle(TabVisuals, "2D Box ESP", function(s) VSettings.Box = s end)
CreateToggle(TabVisuals, "Tracer ESP (Çizgi)", function(s) VSettings.Tracer = s end)
CreateToggle(TabVisuals, "Player Chams (Duvar Arkası)", function(s) VSettings.Chams = s end)
CreateToggle(TabVisuals, "Gerçek Yumurta Chams & Şans ESP", function(s) VSettings.EggChams = s end)

-- [7] PLAYER MODS
local PSettings = { Speed = 30, Jump = 75 }
CreateSlider(TabPlayer, "Walk Speed", 30, 250, 30, function(val) PSettings.Speed = val end)
CreateSlider(TabPlayer, "Jump Power", 75, 300, 75, function(val) PSettings.Jump = val end)

local AntiVoidPart
CreateToggle(TabPlayer, "Anti-Void", function(state)
    if state then
        AntiVoidPart = Instance.new("Part", workspace); AntiVoidPart.Size = Vector3.new(5000, 5, 5000); AntiVoidPart.Position = Vector3.new(0, -30, 0)
        AntiVoidPart.Anchored = true; AntiVoidPart.Transparency = 0.5; AntiVoidPart.Color = MainGreen
    elseif AntiVoidPart then 
        AntiVoidPart:Destroy() 
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = PSettings.Speed
            LocalPlayer.Character.Humanoid.JumpPower = PSettings.Jump
        end
    end
end)

-- [8] WORLD SEKMESİ
CreateSlider(TabWorld, "Yerçekimi (Gravity)", 0, 500, 196, function(val) workspace.Gravity = val end)
CreateSlider(TabWorld, "Saat (ClockTime)", 0, 24, 14, function(val) Lighting.ClockTime = val end)
CreateToggle(TabWorld, "Hava Durumunu Kaldır (Sisi Sil)", function(state)
    Lighting.FogEnd = state and 100000 or 1000
    if Lighting:FindFirstChildWhichIsA("Atmosphere") then Lighting:FindFirstChildWhichIsA("Atmosphere").Density = state and 0 or 0.3 end
end)
CreateButton(TabWorld, "Gereksiz Dekorları Sil (Map Temizle)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") or (v:IsA("BasePart") and v.Name:lower():find("bush")) then v:Destroy() end
    end
end)

-- [9] TELEPORT SEKMESİ
local TargetName = ""; local SavedPos = nil
CreateTextBox(TabTeleport, "Oyuncu Adını Girin...", function(txt) TargetName = string.lower(txt) end)
CreateButton(TabTeleport, "Yazılan Oyuncuya Işınlan", function()
    if TargetName == "" then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #TargetName) == TargetName then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame; break
            end
        end
    end
end)
CreateButton(TabTeleport, "Mevcut Konumu Kaydet (Waypoint)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then SavedPos = LocalPlayer.Character.HumanoidRootPart.CFrame end
end)
CreateButton(TabTeleport, "Kaydedilen Konuma Işınlan", function()
    if SavedPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos end
end)

-- [10] AUTOFARM SİSTEMLERİ
local AutoFarmOn = false; local AutoTapOn = false; local AutoEggOn = false

CreateToggle(TabAutoFarm, "Smart Auto-Farm (Kırılabilir Kutu)", function(state)
    AutoFarmOn = state
    if state then
        task.spawn(function()
            while AutoFarmOn do
                pcall(function()
                    local target = nil; local shortest = math.huge
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local myPos = LocalPlayer.Character.HumanoidRootPart.Position
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            local name = string.lower(obj.Name)
                            local badNames = {"social", "reward", "vip", "group", "crate", "safe", "chest", "present", "gift", "locker"}
                            local isBad = false
                            for _, bad in ipairs(badNames) do
                                if name:find(bad) then isBad = true; break end
                            end
                            if not isBad then
                                if obj:IsA("Model") and (name:find("coin") or name:find("breakable")) then
                                    local part = obj:FindFirstChildWhichIsA("BasePart")
                                    if part and part.Transparency < 0.9 then
                                        local dist = (part.Position - myPos).Magnitude
                                        if dist < shortest then shortest = dist; target = part end
                                    end
                                end
                            end
                        end
                        if target then LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 3, 0); task.wait(0.5) end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
end)

CreateToggle(TabAutoFarm, "Auto Tap / Click (1ms Hızında)", function(state)
    AutoTapOn = state
    if state then
        task.spawn(function()
            while AutoTapOn do
                pcall(function()
                    VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, true, game, 1)
                    VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, false, game, 1)
                end)
                task.wait(0.001)
            end
        end)
    end
end)

CreateToggle(TabAutoFarm, "Auto Hatch Nearest Egg", function(state)
    AutoEggOn = state
    if state then
        task.spawn(function()
            while AutoEggOn do
                pcall(function()
                    for _, prompt in ipairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and (prompt.ObjectText:find("Egg") or prompt.ActionText:find("Open")) then
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                if (prompt.Parent.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 20 then 
                                    pcall(function() fireproximityprompt(prompt) end)
                                end
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
end)

-- [11] GELİŞMİŞ SKIN CHANGER (KARAKTER ÖZELLEŞTİRİCİ - FİX)
local ChangerData = { Shirt = "", Pants = "", Face = "", Acc = "" }

-- Katalog ID'sini gerçek Doku (Texture) ID'sine çeviren fonksiyon
local function ApplyDecalOrTemplate(character, id, className, parentName)
    pcall(function()
        local item = character:FindFirstChildOfClass(className)
        if not item then
            item = Instance.new(className, character)
            item.Name = parentName or className
        end
        
        local targetId = "rbxassetid://" .. id
        pcall(function()
            -- Exploit fonksiyonu kullanarak asset içindeki gerçek ID'yi çekmeye çalışıyoruz
            local objects = game:GetObjects("rbxassetid://" .. id)
            if objects and objects[1] then
                if className == "Shirt" and objects[1]:IsA("Shirt") then targetId = objects[1].ShirtTemplate
                elseif className == "Pants" and objects[1]:IsA("Pants") then targetId = objects[1].PantsTemplate
                elseif className == "Decal" and objects[1]:IsA("Decal") then targetId = objects[1].Texture end
            end
        end)

        if className == "Shirt" then item.ShirtTemplate = targetId
        elseif className == "Pants" then item.PantsTemplate = targetId
        elseif className == "Decal" then item.Texture = targetId end
    end)
end

CreateTextBox(TabSkinChanger, "Kıyafet ID (Shirt)...", function(txt) ChangerData.Shirt = txt end)
CreateTextBox(TabSkinChanger, "Pantolon ID (Pants)...", function(txt) ChangerData.Pants = txt end)
CreateTextBox(TabSkinChanger, "Yüz ID (Face)...", function(txt) ChangerData.Face = txt end)
CreateTextBox(TabSkinChanger, "Aksesuar ID (Şapka, Saç vb.)...", function(txt) ChangerData.Acc = txt end)

CreateButton(TabSkinChanger, "Karakteri Değiştir (Apply Skin)", function()
    local character = LocalPlayer.Character
    if not character then return end
    
    if ChangerData.Shirt ~= "" then ApplyDecalOrTemplate(character, ChangerData.Shirt, "Shirt") end
    if ChangerData.Pants ~= "" then ApplyDecalOrTemplate(character, ChangerData.Pants, "Pants") end
    if ChangerData.Face ~= "" then
        local head = character:FindFirstChild("Head")
        if head then ApplyDecalOrTemplate(head, ChangerData.Face, "Decal", "face") end
    end
    if ChangerData.Acc ~= "" then
        pcall(function()
            local objects = game:GetObjects("rbxassetid://" .. ChangerData.Acc)
            if objects and objects[1] then
                local asset = objects[1]
                if asset:IsA("Accessory") or asset:IsA("Hat") then asset.Parent = character end
            end
        end)
    end
end)

CreateButton(TabSkinChanger, "Tüm Aksesuarları Temizle", function()
    local character = LocalPlayer.Character
    if character then
        for _, obj in ipairs(character:GetChildren()) do
            if obj:IsA("Accessory") or obj:IsA("Hat") then obj:Destroy() end
        end
    end
end)

-- [12] SETTINGS (PROFIL VE OYNAMA SÜRESİ EKLENDİ)

-- Profil Çerçevesi
local ProfileFrame = Instance.new("Frame", TabSettings)
ProfileFrame.Size = UDim2.new(1, -10, 0, 80)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 6)

local AvatarImage = Instance.new("ImageLabel", ProfileFrame)
AvatarImage.Size = UDim2.new(0, 60, 0, 60)
AvatarImage.Position = UDim2.new(0, 10, 0, 10)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)

-- Profil fotoğrafını çek
pcall(function()
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbType, thumbSize)
    if isReady then AvatarImage.Image = content end
end)

local NameLabel = Instance.new("TextLabel", ProfileFrame)
NameLabel.Size = UDim2.new(1, -90, 0, 30)
NameLabel.Position = UDim2.new(0, 80, 0, 10)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = "👤 " .. LocalPlayer.Name
NameLabel.TextColor3 = MainGreen
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextXAlignment = Enum.TextXAlignment.Left

local TimeLabel = Instance.new("TextLabel", ProfileFrame)
TimeLabel.Size = UDim2.new(1, -90, 0, 30)
TimeLabel.Position = UDim2.new(0, 80, 0, 40)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "⏱️ Oynama Süresi: 00:00:00"
TimeLabel.TextColor3 = Color3.new(1, 1, 1)
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Oynama Süresi Hesaplayıcı (Zamanlayıcı)
local StartTime = tick()
RunService.RenderStepped:Connect(function()
    local elapsed = tick() - StartTime
    local hours = math.floor(elapsed / 3600)
    local mins = math.floor((elapsed % 3600) / 60)
    local secs = math.floor(elapsed % 60)
    TimeLabel.Text = string.format("⏱️ Oynama Süresi: %02d:%02d:%02d", hours, mins, secs)
end)

local MenuKeybind = Enum.KeyCode.RightControl
CreateToggle(TabSettings, "Arka Plan Kar Efektini Kapat", function(state)
    SnowEnabled = not state
    for _, flake in ipairs(Snowflakes) do flake.obj.Visible = not state end
end)

local KeybindBtn = Instance.new("TextButton", TabSettings); KeybindBtn.Size = UDim2.new(1, -10, 0, 35); KeybindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
KeybindBtn.Text = "Menü Tuşu: RightControl (Değiştir)"; KeybindBtn.TextColor3 = Color3.new(1,1,1); KeybindBtn.Font = Enum.Font.Gotham; KeybindBtn.ZIndex = 2; Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 6)
KeybindBtn.MouseButton1Click:Connect(function()
    KeybindBtn.Text = "Yeni tuşa basın..."
    local conn; conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            MenuKeybind = input.KeyCode; KeybindBtn.Text = "Menü Tuşu: " .. MenuKeybind.Name; conn:Disconnect()
        end
    end)
end)

-- [13] MENÜ AÇMA / KAPAMA SİSTEMİ
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == MenuKeybind then
        if Main then
            Main.Visible = not Main.Visible
            if Blur then Blur.Enabled = Main.Visible end
        end
    end
end)

print("FURENT_LSC v22.5 Başarıyla Yüklendi! Profil, Zamanlayıcı ve Skin Fixer Aktif.")
