-- FURENT_LSC v26.0 - KUSURSUZ FİNAL SÜRÜMÜ
local Players, RunService, UserInputService, Lighting, VirtualInputManager = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Lighting"), game:GetService("VirtualInputManager")
local LocalPlayer, Camera, CoreGui = Players.LocalPlayer, workspace.CurrentCamera, game:GetService("CoreGui")

if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

local Main = Instance.new("Frame", Instance.new("ScreenGui", CoreGui))
Main.Name = "FURENT_PRO_UI"; Main.Size = UDim2.new(0, 650, 0, 400); Main.Position = UDim2.new(0.5, -325, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0; Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- [UI Framework]
local Sidebar = Instance.new("Frame", Main); Sidebar.Size = UDim2.new(0, 160, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
local TabContainer = Instance.new("Frame", Main); TabContainer.Size = UDim2.new(1, -170, 1, -20); TabContainer.Position = UDim2.new(0, 170, 0, 10); TabContainer.BackgroundTransparency = 1
local function CreateTab(name, y)
    local btn = Instance.new("TextButton", Sidebar); btn.Size = UDim2.new(0, 140, 0, 35); btn.Position = UDim2.new(0, 10, 0, y); btn.Text = name; btn.TextColor3 = Color3.new(1,1,1); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35); Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local page = Instance.new("ScrollingFrame", TabContainer); page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = (y == 70); Instance.new("UIListLayout", page).Padding = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(function() for _,p in pairs(TabContainer:GetChildren()) do p.Visible = false end; page.Visible = true end)
    return page
end

local TabVisuals = CreateTab("Visuals", 70); local TabPlayer = CreateTab("Player Mods", 115); local TabTeleport = CreateTab("Teleport", 160); local TabAutoFarm = CreateTab("AutoFarm", 205); local TabWorld = CreateTab("World", 250); local TabSettings = CreateTab("Settings", 295)

-- [Fonksiyonlar]
local function Toggle(p, t, c) local b = Instance.new("TextButton", p); b.Size = UDim2.new(1, -10, 0, 35); b.BackgroundColor3 = Color3.fromRGB(20, 20, 25); b.Text = t; b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6); local s = false; b.MouseButton1Click:Connect(function() s = not s; b.BackgroundColor3 = s and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(20, 20, 25); c(s) end) end

-- [Modüller]
Toggle(TabVisuals, "2D Box ESP", function(s) _G.Box = s end)
Toggle(TabVisuals, "Player Chams", function(s) _G.Chams = s end)
Toggle(TabPlayer, "Speed (50)", function(s) _G.Speed = s and 50 or 16 end)
Toggle(TabAutoFarm, "Smart Auto-Farm", function(s) _G.AF = s end)
Toggle(TabAutoFarm, "Auto Tap (1ms)", function(s) _G.Tap = s end)

-- [Sistem Döngüleri]
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = _G.Speed or 16 end
    if _G.Tap then VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, true, game, 1); VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, false, game, 1) end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AF then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and (obj.Name:find("coin") or obj.Name:find("chest")) and not obj.Name:find("vip") then
                    local p = obj:FindFirstChildWhichIsA("BasePart")
                    if p and p.Transparency < 0.9 then LocalPlayer.Character.HumanoidRootPart.CFrame = p.CFrame; break end
                end
            end
        end
        if _G.Chams then
            for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("F_Chams") then local h = Instance.new("Highlight", p.Character); h.Name = "F_Chams"; h.FillColor = Color3.fromRGB(138, 43, 226) end end
        else for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("F_Chams") then p.Character.F_Chams:Destroy() end end end
    end
end)

UserInputService.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible end end)
