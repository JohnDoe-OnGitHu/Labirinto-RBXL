-- ============================================================
-- SCRIPT: GerarCheckpoints
--
-- O QUE FAZ:
-- 1. Sorteia 6 posições únicas por jogador para checkpoints
-- 2. Salva as posições no DadosLabirinto
-- 3. Dispara um RemoteEvent para o cliente criar os visuais
--    (o visual é LOCAL — só o dono vê seus checkpoints)
-- 4. Detecta quando o jogador atravessa o checkpoint (via
--    RemoteEvent vindo do cliente) e salva o progresso
-- 5. Observa mudanças de status e reativa checkpoints
-- ============================================================

--| ( Serviços ) |--

local Players					= game:GetService("Players")
local ReplicatedStorage			= game:GetService("ReplicatedStorage")

--| > Dados
local Dados 					= require(ReplicatedStorage:WaitForChild("DadosLabirinto"))
while Dados.grid == nil do
	task.wait(0.1)
end
--| <

--| ( RemoteEvent ) |--
-- CriarCheckpoints: servidor → cliente (envia posições)
-- CheckpointAtivado: cliente → servidor (jogador atravessou)
-- ReativarCheckpoint: servidor → cliente (reativa visual)

local function obterOuCriarRemote(nome, tipo)
	local existente 			= ReplicatedStorage:FindFirstChild(nome)
	if existente then return existente end
	local novo 					= Instance.new(tipo)
	novo.Name					= nome
	novo.Parent 				= ReplicatedStorage
	return novo
end

local remoteCriar				= obterOuCriarRemote("CriarCheckpoints", "RemoteEvent")
local remoteAtivado				= obterOuCriarRemote("CheckpointAtivado", "RemoteEvent")
local remoteReativar 			= obterOuCriarRemote("ReativarCheckpoint", "RemoteEvent")

--| ( Configurações ) |--

local TOTAL_CHECKPOINTS 		= 8
local DISTANCIA_MINIMA			= 25 -- studs entre checkpoints e spawn

local function sortearCheckpoints(userId)
	local celulas 				= Dados.obterCelulasAbertas()
	local posicoes				= {}
	local resultados 			= {}

	if Dados.spawnsJogadores[userId] then
		table.insert(posicoes, Dados.spawnsJogadores[userId])
	end
	
	for i = #celulas, 2, -1 do
		local j = math.random(1, i)
		celulas[i], celulas[j] = celulas[j], celulas[i]
	end
	
	for _, celulas in ipairs(celulas) do
		if #resultados >= TOTAL_CHECKPOINTS then break end
		
		if Dados.posicaoEhValida(celulas.posicao, posicoes, DISTANCIA_MINIMA) then
			table.insert(posicoes, celulas.posicao)
			table.insert(resultados, {
				posicoes = celulas.posicao,
				ativado = false,
			})
		end
	end
	
	return resultados
end

--| ( Configurar Jogador ) |--

local function configurarJogador(jogador)
	local userId = jogador.UserId
	
	local tentativas = 0
	while not Dados.spawnsJogadores[userId] and tentativas < 50 do
		task.wait(0.1)
		tentativas += 1
	end
	
	if not Dados.checkpointsJogadores[userId] then
		Dados.checkpointsJogadores[userId] = sortearCheckpoints(userId)
		Dados.inicializarStatusJogador(userId)
		
		print("[GerarCheckpoints] " .. jogador.Name ..
			" recebeu " .. #Dados.checkpointsJogadores[userId] ..
			" checkpoints."
		)
	end
	
	local personagem = jogador.Character or jogador.CharacterAdded:Wait()
	personagem:WaitForChild("HumanoidRootPart")
	
	remoteCriar:FireClient(jogador, Dados.checkpointsJogadores[userId])
end
