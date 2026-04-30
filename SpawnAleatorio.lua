-- ============================================================
-- SCRIPT: SpawnAleatorio
-- TIPO: Script normal (roda no SERVIDOR)
-- LOCAL: ServerScriptService
--
-- O QUE FAZ: Quando cada jogador entra na partida,
-- escolhe uma célula aberta aleatória do grid do labirinto
-- e teleporta o personagem para lá.
--
-- POR QUE SERVIDOR?
-- Mover personagens é uma ação física que precisa acontecer
-- no servidor. Se feito no cliente, o servidor não reconhece
-- a nova posição e o jogador "volta" para o spawn original.
-- ============================================================

--| ( Serviços ) |--

local Players		= game:GetService("Players")
local Dados			= require(game.ReplicatedStorage:WaitForChild("DadosLabirinto")) -- Exportando
while Dados.grid	== nil do
	task.wait(0.1) -- ate o grid estar disponivel
end

--| ( Configurações ) |--

local grid			= Dados.grid
local offsetX		= Dados.offsetX
local offsetZ		= Dados.offsetZ
local yChao			= Dados.yChao
local LINHAS		= Dados.LINHAS
local COLUNAS		= Dados.COLUNAS
local CELULA		= Dados.CELULA

math.randomseed(os.clock() * 1000) -- Multiplica por 1000 para transformar o tempo em um número inteiro e único.

-- os.clock(): Ele retorna o tempo decorrido, em segundos, 
-- desde que o ambiente Lua (o motor do Roblox) foi iniciado, com precisão de microssegundos.
-- Esse tempo é relativo ao computador/servidor onde o script está rodando. Se for um
-- LocalScript, é o tempo da máquina do jogador; se for um Script no servidor, 
-- é o tempo da máquina do servidor Roblox.

--| ( Coletar Celulas ) |--

local celulasAbertas = Dados.obterCelulasAbertas()

print("[SpawnAleatorio] " .. #celulasAbertas .. " ta disponivel no grid")

--| ( Função de Spawn ) |--

local function escolherPosicaoAleatoria()
	local indice = math.random(1, #celulasAbertas)
	return celulasAbertas[indice].posicao
end

--| ( Teleporte do Jogador ) |--

-- Recebe o jogador e move o personagem dele para uma
-- posição aleatória no labirinto.
--
-- Por que esperamos o personagem carregar?
-- Quando o jogador entra, o personagem ainda está sendo
-- montado pelo Roblox. Se tentarmos mover antes de existir,
-- o script quebra com erro de "nil".

local function teleportarJogador(jogador)
	
	-- Espera o personagem existir.
	-- jogador.Character → pega se já existir
	-- jogador.CharacterAdded:Wait() → espera se não existir
	
	local personagem = jogador.Character or jogador.CharacterAdded:Wait()
	local hrp = personagem:WaitForChild("HumanoidRootPart")
	
	if not Dados.spawnsJogadores[jogador.UserId] then
		local posicao = escolherPosicaoAleatoria()
		Dados.spawnsJogadores[jogador.UserId] = posicao
		
		-- Criar o marcador
		local marcador = Instance.new("Part")
		marcador.Name = "Checkpoint_" .. jogador.UserId
		marcador.Shape = Enum.PartType.Cylinder
		marcador.Size = Vector3.new(0.5, 4, 4)
		marcador.Position = posicao - Vector3.new(0, 2.9, 0)
		marcador.Orientation = Vector3.new(0, 0, 90)
		marcador.Anchored = true
		marcador.CanCollide = true
		marcador.Material = Enum.Material.Neon
		marcador.Color = Color3.fromRGB(146, 162, 255)
		marcador.Parent = workspace.Labirinto
		
		local luz = Instance.new("PointLight")
		luz.Color = Color3.fromRGB(146, 162, 255)
		luz.Range = 14
		luz.Brightness = 3
		luz.Parent = marcador
		
		local particulas = Instance.new("ParticleEmitter")
		particulas.Texture = "rbxassetid://14940094223"
		particulas.Shape = Enum.ParticleEmitterShape.Cylinder
		particulas.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
		particulas.EmissionDirection = Enum.NormalId.Right
		particulas.Rate = 40
		particulas.Speed = NumberRange.new(1, 3)
		particulas.Lifetime = NumberRange.new(1, 5)
		particulas.SpreadAngle = Vector2.new(0, 0)
		particulas.Acceleration = Vector3.new(0, 10, 0)
		particulas.Drag = 3
		particulas.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.12),
			NumberSequenceKeypoint.new(0.2, 0.08),
			NumberSequenceKeypoint.new(1, 0)
		})
		particulas.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.2),
			NumberSequenceKeypoint.new(1, 2)
		})
		particulas.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255))
		particulas.LightEmission = 1
		particulas.LightInfluence = 0
		particulas.Brightness = 5
		particulas.Parent = marcador
	end
	
	-- Escolhe a celula
	local posicao = Dados.spawnsJogadores[jogador.UserId]
	personagem:PivotTo(CFrame.new(posicao)) -- PivotTo() move o personagem inteiro (não só o HRP),
	
	print("[SpawnAleatorio] " .. jogador.Name .. " spawnando em: " .. tostring(posicao))
end

--| ( Detectando Jogadores ) |--

-- PlayerAdded dispara toda vez que um jogador entra.
-- CharacterAdded dispara toda vez que o personagem
-- deste jogador é criado — inclusive ao respawnar
-- após morrer. Assim o spawn aleatório funciona
-- em todas as vidas, não só na primeira.
Players.PlayerAdded:Connect(function(jogador)
	teleportarJogador(jogador)
	jogador.CharacterAdded:Connect(function()
		task.wait(0.5)
		teleportarJogador(jogador)
	end)
end)

-- ── JOGADORES JÁ CONECTADOS ─────────────────────────────────
-- PlayerAdded não detecta jogadores que já estavam
-- na partida quando o script carregou (raro em produção,
-- mas comum ao testar no Studio com Play Solo).
-- Este loop garante que ninguém fique de fora.

for _, jogador in ipairs(Players:GetPlayers()) do
	teleportarJogador(jogador)
end
