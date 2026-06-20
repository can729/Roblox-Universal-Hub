-- FURENT_LSC v4.0 - Advanced Module Hub
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [GUI Setup]
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")); ScreenGui.Name = "FURENT_LSC_UI"
local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 300, 0, 500); MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Draggable = true; MainFrame.Active = true

-- [Modül Yönetimi]
local Settings = {Speed = 16, Jump = 50, ESP = false, Noclip = false, Fly = false}

local function CreateButton(text, parent, callback)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(0, 280, 0, 35); btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.new(1,1,1); btn.MouseButton1Click:Connect(callback)
end

-- [Movement Engine]
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local H = LocalPlayer.Character.Humanoid
        H.WalkSpeed = Settings.Speed
        H.JumpPower = Settings.Jump
        if Settings.Noclip then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
        end
    end
end)

-- [ESP Module (Highlight Based)]
local function ToggleESP()
    Settings.ESP = not Settings.ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if Settings.ESP then
                local h = Instance.new("Highlight", p.Character); h.Name = "ESP_Box"
                h.FillColor = Color3.fromRGB(0, 255, 255); h.OutlineColor = Color3.new(1,1,1)
            else
                if p.Character:FindFirstChild("ESP_Box") then p.Character.ESP_Box:Destroy() end
            end
        end
    end
end

-- [Menü Yapılandırması]
CreateButton("Toggle ESP (Box/Chams)", MainFrame, ToggleESP)
CreateButton("Noclip: " .. (Settings.Noclip and "ON" or "OFF"), MainFrame, function() Settings.Noclip = not Settings.Noclip end)
CreateButton("Speed 50", MainFrame, function() Settings.Speed = 50 end)
CreateButton("Speed 100", MainFrame, function() Settings.Speed = 100 end)
CreateButton("Reset Speed", MainFrame, function() Settings.Speed = 16 end)
CreateButton("Infinite Jump", MainFrame, function() 
    UserInputService.JumpRequest:Connect(function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
end)

UserInputService.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.RightShift then MainFrame.Visible = not MainFrame.Visible end end)
