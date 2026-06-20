-- FURENT_LSC v24.0 - Full Content & Stabilized
local Players, RunService, UserInputService, Lighting, TeleportService, VirtualInputManager = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Lighting"), game:GetService("TeleportService"), game:GetService("VirtualInputManager")
local LocalPlayer, Camera, CoreGui = Players.LocalPlayer, workspace.CurrentCamera, game:GetService("CoreGui")

if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

local Main = Instance.new("Frame", Instance.new("ScreenGui", CoreGui))
Main.Name = "FURENT_PRO_UI"; Main.Size = UDim2.new(0, 680, 0, 480); Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0; Main.Active = true; Main.Draggable = true; Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- [1] FONKSİYONLAR (Kısa ve Güçlü)
local function Toggle(p, t, c) local btn = Instance.new("TextButton", p); btn.Size = UDim2.new(1, -10, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25); btn.Text = t; btn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6); local state = false; btn.MouseButton1Click:Connect(function() state = not state; btn.BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(20, 20, 25); c(state) end) end
local function Slider(p, t, min, max, d, c) local s = Instance.new("Frame", p); s.Size = UDim2.new(1, -10, 0, 40); s.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Instance.new("UICorner", s).CornerRadius = UDim.new(0, 6); local lbl = Instance.new("TextLabel", s); lbl.Text = t..": "..d; lbl.Size = UDim2.new(1,0,1,0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.new(1,1,1); s.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then local m = UserInputService:GetMouseLocation().X; local p_ = math.clamp((m - s.AbsolutePosition.X) / s.AbsoluteSize.X, 0, 1); c(math.floor(min + (max - min) * p_)); lbl.Text = t..": "..(math.floor(min + (max - min) * p_)) end end) end

-- [2] SEKMELER
local Sidebar = Instance.new("Frame", Main); Sidebar.Size = UDim2.new(0, 160, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
local TabContainer = Instance.new("Frame", Main); TabContainer.Size = UDim2.new(1, -170, 1, -20); TabContainer.Position = UDim2.new(0, 170, 0, 10); TabContainer.BackgroundTransparency = 1
local Tabs = {Visuals=Instance.new("ScrollingFrame", TabContainer), Player=Instance.new("ScrollingFrame", TabContainer), Teleport=Instance.new("ScrollingFrame", TabContainer), AutoFarm=Instance.new("ScrollingFrame", TabContainer), World=Instance.new("ScrollingFrame", TabContainer), Settings=Instance.new("ScrollingFrame", TabContainer)}
for n, t in pairs(Tabs) do t.Size = UDim2.new(1,0,1,0); t.BackgroundTransparency = 1; t.Visible = (n=="Visuals"); Instance.new("UIListLayout", t).Padding = UDim.new(0, 5) end

-- [3] MODÜLLER
local Settings = {Speed=30, Jump=75, Box=false, Chams=false, AutoFarm=false, AutoTap=false}

Toggle(Tabs.Visuals, "Box ESP", function(s) Settings.Box = s end)
Toggle(Tabs.Visuals, "Player Chams", function(s) Settings.Chams = s end)
Slider(Tabs.Player, "WalkSpeed", 30, 250, 30, function(v) Settings.Speed = v end)
Slider(Tabs.Player, "JumpPower", 75, 300, 75, function(v) Settings.Jump = v end)

task.spawn(function()
    while task.wait(0.1) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
            LocalPlayer.Character.Humanoid.JumpPower = Settings.Jump
        end
    end
end)

Toggle(Tabs.AutoFarm, "Smart Auto-Farm", function(s) Settings.AutoFarm = s; task.spawn(function()
    while Settings.AutoFarm do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("coin") or obj.Name:find("chest")) and not obj.Name:find("vip") then
                local p = obj:FindFirstChildWhichIsA("BasePart")
                if p then LocalPlayer.Character.HumanoidRootPart.CFrame = p.CFrame; task.wait(0.5) end
            end
        end
        task.wait(0.1)
    end
end) end)

Toggle(Tabs.AutoFarm, "1ms Auto Clicker", function(s) Settings.AutoTap = s; task.spawn(function()
    while Settings.AutoTap do
        VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, true, game, 1)
        VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, false, game, 1)
        task.wait(0.001)
    end
end) end)

-- [4] DÜNYA VE AYARLAR
Slider(Tabs.World, "Gravity", 0, 500, 196, function(v) workspace.Gravity = v end)
Toggle(Tabs.Settings, "FPS Boost", function(s) if s then for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end end end)

UserInputService.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible end end)
