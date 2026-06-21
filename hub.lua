-- FURENT_LSC v33.0 - THE ABSOLUTE FINAL EDITION
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local OWNER_KEY = "FURENT-OWNER-KING"
local EXPIRE_DATE = os.time({year = 2026, month = 7, day = 12, hour = 23, min = 59, sec = 59})
local KeysString = "FURENT-A1B2-C3D4,FURENT-E5F6-G7H8,FURENT-I9J0-K1L2" -- Uzun listeyi kısalttım, istersen eskisiyle değiştirebilirsin.
local ValidKeys = string.split(KeysString, ",")

_G.ThemeColor = Color3.fromRGB(0, 255, 120)
_G.ThemeLists = { BGs = {}, Strokes = {}, Toggles = {}, Tabs = {} } -- Canlı renk güncelleme sistemi için liste

if _G.FurentConnections then
    for _, conn in pairs(_G.FurentConnections) do pcall(function() conn:Disconnect() end) end
end
_G.FurentConnections = {}
local function AddConnection(conn) table.insert(_G.FurentConnections, conn) end

pcall(function()
    local oldTarget = (gethui and gethui()) or CoreGui or LocalPlayer:FindFirstChild("PlayerGui")
    if oldTarget and oldTarget:FindFirstChild("FURENT_PRO_UI") then oldTarget.FURENT_PRO_UI:Destroy() end
    if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
    for _, v in pairs(workspace:GetDescendants()) do if v.Name == "F_RoomESP" or v.Name == "F_RoomESP_HL" then v:Destroy() end end
end)

local TargetGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FURENT_PRO_UI"; ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.Parent = TargetGui

local Blur = Instance.new("BlurEffect")
Blur.Name = "FURENT_Blur"; Blur.Size = 15; Blur.Enabled = true
pcall(function() Blur.Parent = Lighting end)

local DarkBg = Color3.fromRGB(12, 12, 16)
local LighterBg = Color3.fromRGB(20, 20, 25)

-- ==========================================
-- [ KEY SİSTEMİ ]
-- ==========================================
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 400, 0, 250); KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = DarkBg; KeyFrame.BackgroundTransparency = 0.05
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
local KeyStroke = Instance.new("UIStroke", KeyFrame); KeyStroke.Color = _G.ThemeColor; KeyStroke.Thickness = 2; KeyStroke.Transparency = 0.2

