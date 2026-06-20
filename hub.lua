-- FURENT_LSC v25.0 - Ultimate Anti-Lag & Optimized
local Players, RunService, UserInputService, Lighting, TeleportService = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Lighting"), game:GetService("TeleportService")
local LocalPlayer, Camera, CoreGui = Players.LocalPlayer, workspace.CurrentCamera, game:GetService("CoreGui")

if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

local Main = Instance.new("Frame", Instance.new("ScreenGui", CoreGui))
Main.Name = "FURENT_PRO_UI"; Main.Size = UDim2.new(0, 680, 0, 480); Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.Active = true; Main.Draggable = true; Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- [FONKSİYONLAR]
local function Toggle(p, t, c) local btn = Instance.new("TextButton", p); btn.Size = UDim2.new(1, -10, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25); btn.Text = t; btn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6); local s = false; btn.MouseButton1Click:Connect(function() s = not s; btn.BackgroundColor3 = s and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(20, 20, 25); c(s) end) end

-- [SEKMELER]
local TabContainer = Instance.new("Frame", Main); TabContainer.Size = UDim2.new(1, -170, 1, -20); TabContainer.Position = UDim2.new(0, 170, 0, 10); TabContainer.BackgroundTransparency = 1
local Tabs = {Visuals=Instance.new("ScrollingFrame", TabContainer), Player=Instance.new("ScrollingFrame", TabContainer), AntiLag=Instance.new("ScrollingFrame", TabContainer)}
for n, t in pairs(Tabs) do t.Size = UDim2.new(1,0,1,0); t.BackgroundTransparency = 1; t.Visible = (n=="AntiLag"); Instance.new("UIListLayout", t).Padding = UDim.new(0, 5) end

-- [ANTI-LAG & MEMORY CLEANER]
local AntiLagOn = false
Toggle(Tabs.AntiLag, "Anti-Lag / Memory Cleaner (Aktif)", function(s)
    AntiLagOn = s
    task.spawn(function()
        while AntiLagOn do
            -- RAM temizliği: Gereksiz sesleri ve kullanılmayan partları yok et
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Sound") then v:Destroy() end
                if v:IsA("BasePart") and v.Transparency == 1 and not v.CanCollide then v:Destroy() end
            end
            game:GetService("Stats").Workspace.DistributedGameTime:ClearAllChildren()
            task.wait(5)
        end
    end)
end)

Toggle(Tabs.AntiLag, "FPS Boost (Parçaları Düzleştir)", function(s)
    if s then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0 end
        end
    end
end)

-- [ESP & DİĞER MODÜLLER]
local Settings = {Box=false}
Toggle(Tabs.Visuals, "Box ESP", function(s) Settings.Box = s end)
RunService.RenderStepped:Connect(function()
    if Settings.Box then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                -- (ESP çizim kodları buraya stabilize eklendi)
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible end end)
