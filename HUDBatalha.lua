--> Declarações 				<--

local Players					= game:GetService("Players")
local ReplicatedStorage			= game:GetService("ReplicatedStorage")
local TweenService 				= game:GetService("TweenService")
local UserInputService			= game:GetService("UserInputService") -- NOVO

local player					= Players.LocalPlayer
local playerGui					= player:WaitForChild("PlayerGui")
local eventoArma				= ReplicatedStorage:WaitForChild("AtualizarBatalha")
local eventoPontos				= ReplicatedStorage:WaitForChild("AtualizarPerseguidoresMortos")
local golpeEvento				= ReplicatedStorage:WaitForChild("GolpeEspada")

--> Estado						<--

local estaArmado				= false
local posicaoArmaAlvo			= nil
local setaModel					= nil
local templateSeta				= ReplicatedStorage:WaitForChild("SetaBussula")

local TECLA_ATAQUE				= Enum.KeyCode.F

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if estaArmado and input.KeyCode == TECLA_ATAQUE then
		golpeEvento:FireServer()
	end
end)

local function criarSeta()
	if setaModel then setaModel:Destroy() end
	setaModel = templateSeta:Clone()
	setaModel.Parent = workspace
end

local function removerSeta()
	if setaModel then
		setaModel:Destroy()
		setaModel = nil
	end
end