local KeyScale = Instance.new("UIScale", KeyFrame)
KeyScale.Scale = 0.8; TweenService:Create(KeyScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

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

-- ==========================================
-- [ ANA MENÜ ]
-- ==========================================
local function LoadMainUI()
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 750, 0, 520); Main.Position = UDim2.new(0.5, -375, 0.5, -260)
    Main.BackgroundColor3 = DarkBg; Main.BackgroundTransparency = 0.05
    Main.BorderSizePixel = 0; Main.Active = true; Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = _G.ThemeColor; MainStroke.Thickness = 2; MainStroke.Transparency = 0.2

    local MenuScale = Instance.new("UIScale", Main); MenuScale.Scale = 0.8
    TweenService:Create(MenuScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

    -- MENÜ GİZLEME TUŞ SİSTEMİ (Varsayılan: RightControl)
    local MenuKeybind = Enum.KeyCode.RightControl
    AddConnection(UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == MenuKeybind then
            Main.Visible = not Main.Visible
        end
    end))

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

    -- [YENİ] AVATAR VE OYUN SÜRESİ PANELİ
    local UserInfoFrame = Instance.new("Frame", Sidebar)
    UserInfoFrame.Size = UDim2.new(1, -20, 0, 50); UserInfoFrame.Position = UDim2.new(0, 10, 1, -60)
    UserInfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25); UserInfoFrame.BackgroundTransparency = 0.2
    Instance.new("UICorner", UserInfoFrame).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", UserInfoFrame).Color = Color3.fromRGB(50,50,60)
    
    local Avatar = Instance.new("ImageLabel", UserInfoFrame)
    Avatar.Size = UDim2.new(0, 36, 0, 36); Avatar.Position = UDim2.new(0, 7, 0, 7)
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
    Avatar.BackgroundTransparency = 1; Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
    
    local NameLbl = Instance.new("TextLabel", UserInfoFrame)
    NameLbl.Size = UDim2.new(1, -50, 0, 20); NameLbl.Position = UDim2.new(0, 50, 0, 5)
    NameLbl.Text = LocalPlayer.Name; NameLbl.TextColor3 = Color3.new(1,1,1); NameLbl.Font = Enum.Font.GothamBold; NameLbl.TextSize = 12; NameLbl.TextXAlignment = Enum.TextXAlignment.Left; NameLbl.BackgroundTransparency = 1

    local TimeLbl = Instance.new("TextLabel", UserInfoFrame)
    TimeLbl.Size = UDim2.new(1, -50, 0, 20); TimeLbl.Position = UDim2.new(0, 50, 0, 25)
    TimeLbl.Text = "00:00"; TimeLbl.TextColor3 = Color3.fromRGB(150, 150, 150); TimeLbl.Font = Enum.Font.Gotham; TimeLbl.TextSize = 11; TimeLbl.TextXAlignment = Enum.TextXAlignment.Left; TimeLbl.BackgroundTransparency = 1
    
    local SessionStart = os.time()
    task.spawn(function()
        while task.wait(1) do
            if TimeLbl then
                local s = os.time() - SessionStart
                TimeLbl.Text = string.format("Süre: %02d:%02d", math.floor(s/60), s%60)
            else break end
        end
    end)

    local TabContainer = Instance.new("Frame", Main)
    TabContainer.Size = UDim2.new(1, -190, 1, -20); TabContainer.Position = UDim2.new(0, 190, 0, 10); TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

    -- UI OLUŞTURMA FONKSİYONLARI VE CANLI RENK DESTEĞİ
    local function CreateTab(iconText, yPos, isActiveDefault)
        local TabBtn = Instance.new("TextButton", Sidebar); TabBtn.Size = UDim2.new(0, 160, 0, 36); TabBtn.Position = UDim2.new(0, 10, 0, yPos); TabBtn.Text = "  " .. iconText; TabBtn.TextColor3 = isActiveDefault and Color3.new(1,1,1) or Color3.fromRGB(150,150,150); TabBtn.BackgroundColor3 = isActiveDefault and _G.ThemeColor or Color3.fromRGB(15, 15, 20); TabBtn.BackgroundTransparency = isActiveDefault and 0.5 or 0.2; TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 14; TabBtn.TextXAlignment = Enum.TextXAlignment.Left; TabBtn.ZIndex = 3
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        local Stroke = Instance.new("UIStroke", TabBtn); Stroke.Color = _G.ThemeColor; Stroke.Transparency = isActiveDefault and 0 or 1
        
        local TabPage = Instance.new("ScrollingFrame", TabContainer); TabPage.Size = UDim2.new(1, 0, 1, 0); TabPage.BackgroundTransparency = 1; TabPage.ScrollBarThickness = 4; TabPage.ScrollBarImageColor3 = Color3.fromRGB(150,150,150); TabPage.Visible = isActiveDefault; TabPage.ZIndex = 3; TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local UIListLayout = Instance.new("UIListLayout", TabPage); UIListLayout.Padding = UDim.new(0, 12); UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        local tabData = {btn = TabBtn, stroke = Stroke, isActive = isActiveDefault, page = TabPage}
        table.insert(_G.ThemeLists.Tabs, tabData)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(_G.ThemeLists.Tabs) do 
                t.isActive = false; TweenService:Create(t.btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 15, 20), BackgroundTransparency = 0.2}):Play(); t.btn.TextColor3 = Color3.fromRGB(150,150,150); t.stroke.Transparency = 1; t.page.Visible = false 
            end
            tabData.isActive = true; TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor, BackgroundTransparency = 0.5}):Play(); TabBtn.TextColor3 = Color3.new(1,1,1); Stroke.Color = _G.ThemeColor; Stroke.Transparency = 0; TabPage.Visible = true
        end)
        return TabPage
    end

    local function CreateToggle(parent, text, callback)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 45); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50,50,60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
        local ToggleBtn = Instance.new("TextButton", Container); ToggleBtn.Size = UDim2.new(0, 44, 0, 22); ToggleBtn.Position = UDim2.new(1, -60, 0.5, -11); ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60); ToggleBtn.Text = ""; Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
        
        local toggleData = {btn = ToggleBtn, state = false}
        table.insert(_G.ThemeLists.Toggles, toggleData)

        ToggleBtn.MouseButton1Click:Connect(function() 
            toggleData.state = not toggleData.state; 
            TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = toggleData.state and _G.ThemeColor or Color3.fromRGB(50, 50, 60)}):Play(); 
            task.spawn(function() pcall(callback, toggleData.state) end) 
        end)
    end

    local function CreateButton(parent, text, callback)
        local Btn = Instance.new("TextButton", parent); Btn.Size = UDim2.new(1, -15, 0, 45); Btn.BackgroundColor3 = _G.ThemeColor; Btn.BackgroundTransparency = 0.5; Btn.Text = text; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 14; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
        table.insert(_G.ThemeLists.BGs, Btn)
        
        Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(1,1,1)}):Play() end)
        Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor}):Play() end)
        
        Btn.MouseButton1Click:Connect(function() 
            local btnTween = TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -25, 0, 40), Position = UDim2.new(0, 5, 0, 2)}); btnTween:Play(); btnTween.Completed:Wait(); TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -15, 0, 45), Position = UDim2.new(0, 0, 0, 0)}):Play()
            task.spawn(function() pcall(callback) end) 
        end)
    end

    local function CreateSlider(parent, text, min, max, default, callback)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 60); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50,50,60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(1, -20, 0, 20); Label.Position = UDim2.new(0, 15, 0, 10); Label.Text = text .. " : " .. default; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
        local SliderBG = Instance.new("Frame", Container); SliderBG.Size = UDim2.new(1, -30, 0, 8); SliderBG.Position = UDim2.new(0, 15, 0, 40); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50); Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)
        local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0); SliderFill.BackgroundColor3 = _G.ThemeColor; Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
        
        table.insert(_G.ThemeLists.BGs, SliderFill)
        
        local dragging = false
        SliderBG.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
        UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local relX = math.clamp((UserInputService:GetMouseLocation().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1); TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(relX, 0, 1, 0)}):Play(); local value = math.floor(min + (max - min) * relX); Label.Text = text .. " : " .. value; pcall(callback, value) end end)
    end

    local function CreateTextBox(parent, placeholder, callback)
        local TextBox = Instance.new("TextBox", parent); TextBox.Size = UDim2.new(1, -15, 0, 45); TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25); TextBox.PlaceholderText = placeholder; TextBox.Text = ""; TextBox.TextColor3 = Color3.new(1,1,1); TextBox.Font = Enum.Font.Gotham; TextBox.TextSize = 14
        Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)
        local TxtStroke = Instance.new("UIStroke", TextBox); TxtStroke.Color = _G.ThemeColor
        table.insert(_G.ThemeLists.Strokes, TxtStroke)
        TextBox.FocusLost:Connect(function() callback(TextBox.Text) end)
    end

    -- [YENİ] KLAVYE TUŞ ATAMA BUTONU OLUŞTURUCU
    local function CreateKeybind(parent, text, defaultKey, callback)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 45); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50,50,60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(0.8, 0, 1, 0); Label.Position = UDim2.new(0, 15, 0, 0); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
        local BindBtn = Instance.new("TextButton", Container); BindBtn.Size = UDim2.new(0, 100, 0, 26); BindBtn.Position = UDim2.new(1, -115, 0.5, -13); BindBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60); BindBtn.Text = defaultKey.Name; BindBtn.TextColor3 = Color3.new(1,1,1); BindBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", BindBtn).CornerRadius = UDim.new(0, 4)
        
        local listening = false
        BindBtn.MouseButton1Click:Connect(function()
            listening = true; BindBtn.Text = "Tuşa Bas..."
            TweenService:Create(BindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 50, 50)}):Play()
        end)
        
        AddConnection(UserInputService.InputBegan:Connect(function(input)
            if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                listening = false; BindBtn.Text = input.KeyCode.Name
                TweenService:Create(BindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
                callback(input.KeyCode)
            end
        end))
    end

    -- [YENİ] CANLI RENK GÜNCELLEYİCİ
    local function CreateColorPicker(parent, text)
        local Container = Instance.new("Frame", parent); Container.Size = UDim2.new(1, -15, 0, 110); Container.BackgroundColor3 = LighterBg; Container.BackgroundTransparency = 0.2; Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Color3.fromRGB(50, 50, 60)
        local Label = Instance.new("TextLabel", Container); Label.Size = UDim2.new(1, -60, 0, 20); Label.Position = UDim2.new(0, 15, 0, 10); Label.Text = text; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamSemibold; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.BackgroundTransparency = 1
        local PreviewBox = Instance.new("Frame", Container); PreviewBox.Size = UDim2.new(0, 30, 0, 30); PreviewBox.Position = UDim2.new(1, -45, 0, 5); PreviewBox.BackgroundColor3 = _G.ThemeColor; Instance.new("UICorner", PreviewBox).CornerRadius = UDim.new(0, 4)
        local currentColor = {R = _G.ThemeColor.R*255, G = _G.ThemeColor.G*255, B = _G.ThemeColor.B*255}
        
        local function UpdateColor() 
            _G.ThemeColor = Color3.fromRGB(currentColor.R, currentColor.G, currentColor.B)
            TweenService:Create(PreviewBox, TweenInfo.new(0.2), {BackgroundColor3 = _G.ThemeColor}):Play() 
            -- Diğer her şeyi canlı güncelle
            for _, bg in ipairs(_G.ThemeLists.BGs) do pcall(function() bg.BackgroundColor3 = _G.ThemeColor end) end
            for _, strk in ipairs(_G.ThemeLists.Strokes) do pcall(function() strk.Color = _G.ThemeColor end) end
            for _, tog in ipairs(_G.ThemeLists.Toggles) do if tog.state then pcall(function() tog.btn.BackgroundColor3 = _G.ThemeColor end) end end
            for _, tab in ipairs(_G.ThemeLists.Tabs) do if tab.isActive then pcall(function() tab.btn.BackgroundColor3 = _G.ThemeColor; tab.stroke.Color = _G.ThemeColor end) end end
        end

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
    local TabPlayer     = CreateTab("👤 Player", 120, false)
    local TabWorld      = CreateTab("🌍 World", 160, false)
    local TabTeleport   = CreateTab("📍 Teleport", 200, false)
    local TabAutoFarm   = CreateTab("⚡ AutoFarm", 240, false)
    local TabSkin       = CreateTab("🎭 Skin Changer", 280, false)
    local TabSettings   = CreateTab("⚙️ Settings", 320, false)

    -- [1] VISUALS (Öncekiyle aynı çalışan kusursuz hal)
    local VSettings = { Box = false, Tracer = false, RoomESP = false, Chams = false }
    local FurentESPInstances = {}

    local function ClearRoomESP()
        for _, inst in ipairs(FurentESPInstances) do pcall(function() if inst then inst:Destroy() end end) end
        table.clear(FurentESPInstances)
    end
    local function CreateBillboard(parent, text, color, offset)
        local bgui = Instance.new("BillboardGui"); bgui.Name = "F_RoomESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 250, 0, 50); bgui.StudsOffset = offset
        local lbl = Instance.new("TextLabel", bgui); lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = color; lbl.Font = Enum.Font.GothamBlack; lbl.TextSize = 18; lbl.TextStrokeTransparency = 0; bgui.Parent = parent
        table.insert(FurentESPInstances, bgui)
    end
    local function PerformScan()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local rawFound = {}; local count = 0; local descendants = workspace:GetDescendants()
        for i = 1, #descendants do
            local obj = descendants[i]; count = count + 1; if count % 5000 == 0 then task.wait() end 
            if obj and obj.Parent and obj:IsA("TextLabel") and (obj:FindFirstAncestorWhichIsA("BillboardGui") or obj:FindFirstAncestorWhichIsA("SurfaceGui")) then
                pcall(function()
                    local txt = string.lower(obj.Text)
                    if txt:find("x") or txt:find("şans") or txt:find("%%") then
                        local rootPart = obj:FindFirstAncestorWhichIsA("BasePart"); local model = obj:FindFirstAncestorWhichIsA("Model")
                        if model == workspace then model = rootPart end
                        if rootPart then table.insert(rawFound, {part = rootPart, model = model or rootPart, text = "🥚 " .. obj.Text, color = obj.TextColor3 or Color3.fromRGB(255, 215, 0), pos = rootPart.Position, dist = (rootPart.Position - hrp.Position).Magnitude}) end
                    end
                end)
            end
        end
        local clusteredData = {}
        for _, data in ipairs(rawFound) do
            local isDuplicate = false
            for _, c in ipairs(clusteredData) do if (c.pos - data.pos).Magnitude < 5 then isDuplicate = true; break end end
            if not isDuplicate then table.insert(clusteredData, data) end
        end
        table.sort(clusteredData, function(a, b) return a.dist < b.dist end); ClearRoomESP()
        local highlightCount = 0
        for _, data in ipairs(clusteredData) do
            CreateBillboard(data.part, data.text, data.color, Vector3.new(0, 6, 0)); highlightCount = highlightCount + 1
            if highlightCount <= 30 and data.model and data.model ~= workspace then
                pcall(function() local hl = Instance.new("Highlight"); hl.Name = "F_RoomESP_HL"; hl.FillColor = data.color; hl.OutlineColor = Color3.new(1, 1, 1); hl.FillTransparency = 0.4; hl.OutlineTransparency = 0.1; hl.Parent = data.model; table.insert(FurentESPInstances, hl) end)
            end
        end
    end
    local isScanning = false; local lastScanTick = 0
    task.spawn(function() while task.wait(1) do if VSettings.RoomESP and not isScanning then if tick() - lastScanTick >= 30 then isScanning = true; pcall(PerformScan); lastScanTick = tick(); isScanning = false end end end end)

    CreateToggle(TabVisuals, "2D Box ESP", function(s) VSettings.Box = s end)
    CreateToggle(TabVisuals, "Tracer ESP", function(s) VSettings.Tracer = s end)
    CreateToggle(TabVisuals, "Chams ESP", function(s) VSettings.Chams = s end)
    CreateToggle(TabVisuals, "Yumurta & Şifre ESP (Oda İçi)", function(s) VSettings.RoomESP = s; if s then lastScanTick = tick(); if not isScanning then isScanning = true; task.spawn(function() pcall(PerformScan); isScanning = false end) end else ClearRoomESP() end end)
    CreateButton(TabVisuals, "🔄 ESP Yazılarını Yenile", function() if not isScanning then isScanning = true; lastScanTick = tick(); pcall(PerformScan); isScanning = false end end)

    local DrawingSupported = pcall(function() local _ = Drawing.new("Line") end)
    local ESP_Boxes = {}; local ESP_Lines = {}
    AddConnection(RunService.RenderStepped:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    if VSettings.Chams then
                        local hl = player.Character:FindFirstChild("FurentChams")
                        if not hl then hl = Instance.new("Highlight"); hl.Name = "FurentChams"; hl.Parent = player.Character end
                        hl.FillColor = _G.ThemeColor; hl.OutlineColor = Color3.new(1,1,1); hl.FillTransparency = 0.5; hl.Enabled = true
                    elseif player.Character:FindFirstChild("FurentChams") then player.Character.FurentChams.Enabled = false end
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

    -- [2] PLAYER
    local PSettings = { Speed = 16, Jump = 50, Fly = false, FlySpeed = 50, Spider = false }
    CreateToggle(TabPlayer, "Fly (Uçma)", function(s) PSettings.Fly = s end)
    CreateSlider(TabPlayer, "Fly Hızı", 10, 300, 50, function(val) PSettings.FlySpeed = val end)
    CreateToggle(TabPlayer, "Spider (Duvara Tırmanma)", function(s) PSettings.Spider = s end)
    CreateSlider(TabPlayer, "Walk Speed", 16, 300, 16, function(val) PSettings.Speed = val end)
    CreateSlider(TabPlayer, "Jump Power", 50, 400, 50, function(val) PSettings.Jump = val end)
    task.spawn(function() while task.wait(0.1) do local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid"); if hum and not PSettings.Fly then hum.WalkSpeed = PSettings.Speed; hum.JumpPower = PSettings.Jump end end end)
    AddConnection(RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character; if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
        local hrp = char.HumanoidRootPart; local hum = char.Humanoid
        if PSettings.Fly then
            hum.PlatformStand = true; local camCFrame = workspace.CurrentCamera.CFrame; local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            if moveDir.Magnitude > 0 then hrp.Velocity = moveDir.Unit * PSettings.FlySpeed else hrp.Velocity = Vector3.new(0, 0, 0) end
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camCFrame.LookVector)
        else if hum.PlatformStand then hum.PlatformStand = false end end
        if PSettings.Spider and not PSettings.Fly then
            local result = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 3, RaycastParams.new())
            if result and UserInputService:IsKeyDown(Enum.KeyCode.W) then hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z) end
        end
    end))

    -- [3] WORLD & TELEPORT
    CreateSlider(TabWorld, "Yerçekimi", 0, 500, 196, function(val) workspace.Gravity = val end)
    CreateSlider(TabWorld, "Saat (Zaman)", 0, 24, 14, function(val) Lighting.ClockTime = val end)
    local TargetName = ""
    CreateTextBox(TabTeleport, "Işınlanılacak Oyuncu...", function(txt) TargetName = string.lower(txt) end)
    CreateButton(TabTeleport, "Işınlan", function() for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #TargetName) == TargetName and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3); break end end end)

    -- [4] AUTOFARM
    CreateToggle(TabAutoFarm, "Otomatik Tıklama", function(s) end)
    CreateToggle(TabAutoFarm, "Otomatik Toplama", function(s) end)
    CreateToggle(TabAutoFarm, "Otomatik Yumurta", function(s) end)

    -- [5] SKIN CHANGER
    CreateButton(TabSkin, "👻 Görünmez Ol (Invisibility)", function() if LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 1 elseif v:IsA("Decal") then v.Transparency = 1 end end end end)
    CreateButton(TabSkin, "✨ Parlat (ForceField)", function() if LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.ForceField end end end end)
    CreateButton(TabSkin, "🔄 Karakteri Sıfırla", function() if LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 0; v.Material = Enum.Material.Plastic elseif v:IsA("Decal") then v.Transparency = 0 end end end end)

    -- [6] SETTINGS (EKSİKSİZ VE CANLI)
    CreateColorPicker(TabSettings, "Arayüz Rengini Ayarla")
    
    CreateKeybind(TabSettings, "Menü Aç/Kapat Tuşu (Gizle)", MenuKeybind, function(newKey)
        MenuKeybind = newKey
    end)
    
    CreateButton(TabSettings, "❌ Arayüzü Tamamen Sil (Destroy)", function()
        ScreenGui:Destroy()
        if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
    end)
end

-- ==========================================
-- [ GİRİŞ SİSTEMİ BAŞLATICI ]
-- ==========================================
VerifyBtn.MouseButton1Click:Connect(function()
    if os.time() > EXPIRE_DATE then VerifyBtn.Text = "SÜRE DOLDU!"; TweenService:Create(VerifyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play(); return end
    local isValid = false
    if KeyInput.Text == OWNER_KEY then isValid = true else for _, key in ipairs(ValidKeys) do if key == KeyInput.Text then isValid = true; break end end end
    
    if isValid then
        VerifyBtn.Text = "GİRİŞ BAŞARILI!"; TweenService:Create(VerifyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 120)}):Play(); task.wait(0.6)
        local closeTween = TweenService:Create(KeyScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0}); closeTween:Play(); closeTween.Completed:Wait()
        KeyFrame.Visible = false; if Lighting:FindFirstChild("FURENT_Blur") then Lighting.FURENT_Blur:Destroy() end
        LoadMainUI()
    else
        VerifyBtn.Text = "HATALI ANAHTAR!"; TweenService:Create(VerifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        local originalPos = KeyFrame.Position
        for i = 1, 6 do KeyFrame.Position = originalPos + UDim2.new(0, math.random(-8, 8), 0, math.random(-8, 8)); task.wait(0.04) end
        KeyFrame.Position = originalPos; task.wait(1); VerifyBtn.Text = "GİRİŞ YAP"; TweenService:Create(VerifyBtn, TweenInfo.new(0.3), {BackgroundColor3 = _G.ThemeColor}):Play()
    end
end)
