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

local eventoArma = ReplicatedStorage:WaitForChild("AtualizarBatalha")
local eventoPontos = ReplicatedStorage:WaitForChild("AtualizarPerseguidoresMortos")

local GerenciadorArmas = {}

local armasAtivas = {}
local jogadoresArmados = {}

local function escolherCelulasArma(quantidade)
	local celulas = Dados.obterCelulasAbertas()
	local escolhidas = {}
	local posOcupadas = {}

	local posJogadores = {}
	for _, jogador in ipairs(Players:GetPlayers()) do
		local char = jogador.Character
		if char then
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then
				table.insert(posJogadores, root.Position)
			end
		end
	end
	-- Escuta os golpes vindos dos clientes
	table.sort(celulas, function(a, b)
		local distA, distB = math.huge, math.huge
		for _, pos in ipairs(posJogadores) do
			distA = math.min(distA, (a.posicao - pos).Magnitude)
			distB = math.min(distB, (b.posicao - pos).Magnitude)
		end
		return distA < distB
	end)	

	for _, cel in ipairs(celulas) do
		local distMin = math.huge
		for _, pos in ipairs(posJogadores) do
			distMin = math.min(distMin, (cel.posicao - pos).Magnitude)
		end

		if distMin >= 30 and distMin <= 80 then
			if Dados.posicaoEhValida(cel.posicao, posOcupadas, 8) then
				table.insert(escolhidas, cel)
				table.insert(posOcupadas, cel.posicao)
				if #escolhidas >= quantidade then break end
			end
		end
	end

	if #escolhidas == 0 then
		for _, cel in ipairs(celulas) do
			if Dados.posicaoEhValida(cel.posicao, posOcupadas, 8) then
				table.insert(escolhidas, cel)
				if #escolhidas >= quantidade then break end
			end
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
	while Dados.grid == nil do
		task.wait(0.1)
	end

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

		if clone.PrimaryPart then
			clone:SetPrimaryPartCFrame(CFrame.new(cel.posicao))
		else
			warn("[Armas] a espada não tem parte primaria colocada. vai la e coloca seu preguiçoso")
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

				local humanoid = personagem:FindFirstChildOfClass("Humanoid")
				if not humanoid then return end

				entrada.ocupada = true
				jogadoresArmados[jogador.UserId] = true

				local toolJogador = template:Clone()
				toolJogador.Parent = jogador.Backpack
				humanoid:EquipTool(toolJogador)

				local conexaoMorte
				conexaoMorte = humanoid.Died:Connect(function()
					GerenciadorArmas.desarmarJogador(jogador)
				end)

				eventoArma:FireClient(jogador, "armado", true)
				clone:Destroy()
				print("[Armas] " .. jogador.Name .. " roubou uma arma no chão eu acho")
			end)
		end
	end

	for _, jogador in ipairs(Players:GetPlayers()) do
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

	task.spawn(function()
		while #armasAtivas > 0 do
			atualizarSetas()
			task.wait(0.5)
		end
	end)

	print("[Armas] " .. #armasAtivas .. " armas criadas pelo o ar foi feito pelo ar que criou o ar que fez o ar que criou o ar que fez o ar que criou o ar que fez o ar que criou o ar e fez o ar.")
end

function GerenciadorArmas.desarmarJogador(jogador)
	jogadoresArmados[jogador.UserId] = nil

	local char = jogador.Character
	local toolChar = char and char:FindFirstChildOfClass("Tool")
	if toolChar then toolChar:Destroy() end

	local backpack = jogador:FindFirstChildOfClass("Backpack")
	local toolBackpack = backpack and backpack:FindFirstChildOfClass("Tool")
	if toolBackpack then toolBackpack:Destroy() end
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
		GerenciadorArmas.desarmarJogador(jogador)

		eventoPontos:FireAllClients(DadosPers.perseguidoresMortos, jogador.Name)

		eventoArma:FireClient(jogador, "armado", false)

		print("[Armas] " .. jogador.Name .. " esta sendo procurado por ter feito um crime de assasinato em um perseguidor. ainda resta " .. DadosPers.perseguidoresMortos .. " se tiver informação sobre esse homem. por favor abra esse script")
	end
end

function GerenciadorArmas.remover()
	for userId in pairs(jogadoresArmados) do
		local jogador = Players:GetPlayerByUserId(userId)
		if jogador then
			GerenciadorArmas.desarmarJogador(jogador)
		end
	end
	
	local pasta = workspace:FindFirstChild("ArmasAtivas")
	if pasta then
		pasta:Destroy()
	end
	armasAtivas = {}
	jogadoresArmados = {}
	
	for _, jogador in ipairs(Players:GetPlayers()) do
		eventoArma:FireClient(jogador, "removerSetas", true)
	end
	
	print("[Armas] foram deletados da existencia pelo ar que ce ja sabe.")
end

function GerenciadorArmas.estaArmado(userId)
	return jogadoresArmados[userId] == true
end

return GerenciadorArmas
