-- ============================================================
-- SCRIPT: EfeitoVitrine
-- TIPO: Script normal
-- LOCAL: ServerScriptService
--
-- O QUE FAZ:
-- Quando uma arma spawna no labirinto, adiciona:
-- • Luz do chão iluminando a arma (igual ao spawn do jogador)
-- • Rotação suave da arma
-- • Brilho neon pulsando
-- • Tudo some ao ser coletada
-- ============================================================

local RunService					= game:GetService("RunService")
local ReplicatedStorage				= game:GetService("ReplicatedStorage")

--| ( Monitora a pasta ) |--


local function aplicarEfeito(arma)
	local primaryPart				= arma:FindFirstChild("Handle") or arma.PrimaryPart
	if not primaryPart then return end
	
	local cilindro = Instance.new("Part")
	cilindro.Name					= "LuzChao"
	cilindro.Shape					= Enum.PartType.Cylinder
	cilindro.Size					= Vector3.new(0.3, 5, 5)
	cilindro.Orientation			= Vector3.new(0, 0, 90)
	cilindro.Position				= primaryPart.Position - Vector3.new(0, 2.5, 0)
	cilindro.Anchored				= true
	cilindro.CanCollide				= false
	cilindro.Material				= Enum.Material.Neon
	cilindro.Color					= Color3.fromRGB(130, 255, 224)
	cilindro.Parent					= arma
	
	local luz						= Instance.new("PointLight")
	luz.Color 						= Color3.fromRGB(0, 99, 92)
	luz.Brightness					= 3
	luz.Range						= 16
	luz.Parent						= cilindro
	
	local particulas				= Instance.new("ParticleEmitter")
	particulas.Texture				= "rbxassetid://9826609769"
	particulas.Shape				= Enum.PartEmitterShape.Cylinder
	particulas.ShapeStyle			= Enum.PartEmitterShapeStyle.Volume
	particulas.EmissionDirection	= Enum.NormalId.Right
	particulas.Rate					= 30
	particulas.Speed				= NumberRange.new(1, 3)
	particulas.Lifetime				= NumberRange.new(1, 4)
	particulas.SpreadAngle			= Vector2.new(0, 0)
	particulas.Acceleration 		= Vector3.new(0, 8, 0)
	particulas.LightEmission		= 1
	particulas.LightInfluence		= 0
	particulas.Brightness			= 4
	particulas.Size					= NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.15),
		NumberSequenceKeypoint.new(0.2, 0.1),
		NumberSequenceKeypoint.new(1, 0),
	})
	particulas.Transparency			= NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})
	particulas.Color 				= ColorSequence.new(Color3.fromRGB(255, 220, 0))
	particulas.Parent				= cilindro
	primaryPart.Anchored			= true
	
	local anguloAtual = 0
	local posBase					= primaryPart.Position
	local conexao
	
	conexao = RunService.Heartbeat:Connect(function(dt)
		if not arma or not arma.Parent then conexao:Disconnect() return end
		
		anguloAtual = anguloAtual + 60 * dt
		primaryPart.CFrame = CFrame.new(posBase)
			* CFrame.Angles(0, math.rad(anguloAtual), 0)
	end)
	
	task.spawn(function()
		while arma and arma.Parent do
			luz.Brightness = 5
			task.wait(0.6)
			if not arma.Parent then break end
			luz.Brightness = 2
			task.wait(0.6)
		end
	end)
end

local function monitorarPasta(pasta)
	pasta.ChildAdded:Connect(function(filho)
		task.wait(0.1)
		aplicarEfeito(filho)
	end)
end

task.spawn(function()
	while true do
		local pasta = workspace:FindFirstChild("ArmasAtivas")
		if pasta then
			monitorarPasta(pasta)
			for _, filho in ipairs(pasta:GetChildren()) do
				aplicarEfeito(filho)
			end
			break
		end
		task.wait(1)
	end
end)
