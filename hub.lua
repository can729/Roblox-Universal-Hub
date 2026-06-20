-- FURENT_LSC v19.0 - Ultimate Framework
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [1] ARAYÜZ TEMİZLİĞİ
if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

-- [2] ANA ARAYÜZ (Koyu / Mor Tema)
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_PRO_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 420); Main.Position = UDim2.new(0.5, -300, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 150, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "FURENT_LSC"; Title.TextColor3 = Color3.fromRGB(138, 43, 226)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 18; Title.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -160, 1, -20); TabContainer.Position = UDim2.new(0, 160, 0, 10)
TabContainer.BackgroundTransparency = 1

-- [3] UI FRAMEWORK MOTORU
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

-- Araçlar (Toggle, Button, Label)
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

local function CreateLabel(parent, text)
    local Lbl = Instance.new("TextLabel", parent)
    Lbl.Size = UDim2.new(1, -10, 0, 25); Lbl.Text = text; Lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    Lbl.Font = Enum.Font.Gotham; Lbl.BackgroundTransparency = 1; Lbl.TextXAlignment = Enum.TextXAlignment.Left
    return Lbl
end

-- [4] SEKMELERİ OLUŞTUR
local TabVisuals = CreateTab("Visuals", 70, true)
local TabPlayer  = CreateTab("Player Mods", 115, false)
local TabTeleport= CreateTab("Teleport", 160, false)
local TabAutoFarm= CreateTab("AutoFarm", 205, false)
local TabSettings= CreateTab("Settings", 250, false)

-- [5] AYARLAR & PROFİL (Settings Tab)
local MenuKeybind = Enum.KeyCode.RightControl
local StartTime = os.time()

-- Profil Resmi ve İsim
local ProfileContainer = Instance.new("Frame", TabSettings)
ProfileContainer.Size = UDim2.new(1, -10, 0, 60); ProfileContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", ProfileContainer).CornerRadius = UDim.new(0, 6)

local Avatar = Instance.new("ImageLabel", ProfileContainer)
Avatar.Size = UDim2.new(0, 50, 0, 50); Avatar.Position = UDim2.new(0, 5, 0, 5)
Avatar.BackgroundTransparency = 1; Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
task.spawn(function()
    local content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    Avatar.Image = content
end)

local NameLbl = Instance.new("TextLabel", ProfileContainer)
NameLbl.Size = UDim2.new(0, 200, 0, 25); NameLbl.Position = UDim2.new(0, 65, 0, 5)
NameLbl.Text = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")"; NameLbl.TextColor3 = Color3.new(1,1,1)
NameLbl.Font = Enum.Font.GothamBold; NameLbl.BackgroundTransparency = 1; NameLbl.TextXAlignment = Enum.TextXAlignment.Left

local TimeLbl = Instance.new("TextLabel", ProfileContainer)
TimeLbl.Size = UDim2.new(0, 200, 0, 25); TimeLbl.Position = UDim2.new(0, 65, 0, 30)
TimeLbl.TextColor3 = Color3.fromRGB(138, 43, 226); TimeLbl.Font = Enum.Font.Gotham
TimeLbl.BackgroundTransparency = 1; TimeLbl.TextXAlignment = Enum.TextXAlignment.Left

RunService.RenderStepped:Connect(function()
    local diff = os.time() - StartTime
    local m = math.floor(diff / 60)
    local s = diff % 60
    TimeLbl.Text = string.format("Oyunda Geçen Süre: %02d:%02d", m, s)
end)

-- Tuş Atama
local KeybindBtn = Instance.new("TextButton", TabSettings)
KeybindBtn.Size = UDim2.new(1, -10, 0, 35); KeybindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
KeybindBtn.Text = "Menü Aç/Kapat Tuşu: RightControl (Tıkla ve Değiştir)"
KeybindBtn.TextColor3 = Color3.new(1,1,1); KeybindBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 6)

KeybindBtn.MouseButton1Click:Connect(function()
    KeybindBtn.Text = "Yeni tuşa basın..."
    local conn
    conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            MenuKeybind = input.KeyCode
            KeybindBtn.Text = "Menü Aç/Kapat Tuşu: " .. MenuKeybind.Name
            conn:Disconnect()
        end
    end)
end)

-- FPS Boost
CreateButton(TabSettings, "FPS Boost (Grafikleri Düşür/Optimize Et)", function()
    Lighting.GlobalShadows = false
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end)

