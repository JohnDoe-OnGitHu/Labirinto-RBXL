local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Dados = require(game.ReplicatedStorage.DadosLabirinto)
local DadosPers = require(game.ReplicatedStorage.DadosPerseguidores)

local alertaEvent = ReplicatedStorage:WaitForChild("AlertaPerseguidor")

local Gerenciador = {}

local fimEvent = ReplicatedStorage:WaitForChild("FimPerseguidores")

local GerenciadorArmas = require(game.ServerScriptService.GerenciadorArmas)

--| ( Utilitários ) |--

local function escolherCelulasSpawn(quantidade)
	local celulas = Dados.obterCelulasAbertas()
	local escolhidas = {}
	local popOcupadas = {}

	for i = #celulas, 2, -1 do -- A sintaxe é: for variável = início, fim, passo do
		local j = math.random(1, i)
		celulas[i], celulas[j] = celulas[j], celulas[i]
	end
	
	for _, cel in ipairs(celulas) do
		if Dados.posicaoEhValida(cel.posicao, popOcupadas, 30) then
			table.insert(escolhidas, cel)
			table.insert(popOcupadas, cel.posicao)
			if #escolhidas >= quantidade then break end
		end
	end
	
	return escolhidas
end

local function jogadorMaisProximo(posicao, raio)
	local melhor = nil
	local melhorDist = raio
	
	for _, jogador in ipairs(Players:GetPlayers()) do
		local char = jogador.Character
		if char then
			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if root and hum and hum.Health > 0 then
				local dist = (posicao - root.Position).Magnitude
				if dist < melhorDist then
					melhorDist = dist
					melhor = jogador
				end
			end
		end
	end
	
	return melhor
end

local function aplicarDano(jogador)
	local char = jogador.Character
	if not char then return end
	local hum = char:FindFirstChild("Humanoid")
	if not hum then return end
	
	if GerenciadorArmas.estaArmado(jogador.UserId) then
		hum.Health = math.max(0, hum.Health - DadosPers.DANO_PERSEGUIDOR)
	else
		hum.Health = 0
	end
end

local function loopPerseguidor(entry, ondaAtiva_ref)
	local celulas = Dados.obterCelulasAbertas()
	local cfg = DadosPers
	
	while ondaAtiva_ref.ativo do
		if not entry.humanoid or entry.humanoid.Health <= 0 then break end
		
		local posAtual = entry.rootPart.Position
		local jogadorVisto = jogadorMaisProximo(posAtual, cfg.RAIO_DETECCAO)
		
		if jogadorVisto then
			entry.alvo = jogadorVisto
			entry.humanoid.WalkSpeed = cfg.VELOCIDADE_PERSEGUIR
			
			local charAlvo = jogadorVisto.Character
			if charAlvo then
				local rootAlvo = charAlvo:FindFirstChild("HumanoidRootPart")
				if rootAlvo then
					entry.humanoid:MoveTo(rootAlvo.Position)
					
					if (posAtual - rootAlvo.Position).Magnitude <= cfg.RAIO_DANO	 then
						aplicarDano(jogadorVisto)
						task.wait(1)
					end					
				end
			end
			
			task.wait(0.1)
		else
			entry.alvo = nil
			entry.humanoid.WalkSpeed = cfg.VELOCIDADE_PATRULHA
			
			if #celulas > 0 then
				local destino = celulas[math.random(1, #celulas)].posicao
				entry.humanoid:MoveTo(destino)
			end
			
			local t = 0
			while t < cfg.PASSO_PATRULHA and ondaAtiva_ref.ativo do
				task.wait(0.2)
				t = t + 0.2
			end
		end
	end
end

--| ( Spawnar Onda ) |--

local function spawnOnda()
	local cfg = DadosPers
	local template = ReplicatedStorage:FindFirstChild(cfg.NOME_MODEL_PERSEGUIDOR)
	
	if not template then
		warn("[Perseguidores] modelo '" .. cfg.NOME_MODEL_PERSEGUIDOR .. "' nao ta sendo encontrado. 400000 bounds se achar")
		return
	end
	
	local pasta = workspace:FindFirstChild(cfg.NOME_PASTA_ATIVOS)
		or (function()
			local p = Instance.new("Folder")
			p.Name = cfg.NOME_PASTA_ATIVOS
			p.Parent = workspace
			return p
		end)()
	
	local celulas = escolherCelulasSpawn(cfg.QUANTIDADE_PERSEGUIDORES)
	
	for _, cel in ipairs(celulas) do
		local clone = template:Clone()
		
		--[[ for _, s in ipairs(clone:GetDescendants()) do
			if s:IsA("Script") or s:IsA("LocalScript") then
				s.Disabled = true
			end
		end ]]--
		
		clone.Parent = pasta
		
		local root = clone:FindFirstChild("HumanoidRootPart")
		if root then
			root.CFrame = CFrame.new(cel.posicao)
		elseif clone.PrimaryPart then
			clone:SetPrimaryPartCFrame(CFrame.new(cel.posicao))
		end
		
		local humanoid = clone:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = cfg.VELOCIDADE_PATRULHA
		end
		
		local entry = { model = clone, humanoid = humanoid, rootPart = root, alvo = nil }
		DadosPers.registrar(clone, humanoid, root)
		
		local ondaRef = DadosPers._ondaRef
		task.spawn(loopPerseguidor, entry, ondaRef)
	end
end

--| ( Remover Onda ) |--
local function removerOnda()
	local pasta = workspace:FindFirstChild(DadosPers.NOME_PASTA_ATIVOS)
	if pasta then
		for _, filho in ipairs(pasta:GetChildren()) do
			filho:Destroy()
		end
	end
	DadosPers.limparLista()
end

--| ( Alertar ) |--

local function dispararAlerta(segundos)
	print("[Alerta] ta indo por " .. segundos .. " segundoes")
	alertaEvent:FireAllClients(segundos)
	task.wait(segundos)
end

--| ( Ciclo ) |--

function Gerenciador.iniciar()
	local cfg = DadosPers
	
	task.spawn(function()
		while true do
			task.wait(cfg.INTEVALO_ENTRE_ONDAS)
			
			dispararAlerta(cfg.TEMPO_ALERTA)
			
			cfg._ondaRef = { ativo = true }
			cfg.ondaAtiva = true
			spawnOnda()
			
			task.wait(cfg.DURACAO_ONDA)
			cfg._ondaRef.ativo = false
			cfg.ondaAtiva = false
			removerOnda()
			GerenciadorArmas.remover()
			fimEvent:FireAllClients()
		end
	end)
end

return Gerenciador
