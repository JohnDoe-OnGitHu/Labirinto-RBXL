local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Dados = require(game.ReplicatedStorage.DadosLabirinto)
local DadosPers = require(game.ReplicatedStorage.DadosPerseguidores)

local alertaEvent = ReplicatedStorage:WaitForChild("AlertaPerseguidor")

local Gerenciador = {}

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
