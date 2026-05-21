-- ============================================================
-- MODULE: GerenciadorArmas
-- TIPO: ModuleScript
-- LOCAL: ServerScriptService
--
-- O QUE FAZ:
-- Spawna armas aleatoriamente no labirinto antes de cada onda
-- de perseguidores. Controla quem pegou a arma, atualiza a
-- seta bússola nos clientes e remove as armas no fim da onda.
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Dados = require(ReplicatedStorage.DadosLabirinto)
local DadosPers = require(ReplicatedStorage.DadosPerseguidores)

local eventoArma = ReplicatedStorage.WaitForChild("AtualizarBatalha")
local eventoPontos = ReplicatedStorage.WaitForChild("AtualizarPerseguidoresMortos")

local GerenciadorArmas = {}

local armasAtivas = {}
local jogadores = {}

local function escolherCelulasArma(quantidade)
	local celulas = Dados.obterCelulasAbertas()
	local escolhidas = {}
	local posOcupadas = {}
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
	local mouse = player:GetMouse()
	
	local eventoArma = ReplicatedStorage:WaitForChild("AtualizarBatalha")
	local eventoGolpe = ReplicatedStorage:WaitForChild("GolpeEspada")
	
	-- Escuta os golpes vindos dos clientes
	eventoGolpe.OnServerEvent:Connect(function(jogador, perseguidor)
		GerenciadorArmas.registrarGolpe(jogador, perseguidor)
	end)
	
	local estaArmado = false
	local podeClicar = true
	local COOLDOWN_GOLPE = 0.5
	local RAIO_GOLPE = 15
	
	eventoArma.OnClientEvent:Connect(function()
		if not estaArmado then return end
		if not podeClicar then return end
		
		local char = player.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		
		local perseguidorAlvo = nil
		local menorDist = RAIO_GOLPE
		
		local pasta = workspace:FindFirstChild("PerseguidoresAtivos")
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
		
		if not perseguidorAlvo then return end
		
		podeClicar = false
		task.delay(COOLDOWN_GOLPE, function()
			podeClicar = true
		end)
		
		eventoGolpe:FireServer(perseguidorAlvo)
		
		print("[Espada] foi massacrado no triste " .. perseguidorAlvo.Name)
	end)
	
	for _, entry in ipairs(DadosPers.obterAtivos()) do
		if entry.rootPart then
			table.insert(posOcupadas, entry.rootPart.Position)
		end
	end
	
	for i = #celulas, 2, -1 do
		local j = math.random(1, i)
		celulas[i], celulas[j] = celulas[j], celulas[i]
	end
end
