-- ============================================================
-- LocalScript: ControleEspada
-- TIPO: LocalScript
-- LOCAL: StarterPlayerScripts
--
-- O QUE FAZ:
-- Detecta quando o jogador está armado e clica com o mouse.
-- Verifica se há um perseguidor próximo e manda o golpe
-- para o servidor via RemoteEvent.
-- ============================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local eventoArma = ReplicatedStorage:WaitForChild("AtualizarBatalha")
local eventoGolpe = ReplicatedStorage:WaitForChild("GolpeEspada")

local estaArmado = false
local podeClicar = true
local COOLDOWN_GOLPE = 0.5
local RAIO_GOLPE = 15

eventoArma.OnClientEvent:Connect(function(tipo, valor)
	if tipo == "armado" then
		estaArmado = valor
	end
end)

-- Detecta Tecla F
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F and estaArmado and podeClicar then
		
		local char = player.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		
		local perseguidorAlvo = nil
		local menorDist = RAIO_GOLPE
		local pasta = workspace:FindFirstChild("HumanoidRootPart")
		if not pasta then return end
		
		for _, modelo in ipairs(pasta:GetChildren()) do
			local rootPers = modelo:FindFirstChild("HumanoidRootPart")
			local hum = modelo:FindFirstChildOfClass("Humanoid")
			if rootPers and hum and hum.Health > 0 then
				local dist = (root.Position - rootPers.Position).Magnitude
				if dist < menorDist then
					menorDist = dist
					perseguidorAlvo = modelo
				end
			end
		end
		
		if perseguidorAlvo then
			podeClicar = false
			eventoGolpe:FireServer(perseguidorAlvo)
			task.delay(COOLDOWN_GOLPE, function() podeClicar = true end)
		end
	end
end)