-- [6] VISUALS (ESP TAM KADRO)
local Settings = { ESP_Box = false, ESP_Tracer = false, Chams = false, Item_ESP = false }
local ESP_Boxes = {}; local ESP_Lines = {}

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not ESP_Boxes[player] then
                ESP_Boxes[player] = Drawing.new("Square"); ESP_Boxes[player].Color = Color3.fromRGB(255, 255, 255); ESP_Boxes[player].Thickness = 1.5; ESP_Boxes[player].Filled = false
                ESP_Lines[player] = Drawing.new("Line"); ESP_Lines[player].Color = Color3.fromRGB(138, 43, 226); ESP_Lines[player].Thickness = 1
            end
            local box = ESP_Boxes[player]; local line = ESP_Lines[player]
            if (Settings.ESP_Box or Settings.ESP_Tracer) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if onScreen then
                    if Settings.ESP_Box then
                        box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z)
                        box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
                        box.Visible = true
                    else box.Visible = false end
                    if Settings.ESP_Tracer then
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); line.To = Vector2.new(pos.X, pos.Y); line.Visible = true
                    else line.Visible = false end
                else box.Visible = false; line.Visible = false end
            else box.Visible = false; line.Visible = false end
        end
    end
end)

-- Chams Loop
task.spawn(function()
    while task.wait(1) do
        if Settings.Chams then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("FURENT_Chams") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "FURENT_Chams"; hl.FillColor = Color3.fromRGB(138, 43, 226); hl.FillTransparency = 0.4; hl.OutlineColor = Color3.new(1,1,1)
                end
            end
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("FURENT_Chams") then p.Character.FURENT_Chams:Destroy() end
            end
        end
    end
end)

CreateToggle(TabVisuals, "2D Box ESP", function(state) Settings.ESP_Box = state end)
CreateToggle(TabVisuals, "Tracer ESP (Çizgi)", function(state) Settings.ESP_Tracer = state end)
CreateToggle(TabVisuals, "Player Chams (Duvar Arkası)", function(state) Settings.Chams = state end)

-- [7] PLAYER MODS
local PlayerSettings = { WalkSpeed = 16, JumpPower = 50, AntiVoid = false }
task.spawn(function()
    while task.wait(0.1) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = PlayerSettings.WalkSpeed
            LocalPlayer.Character.Humanoid.JumpPower = PlayerSettings.JumpPower
        end
    end
end)

CreateToggle(TabPlayer, "Speed Hack (Hız: 50)", function(state) PlayerSettings.WalkSpeed = state and 50 or 16 end)
CreateToggle(TabPlayer, "High Jump (Zıplama: 100)", function(state) PlayerSettings.JumpPower = state and 100 or 50 end)
CreateToggle(TabPlayer, "Fullbright (Karanlığı Aydınlat)", function(state) Lighting.GlobalShadows = not state; Lighting.Brightness = state and 3 or 1 end)

local AntiVoidPart
CreateToggle(TabPlayer, "Anti-Void (Düşmeyi Engelle)", function(state)
    if state then
        AntiVoidPart = Instance.new("Part", workspace); AntiVoidPart.Size = Vector3.new(5000, 5, 5000); AntiVoidPart.Position = Vector3.new(0, -30, 0)
        AntiVoidPart.Anchored = true; AntiVoidPart.Transparency = 0.5; AntiVoidPart.Color = Color3.fromRGB(138, 43, 226)
    else
        if AntiVoidPart then AntiVoidPart:Destroy() end
    end
end)

-- [8] AUTOFARM (Pet Sim 99 Temel Mantığı)
local AutoFarm_Active = false
CreateToggle(TabAutoFarm, "Auto-Farm (Coin/Sandıklara Işınlan)", function(state)
    AutoFarm_Active = state
    if state then
        task.spawn(function()
            while AutoFarm_Active do
                local target = nil
                local shortest = math.huge
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local myPos = LocalPlayer.Character.HumanoidRootPart.Position
                    -- En yakın objeyi bul
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and (obj.Name:find("Coin") or obj.Name:find("Chest") or obj.Name:find("Vault")) then
                            local part = obj:FindFirstChildWhichIsA("BasePart")
                            if part then
                                local dist = (part.Position - myPos).Magnitude
                                if dist < shortest then shortest = dist; target = part end
                            end
                        end
                    end
                    -- Işınlan
                    if target then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.5) -- Anti-Cheat koruması için bekleme
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- [9] MENÜYÜ AÇ/KAPAT (ÖZELLEŞTİRİLEBİLİR TUŞ)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == MenuKeybind then
        Main.Visible = not Main.Visible
    end
end)

print("FURENT_LSC Ultimate v19 Yüklendi!")