task.spawn(function() -- < Loop que coloca e gira a seta na frente do usuario
	while true do
		task.wait(0.1)

		if setaModel and posicaoArmaAlvo and not estaArmado then
			local char = player.Character
			if char then
				local root		= char:FindFirstChild("HumanoidRootPart")
				if root then
					local frente  = root.CFrame.LookVector
					local posicao = root.Position + frente * 3 + Vector3.new(0, 1, 0)
					local direcao = (posicaoArmaAlvo - root.Position) * Vector3.new(1, 0 ,1)

					setaModel:SetPrimaryPartCFrame(
						CFrame.new(posicao) * CFrame.Angles(0, math.atan2(direcao.X, direcao.Z) + math.pi/2, 0)
					)
				end
			end
		elseif setaModel and (estaArmado or not posicaoArmaAlvo) then
			removerSeta()
		end
	end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScreenGui"
ScreenGui.Enabled = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local healthPlayer = Instance.new("Frame")
healthPlayer.Name = "healthPlayer"
healthPlayer.Position = UDim2.new(0.37321, 0, 0.0342506, 0)
healthPlayer.Size = UDim2.new(0.306247, 0, 0.07314, 0)
healthPlayer.BackgroundColor3 = Color3.new(0, 0, 0)
healthPlayer.BackgroundTransparency = 0.550000011920929
healthPlayer.BorderSizePixel = 0
healthPlayer.BorderColor3 = Color3.new(0, 0, 0)
healthPlayer.AnchorPoint = Vector2.new(0.5, 0.5)
healthPlayer.Transparency = 0.550000011920929
healthPlayer.Parent = ScreenGui

local icon = Instance.new("Frame")
icon.Name = "icon"
icon.Position = UDim2.new(-0.196751, 0, 0, 0)
icon.Size = UDim2.new(0.180505, 0, 1.80505, 0)
icon.BackgroundColor3 = Color3.new(0.784314, 1, 0.690196)
icon.BackgroundTransparency = 0.550000011920929
icon.BorderSizePixel = 0
icon.BorderColor3 = Color3.new(0, 0, 0)
icon.Transparency = 0.550000011920929
icon.Parent = healthPlayer

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint.Parent = icon

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "ImageLabel"
ImageLabel.Position = UDim2.new(0.08, 0, 0.08, 0)
ImageLabel.Size = UDim2.new(0.83, 0, 0.84, 0)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel.Transparency = 1
ImageLabel.Image = "rbxassetid://7992557358"
ImageLabel.Parent = icon

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = ImageLabel

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint3.AspectRatio = 10
UIAspectRatioConstraint3.Parent = healthPlayer

local bar = Instance.new("Frame")
bar.Name = "bar"
bar.Position = UDim2.new(0.0144404, 0, 0.108303, 0)
bar.Size = UDim2.new(0.971119, 0, 0.758123, 0)
bar.BackgroundColor3 = Color3.new(0, 220, 0)
bar.BorderSizePixel = 0
bar.BorderColor3 = Color3.new(0, 0, 0)
bar.Parent = healthPlayer

local healthTextBox = Instance.new("Frame")
healthTextBox.Name = "healthTextBox"
healthTextBox.Position = UDim2.new(0, 0, 1.11913, 0)
healthTextBox.Size = UDim2.new(0.259928, 0, 0.685921, 0)
healthTextBox.BackgroundColor3 = Color3.new(0, 0, 0)
healthTextBox.BackgroundTransparency = 0.550000011920929
healthTextBox.BorderSizePixel = 0
healthTextBox.BorderColor3 = Color3.new(0, 0, 0)
healthTextBox.Transparency = 0.550000011920929
healthTextBox.Parent = healthPlayer

local healthText = Instance.new("TextLabel")
healthText.Name = "healthText"
healthText.Position = UDim2.new(0.0555556, 0, 0, 0)
healthText.Size = UDim2.new(0.944444, 0, 1, 0)
healthText.BackgroundColor3 = Color3.new(1, 1, 1)
healthText.BackgroundTransparency = 1
healthText.BorderSizePixel = 0
healthText.BorderColor3 = Color3.new(0, 0, 0)
healthText.Transparency = 1
healthText.Text = "100 / 100"
healthText.TextColor3 = Color3.new(1, 1, 1)
healthText.TextSize = 14
healthText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
healthText.TextScaled = true
healthText.TextWrapped = true
healthText.TextXAlignment = Enum.TextXAlignment.Left
healthText.Parent = healthTextBox

local healthEnemy = Instance.new("Frame")
healthEnemy.Name = "healthEnemy"
healthEnemy.Position = UDim2.new(0.683234, 0, 0.0330153, 0)
healthEnemy.Size = UDim2.new(0.306247, 0, 0.07314, 0)
healthEnemy.BackgroundColor3 = Color3.new(0, 0, 0)
healthEnemy.BackgroundTransparency = 0.550000011920929
healthEnemy.BorderSizePixel = 0
healthEnemy.BorderColor3 = Color3.new(0, 0, 0)
healthEnemy.AnchorPoint = Vector2.new(0.5, 0.5)
healthEnemy.Transparency = 0.550000011920929
healthEnemy.Parent = ScreenGui

local icon2 = Instance.new("Frame")
icon2.Name = "icon"
icon2.Position = UDim2.new(1.01444, 0, 0, 0)
icon2.Size = UDim2.new(0.180505, 0, 1.80505, 0)
icon2.BackgroundColor3 = Color3.new(1, 0.54902, 0.54902)
icon2.BackgroundTransparency = 0.550000011920929
icon2.BorderSizePixel = 0
icon2.BorderColor3 = Color3.new(0, 0, 0)
icon2.Transparency = 0.550000011920929
icon2.Parent = healthEnemy

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint4.Parent = icon2

local ImageLabel2 = Instance.new("ImageLabel")
ImageLabel2.Name = "ImageLabel"
ImageLabel2.Position = UDim2.new(0.08, 0, 0.08, 0)
ImageLabel2.Size = UDim2.new(0.83, 0, 0.84, 0)
ImageLabel2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel2.BackgroundTransparency = 1
ImageLabel2.BorderSizePixel = 0
ImageLabel2.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel2.Transparency = 1
ImageLabel2.Image = "rbxassetid://93186828199597"
ImageLabel2.Parent = icon2

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = ImageLabel2

local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint6.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint6.AspectRatio = 10
UIAspectRatioConstraint6.Parent = healthEnemy

local bar2 = Instance.new("Frame")
bar2.Name = "bar"
bar2.Position = UDim2.new(0.0144404, 0, 0.108303, 0)
bar2.Size = UDim2.new(0.971119, 0, 0.758123, 0)
bar2.BackgroundColor3 = Color3.new(1, 0.317647, 0)
bar2.BorderSizePixel = 0
bar2.BorderColor3 = Color3.new(0, 0, 0)
bar2.Parent = healthEnemy

local healthTextBox2 = Instance.new("Frame")
healthTextBox2.Name = "healthTextBox"
healthTextBox2.Position = UDim2.new(0.740072, 0, 1.11913, 0)
healthTextBox2.Size = UDim2.new(0.259928, 0, 0.685921, 0)
healthTextBox2.BackgroundColor3 = Color3.new(0, 0, 0)
healthTextBox2.BackgroundTransparency = 0.550000011920929
healthTextBox2.BorderSizePixel = 0
healthTextBox2.BorderColor3 = Color3.new(0, 0, 0)
healthTextBox2.Transparency = 0.550000011920929
healthTextBox2.Parent = healthEnemy

local healthText2 = Instance.new("TextLabel")
healthText2.Name = "healthText"
healthText2.Size = UDim2.new(0.944444, 0, 1, 0)
healthText2.BackgroundColor3 = Color3.new(1, 1, 1)
healthText2.BackgroundTransparency = 1
healthText2.BorderSizePixel = 0
healthText2.BorderColor3 = Color3.new(0, 0, 0)
healthText2.Transparency = 1
healthText2.Text = "100 / 100"
healthText2.TextColor3 = Color3.new(1, 1, 1)
healthText2.TextSize = 14
healthText2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
healthText2.TextScaled = true
healthText2.TextWrapped = true
healthText2.TextXAlignment = Enum.TextXAlignment.Right
healthText2.Parent = healthTextBox2

local ko = Instance.new("ImageLabel")
ko.Name = "ko"
ko.Position = UDim2.new(0.533693, 0, 0.459184, 0)
ko.Size = UDim2.new(0.566038, 0, 0.283163, 0)
ko.BackgroundColor3 = Color3.new(1, 1, 1)
ko.BackgroundTransparency = 1
ko.BorderSizePixel = 0
ko.BorderColor3 = Color3.new(0, 0, 0)
ko.AnchorPoint = Vector2.new(0.5, 0.5)
ko.ImageTransparency = 0
ko.Image = "rbxassetid://2035407855"
ko.Parent = ScreenGui
ko.Visible = false

local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint7.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint7.AspectRatio = 2
UIAspectRatioConstraint7.Parent = ko


-- Cor de vida

local function corDaVida(progresso)
	if progresso < 0.5 then
		return Color3.fromRGB(math.floor(255 * (progresso * 2)), 220, 0)
	else
		return Color3.fromRGB(255, math.floor(220 * (1 - ( progresso - 0.5) * 2)), 0)
	end
end

local function atualizarVida()
	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
			local hum = char.Humanoid
			local escala = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
			TweenService:Create(bar, TweenInfo.new(0.3), {Size - UDim2.fromScale(escala, 1)}):Play()
	end
end

-- Verificar eventos

eventoArma.OnClientEvent:Connect(function(tipo, valor)
	if tipo == "seta" then
		posicaoArmaAlvo = valor
		if not estaArmado then criarSeta() end
		
	elseif tipo == "armado" then
		estaArmado = valor
		ScreenGui.Enabled = true

		if valor then
			removerSeta()
			task.spawn(function()
				while estaArmado do
					atualizarVida()
					task.wait(0.2)
				end
			end)
		end
	elseif tipo == "danoPerseguidor" then
		TweenService:Create(bar2,
			TweenInfo.new(0.2, Enum.EasingStyle.Sine),
			{ Size = UDim2.fromScale(valor, 1) }):Play()		
	
		elseif tipo == "removerSeta" then
			removerSeta()
			posicaoArmaAlvo = nil
		end
end)

-- Quando PerseguidoresMortos e atualizado. ele detecta isso e faz o "ko" aparecer.
eventoPontos.OnClientEvent:Connect(function(total, nomeQueMatou) 
	if nomeQueMatou == player.Name then
		TweenService:Create(bar2, TweenInfo.new(0.3), {Size = UDim2.fromScale(1, 1)}):Play()
		ko.Visible = true
		task.wait(3)
		ko.Visible = false
	end
end)
