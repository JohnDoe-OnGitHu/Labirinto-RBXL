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
local jogadoresArmados = {}

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

	for _, cel in ipairs(celulas) do
		if Dados.posicaoEhValida(cel.posicao, posOcupadas, 40) then
			table.insert(escolhidas, cel)
			table.insert(posOcupadas, cel.posicao)
			if #escolhidas >= quantidade then break end
		end
	end

	return escolhidas
end

local function armaMaisProxima(posicao)
	local melhor = nil
	local melhorDist = math.huge

	for _, arma in ipairs(armasAtivas) do
		if not arma.ocupada then
			local dist = (posicao - arma.posicao).Magnitude
			if dist < melhorDist then
				melhorDist = dist
				melhor = arma
			end
		end
	end

	return melhor
end

local function atualizarSetas()
	for _, jogador in ipairs(Players:GetPlayers()) do
		if not jogadoresArmados[jogador.UserId] then
			local char = jogador.Character
			if char then
				local root = char:FindFirstChild("HumanoidRootPart")
				if root then
					local arma = armaMaisProxima(root.Position)
					if arma then
						eventoArma:FireClient(jogador, "seta", arma.posicao)
					end
				end
			end
		end
	end
end

--| ( Spawn das armas ) |--

function GerenciadorArmas.spawnar()
	local template = ReplicatedStorage:FindFirstChild(DadosPers.NOME_MODEL_ARMA)
	if not template then
		warn("[Arma] ou como pode se chamar " .. DadosPers.NOME_MODEL_ARMA .. " esta perdido. ultimo encontrado em ReplicatedStorage. se tiver alguma informação. abre esse codigo.")
		return
	end

	local pasta = workspace:FindFirstChild("ArmasAtivas")
		or (function()
			local p = Instance.new("Folder")
			p.Name = "ArmasAtivas"
			p.Parent = workspace
			return p
		end)()

	local quantidade = math.max(1, #Players:GetPlayers())
	local celulas = escolherCelulasArma(quantidade)

	for _, cel in ipairs(celulas) do
		local clone = template:Clone()
		
		for _, s in ipairs(clone:GetDescendants()) do
			if s:IsA("Script") or s:IsA("LocalScript") then
				s.Disabled = true
			end
		end

		clone.Parent = pasta

		local root = clone:FindFirstChild("HumanoidRootPart") or clone.PrimaryPart
		if root then
			root.CFrame = CFrame.new(cel.posicao)
		elseif clone.PrimaryPart then
			clone:SetPrimaryPartCFrame(CFrame.new(cel.posicao))
		end

		for _, parte in ipairs(clone:GetDescendents()) do
			if parte:IsA("BasePart") then
				parte.Material = Enum.Material.Neon
			end
		end

		local entrada = { model = clone, posicao = cel.posicao, ocupada = false }
		table.insert(armasAtivas, entrada)

		clone.PrimaryPart = clone.PrimaryPart or clone:FindFirstChildOfClass("BasePart")
		if clone.PrimaryPart then
			clone.PrimaryPart.Touched:Connect(function(outraParte)
				local personagem = outraParte.Parent
				local jogador = Players:GetPlayerFromCharacter(personagem)
				if not jogador then return end
				if jogadoresArmados[jogador.UserId] then return end
				if entrada.ocupada then return end
				entrada.ocupada = true
				jogadoresArmados[jogador.UserId] = true
				eventoArma:FireClient(jogador, "armado", true)
				clone:Destroy()
				print("[Armas] " .. jogador.Name .. " roubou uma arma no chão eu acho")
			end)
		end
	end
	
	task.spawn(function()
		while #armasAtivadas > 0 do
			atualizarSetas()
			task.wait(0.5)
		end
	end)
	
	print("[Armas] " .. #armasAtivas .. " armas criadas pelo o ar foi feito pelo ar que criou o ar que fez o ar que criou o ar que fez o ar que criou o ar que fez o ar que criou o ar e fez o ar.")
end

function GerenciadorArmas.registrarGolpe(jogador, perseguidor)
	if not jogadoresArmados[jogador.User] then return end
	
	local char = jogador.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	
	local rootPers = perseguidor:FindFirstChild("HumanoidRootPart")
	if not rootPers then return end
	
	if (root.Position - rootPers.Position).Magnitude > 15 then return end
	
	local hum = perseguidor:FindFirstChild("Humanoid")
	if not hum then return end
	
	local danoGolpe = hum.MaxHealth / DadosPers.GOLPES_PARA_MATAR
	hum.Health = math.max(0, hum.Health - danoGolpe)
	
	local progresso = 1 - (hum.Health / hum.MaxHealth)
	eventoArma:FireClient(jogador, "danoPerseguidor", progresso)
	
	if hum.Health <= 0 then
		DadosPers.perseguidoresMortos += 1
		jogadoresArmados[jogador.UserId] = false
		
		eventoPontos:FireAllClients(DadosPers.perseguidoresMortos, jogador.Name)
		
		eventoArma:FireClient(jogador, "armado", false)
		
		print("[Armas] " .. jogador.Name .. " esta sendo procurado por ter feito um crime de assasinato em um perseguidor. ainda resta " .. DadosPers.perseguidoresMortos .. " se tiver informação sobre esse homem. por favor abra esse script")
	end
end

function GerenciadorArmas.remover()
	local pasta = workspace:FindFirstChild("ArmasAtivas")
	if pasta then
		pasta:Destroy()
	end
	armasAtivas = {}
	jogadoresArmados = {}
	print("[Armas] foram deletados da existencia pelo ar que ce ja sabe.")
end

function GerenciadorArmas.estaArmado(userId)
	return jogadoresArmados[userId] == true
end

return GerenciadorArmas
