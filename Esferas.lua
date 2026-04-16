local workspace = game.Workspace
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Dados = require(game.ReplicatedStorage:WaitForChild("DadosLabirinto"))

local eventoHUD = ReplicatedStorage:WaitForChild("AtualizarEsferas")

local LINHAS = 49
local COLUNAS = 49
local CELULA = 5

local TOTAL_ESFERAS = 20
local DISTANCIA_MINIMA = 3
local ALTURA_FLUTUACAO = 3
local VELOCIDADE_FLUTUAR = 0.8
local AMPLITUDE_FLUTUAR = 0.6

local grid
local offsetX
local offsetZ
local yChao

repeat
	task.wait(0.1)
	
	grid = Dados.grid
	offsetX = Dados.offsetX
	offsetZ = Dados.offsetZ
	yChao = Dados.yChao
until grid ~= nil and offsetX ~= nil and offsetZ ~= nil and yChao ~= nil

local celulasAbertas = {}

for l = 3, LINHAS - 2 do
	for c = 3, COLUNAS - 2 do
		if grid[l][c] == 1 then
			local naEntrada = (c <= 3 and l <= 5)
			local naSaida = (l >= LINHAS - 2 and c >= COLUNAS - 3)
			
			if not naEntrada and not naSaida then
				table.insert(celulasAbertas, {
					l = l,
					c = c
				})
			end
		end
	end
end

for i = #celulasAbertas, 2, -1 do
	local j = math.random(i)
	celulasAbertas[i], celulasAbertas[j] = celulasAbertas[j], celulasAbertas[i]
end

local function distanciaCelulas(a, b)
	return math.abs(a.l - b.l) + math.abs(a.c - b.c)
end

local posicoesEscolhidas = {}

for _, celula in ipairs(celulasAbertas) do
	if #posicoesEscolhidas >= TOTAL_ESFERAS then break end
	
	local podeUsar = true
	
	for _, escolhida in ipairs(posicoesEscolhidas) do
		if distanciaCelulas(celula, escolhida) < DISTANCIA_MINIMA then
			podeUsar = false
			break
		end
	end
	
	if podeUsar then
		table.insert(posicoesEscolhidas, celula)
	end
end

local pasta = workspace:WaitForChild("Labirinto")

local esferasAtivas = {}
local esferasTocadas = {}

local function criarEsfera(linha, coluna, indice)
	local x = (coluna - 1 + 0.5) * CELULA + offsetX
	local z = -(linha - 1) * CELULA + offsetZ
	local y = yChao + ALTURA_FLUTUACAO
	
	local posicaoAlvo = Vector3.new(x, y, z)
	
	local params = OverlapParams.new()
	params.FilterDescendantsInstances = {workspace:WaitForChild("Labirinto")}
	params.FilterType = Enum.RaycastFilterType.Include
	
	local partesNaParede = workspace:GetPartBoundsInBox(CFrame.new(posicaoAlvo), Vector3.new(2, 2, 2), params)
	
	if #partesNaParede == 0 then
		
		local esfera = Instance.new("Part")
		esfera.Name         = "Esfera_" .. indice
		esfera.Shape        = Enum.PartType.Ball
		esfera.Size         = Vector3.new(1.5, 1.5, 1.5)
		esfera.Position     = Vector3.new(x, y, z)
		esfera.Anchored     = true
		esfera.CanCollide   = false
		esfera.Material     = Enum.Material.Neon
		esfera.BrickColor   = BrickColor.new("Hot pink")
		esfera.CastShadow   = false
		esfera.Parent       = pasta
		
		local luz = Instance.new("PointLight")
		luz.Color = Color3.fromRGB(255, 0, 251)
		luz.Brightness = 6
		luz.Range = 14
		luz.Parent = esfera
		
		table.insert(esferasAtivas, {
			parte = esfera,
			baseY = y,
			offsetX = math.random() * math.pi * 2
		})
	else
		warn("[Esferas] Posição foi tirada na colsião da parede no ", linha, coluna)
	end
	
end

for i, pos in ipairs(posicoesEscolhidas) do
	criarEsfera(pos.l, pos.c, i)
end

esferasRestantes = #esferasAtivas
TOTAL_ESFERAS_REAL = #esferasAtivas
eventoHUD:FireAllClients(esferasRestantes, TOTAL_ESFERAS_REAL)

print("pronto tem ", #esferasAtivas, " pontos")

local esferasRestantes = #posicoesEscolhidas

local function aoTocar(esfera, outraParte)
	if esferasTocadas[esfera] then
		return
	end
	
	local personagem = outraParte.Parent
	if not personagem then
		return
	end
	
	local jogador = Players:GetPlayerFromCharacter(personagem)
	if not jogador then
		return
	end
	
	esferasTocadas[esfera] = true
	esferasRestantes -= 1
	
	for i, dados in ipairs(esferasAtivas) do
		if dados.parte == esfera then
			table.remove(esferasAtivas, i)
			break
		end
	end
	
	esfera:Destroy()
	
	eventoHUD:FireAllClients(esferasRestantes, TOTAL_ESFERAS)
	
	print("[Esferas] foi roubada por " .. jogador.Name .. ", por favor procure ele, restam" .. esferasRestantes .. ". por favor protegam elas antes delas serem roubadas")
	
end

for _, dados in ipairs(esferasAtivas) do
	dados.parte.Touched:Connect(function(outraParte)
		aoTocar(dados.parte, outraParte)
	end)
end

RunService.Heartbeat:Connect(function()
	local t = tick()
	
	for _, dados in ipairs(esferasAtivas) do
		if dados.parte and dados.par then
			local novoY = dados.baseY + math.sin(t + VELOCIDADE_FLUTUAR + dados.offset) * AMPLITUDE_FLUTUAR
			
			dados.parte.Position = Vector3.new(
				dados.parte.Position.X,
				novoY,
				dados.parte.Position.Z
			)
		end
	end
end)

print("[Esferas] criadas: " .. esferasRestantes)
