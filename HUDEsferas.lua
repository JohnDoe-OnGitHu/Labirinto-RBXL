-- Serviços

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local ballsCount = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local picked = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local ballsGlobalCount = Instance.new("TextLabel")
local Fade = Instance.new("Frame")
local UIGradient_2 = Instance.new("UIGradient")

--Properties:

ScreenGui.Name = "HUDEsferas"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.332515448, 0, 0.0605296344, 0)
Main.Size = UDim2.new(0.334486127, 0, 0.126103401, 0)
Main.ZIndex = 2

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Main

TextLabel.Parent = Main
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0145129152, 0, 0.0399999991, 0)
TextLabel.Size = UDim2.new(0.246719554, 0, 0.319999993, 0)
TextLabel.Font = Enum.Font.Unknown
TextLabel.Text = "🔴 Esferas:"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

ballsCount.Name = "ballsCount"
ballsCount.Parent = Main
ballsCount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ballsCount.BackgroundTransparency = 1.000
ballsCount.BorderColor3 = Color3.fromRGB(0, 0, 0)
ballsCount.BorderSizePixel = 0
ballsCount.Position = UDim2.new(0.261232466, 0, 0.0399999991, 0)
ballsCount.Size = UDim2.new(0.246719554, 0, 0.319999993, 0)
ballsCount.Font = Enum.Font.SourceSansBold
ballsCount.Text = "?/?"
ballsCount.TextColor3 = Color3.fromRGB(0, 0, 0)
ballsCount.TextScaled = true
ballsCount.TextSize = 14.000
ballsCount.TextWrapped = true
ballsCount.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_2.Parent = Main
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.0253976006, 0, 0.5, 0)
TextLabel_2.Size = UDim2.new(0.170526758, 0, 0.319999993, 0)
TextLabel_2.Font = Enum.Font.Unknown
TextLabel_2.Text = "🙍Você:"
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 137, 137)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(223, 113, 113))}
UIGradient.Rotation = -90
UIGradient.Parent = Main

picked.Name = "picked"
picked.Parent = Main
picked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
picked.BackgroundTransparency = 1.000
picked.BorderColor3 = Color3.fromRGB(0, 0, 0)
picked.BorderSizePixel = 0
picked.Position = UDim2.new(0.195924357, 0, 0.5, 0)
picked.Size = UDim2.new(0.246719554, 0, 0.319999993, 0)
picked.Font = Enum.Font.SourceSansBold
picked.Text = "?"
picked.TextColor3 = Color3.fromRGB(0, 0, 0)
picked.TextScaled = true
picked.TextSize = 14.000
picked.TextWrapped = true
picked.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_3.Parent = Main
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.725645781, 0, 0, 0)
TextLabel_3.Size = UDim2.new(0.246719554, 0, 0.319999993, 0)
TextLabel_3.Font = Enum.Font.Unknown
TextLabel_3.Text = ":Global 🌐"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

ballsGlobalCount.Name = "ballsGlobalCount"
ballsGlobalCount.Parent = Main
ballsGlobalCount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ballsGlobalCount.BackgroundTransparency = 1.000
ballsGlobalCount.BorderColor3 = Color3.fromRGB(0, 0, 0)
ballsGlobalCount.BorderSizePixel = 0
ballsGlobalCount.Position = UDim2.new(0.478926212, 0, 0, 0)
ballsGlobalCount.Size = UDim2.new(0.246719554, 0, 0.319999993, 0)
ballsGlobalCount.Font = Enum.Font.SourceSansBold
ballsGlobalCount.Text = "?/?"
ballsGlobalCount.TextColor3 = Color3.fromRGB(0, 0, 0)
ballsGlobalCount.TextScaled = true
ballsGlobalCount.TextSize = 14.000
ballsGlobalCount.TextWrapped = true
ballsGlobalCount.TextXAlignment = Enum.TextXAlignment.Right

Fade.Name = "Fade"
Fade.Parent = ScreenGui
Fade.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fade.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fade.BorderSizePixel = 0
Fade.Position = UDim2.new(0.332515448, 0, 0.00488604512, 0)
Fade.Size = UDim2.new(0.334486127, 0, 0.0782698542, 0)

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 137, 137)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 60, 60))}
UIGradient_2.Rotation = -90
UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.44, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient_2.Parent = Fade

--task.spawn executa uma função imediatamente, a biblioteca task serve
-- para coordenar o tempo e a ordem de execução do código sem travar o sistema principal,
--mas em paralelo, para que o restante do script continue rodando sem esperar por ela.
-- ── Som de proximidade das esferas ───────────────────────────
-- task.spawn cria uma corrotina — roda em paralelo sem travar o resto do script
-- É como um funcionário separado que fica checando uma coisa em loop

task.spawn(function()
	local somProximidade = Instance.new("Sound")
	somProximidade.SoundId = "rbxassetid://139158676154751"
	somProximidade.Looped = true
	somProximidade.Volume = 0
	somProximidade.Parent = workspace
	
	while true do
		task.wait(1)
		
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		
		if hrp then
			local maisProximo = math.huge
			
			for _, esfera in ipairs(workspace.Labirinto:GetChildren()) do
				if esfera.Name:sub(1, 6) == "Esfera" then
					local dist = (hrp.Position - esfera.Position).Magnitude
					if dist < maisProximo then
						maisProximo = dist
					end
				end
			end
			
			if maisProximo < 20 then
				somProximidade.Volume = math.clamp(1 - (maisProximo / 20 ), 0, 1)
				if not somProximidade.IsPlaying then
					somProximidade:Play()
				end
			else
				somProximidade.Volume = 0
				somProximidade:Stop()
			end
		end
	end
end)

local eventoHUD = ReplicatedStorage:WaitForChild("AtualizarEsferas")
eventoHUD.OnClientEvent:Connect(function(restantes, total, quemColetou, quantosColetou)
	ballsGlobalCount.Text = restantes .. "/" .. total
	
	if quemColetou == player.UserId then
		picked.Text = quantosColetou
	end
end)
