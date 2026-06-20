-- FURENT_LSC v2.1 - Full Stable Version
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [GUI Tasarım]
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "FURENT_LSC_UI"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.Font = Enum.Font.GothamBold
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

-- [Hız Ayarları]
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", MainFrame)
SliderBG.Size = UDim2.new(0, 240, 0, 30); SliderBG.Position = UDim2.new(0, 20, 0, 70)
SliderBG.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
local SliderFill = Instance.new("Frame", SliderBG)
SliderFill.Size = UDim2.new(0, 50, 1, 0); SliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local relX = math.clamp(mousePos.X - SliderBG.AbsolutePosition.X, 0, SliderBG.AbsoluteSize.X)
        SliderFill.Size = UDim2.new(0, relX, 1, 0)
        WalkSpeed = 10 + (relX / SliderBG.AbsoluteSize.X) * 65
    end
end)

-- [ESP Mantığı]
local ESPEnabled = false
local function toggleESP()
    ESPEnabled = not ESPEnabled
    if not ESPEnabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "TracerLine" then obj:Destroy() end
        end
    end
end

-- [Güncelleme Döngüsü]
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
    
    if ESPEnabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj:IsA("Model") and (obj.Name:find("Coin") or obj.Name:find("Chest"))) and not obj:FindFirstChild("TracerLine") then
                local beam = Instance.new("Beam", obj); beam.Name = "TracerLine"
                local a0 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
                local a1 = Instance.new("Attachment", obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart)
                beam.Attachment0 = a0; beam.Attachment1 = a1
                beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
                beam.Width0 = 0.1; beam.Width1 = 0.1
            end
        end
    end
end)

-- [Menü Butonu]
local btn = Instance.new("TextButton", MainFrame)
btn.Size = UDim2.new(0, 240, 0, 40); btn.Position = UDim2.new(0, 20, 0, 120)
btn.Text = "Tracer ESP Toggle"; btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
btn.TextColor3 = Color3.new(1,1,1); btn.MouseButton1Click:Connect(toggleESP)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then MainFrame.Visible = not MainFrame.Visible end
end)
