local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local alertaEvent = ReplicatedStorage:WaitForChild("AlertaPerseguidor")
local Lighting = game:GetService("Lighting")

--| ( Criar o GUI ) | --

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GuiAlertaPerseguidor"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 0.12, 0)
frame.Position = UDim2.fromScale(0, 0.44)
frame.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Text = "⚠️ CUIDADO QUE OS BIXO TA VINDO ⚠️"
label.Parent = frame
label.Visible = false

local correcao = Instance.new("ColorCorrectionEffect")
correcao.TintColor = Color3.fromRGB(255, 74, 74)
correcao.Brightness = 0.1
correcao.Contrast = 0
correcao.Saturation = 0
correcao.Enabled = false
correcao.Parent = Lighting

--| ( Som ) |--

local somPerseguidor = SoundService:WaitForChild("AlertSound")
somPerseguidor.Looped = true

--| ( Exibição ) |--

local function mostrarAlerta(duracaoSegundo)
	--| Mostra a faixa vermelha na tela
	frame.BackgroundTransparency = 0.3
	label.Visible = true
	
	local tempoPassado = 0
	while tempoPassado < duracaoSegundo do
		frame.BackgroundTransparency = 0.1
		task.wait(0.4)
		frame.BackgroundTransparency = 0.7
		task.wait(0.4)
		tempoPassado = tempoPassado + 0.8
	end
	
	frame.BackgroundTransparency = 1
	label.Visible = false
	
	correcao.Enabled = true
	somPerseguidor:Play()
	task.spawn(function()
		while correcao.Enabled do
			correcao.Brightness = 0.03
			task.wait(1.5)
			correcao.Brightness = 0
			task.wait(1.5)
		end
	end)
end

local fimEvent = ReplicatedStorage:WaitForChild("FimPerseguidores")
fimEvent.OnClientEvent:Connect(function()
	correcao.Enabled = false
	correcao.Brightness = 0
	somPerseguidor:Stop()
end)

alertaEvent.OnClientEvent:Connect(mostrarAlerta)
