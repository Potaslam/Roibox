-- ROIBOX HUB | Full Script (Executor Compatible)

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Helper: get humanoid safely
local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ROIBOX_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 80)
main.Position = UDim2.new(0.05, 0, 0.35, 0)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

-- Gradient (compatible)
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new(
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 0)
)

-- Title
local title = Instance.new("TextButton", main)
title.Size = UDim2.new(1, 0, 0, 80)
title.BackgroundTransparency = 1
title.Text = "ROIBOX"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0, 255, 0)

-- Container
local container = Instance.new("Frame", main)
container.Position = UDim2.new(0, 0, 1, 0)
container.Size = UDim2.new(1, 0, 0, 0)
container.BackgroundTransparency = 1
container.ClipsDescendants = true

-- Button creator
local function createButton(text, order)
	local b = Instance.new("TextButton", container)
	b.Size = UDim2.new(1, -20, 0, 40)
	b.Position = UDim2.new(0, 10, 0, (order - 1) * 45)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.TextColor3 = Color3.fromRGB(0, 255, 0)
	b.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
	return b
end

-- Buttons
local speedBtn = createButton("SPEED [OFF]", 1)
local flyBtn = createButton("FLY [OFF]", 2)
local noclipBtn = createButton("NOCLIP [OFF]", 3)
local jumpBtn = createButton("SUPER JUMP [OFF]", 4)

-- States
local states = {
	speed = false,
	fly = false,
	noclip = false,
	jump = false
}

-- Toggle visual
local function toggle(btn, key)
	states[key] = not states[key]
	btn.Text = string.upper(key) .. (states[key] and " [ON]" or " [OFF]")

	TweenService:Create(
		btn,
		TweenInfo.new(0.25),
		{
			BackgroundColor3 = states[key]
				and Color3.fromRGB(0, 120, 0)
				or Color3.fromRGB(15, 15, 15)
		}
	):Play()
end

-- SPEED (FUNCIONAL)
speedBtn.MouseButton1Click:Connect(function()
	toggle(speedBtn, "speed")

	local humanoid = getHumanoid()
	if states.speed then
		humanoid.WalkSpeed = 40
	else
		humanoid.WalkSpeed = 16
	end
end)

-- SUPER JUMP (FUNCIONAL)
jumpBtn.MouseButton1Click:Connect(function()
	toggle(jumpBtn, "jump")

	local humanoid = getHumanoid()
	if states.jump then
		humanoid.JumpPower = 100
	else
		humanoid.JumpPower = 50
	end
end)

-- FLY (PLACEHOLDER – estructura lista)
flyBtn.MouseButton1Click:Connect(function()
	toggle(flyBtn, "fly")
	-- aquí iría la lógica de vuelo (intencionalmente no incluida)
end)

-- NOCLIP (PLACEHOLDER – estructura lista)
noclipBtn.MouseButton1Click:Connect(function()
	toggle(noclipBtn, "noclip")
	-- aquí iría la lógica de colisiones (intencionalmente no incluida)
end)

-- Expand / Collapse
local open = false
title.MouseButton1Click:Connect(function()
	open = not open
	TweenService:Create(
		container,
		TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			Size = open and UDim2.new(1, 0, 0, 190) or UDim2.new(1, 0, 0, 0)
		}
	):Play()
end)

-- Gradient animation
RunService.RenderStepped:Connect(function(dt)
	gradient.Rotation = (gradient.Rotation + 30 * dt) % 360
end)
