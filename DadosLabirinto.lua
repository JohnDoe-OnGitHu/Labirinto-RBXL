local Dados = {
	grid = nil,
	offsetX = nil,
	offsetZ = nil,
	yChao = nil,
	
	LINHAS = 49,
	COLUNAS = 49,
	CELULA = 5,
	ALTURA = 20,
	ESPESSURA = 5,
	
	-- Controle de Jogadores
	spawnsJogadores = {},
	checkpointsJogadores = {},
	ultimoCheckpoint = {},
	statusJogadores = {}
	
}

function Dados.obterCelulasAbertas()
	local celulas = {}
	
	if not Dados.grid then
		return celulas
	end
	
	local LINHAS = #Dados.grid
	local COLUNAS = #Dados.grid[1]
	local CELULA = Dados.CELULA
	
	for l = 2, LINHAS - 1 do
		for c = 2, COLUNAS - 1 do
			if Dados.grid[l][c] == 1 then
				local x = (c - 1) * CELULA + (CELULA / 2) + Dados.offsetX
				local z = -(l - 1) * CELULA + Dados.offsetZ
				local y = Dados.yChao + 3
				
				table.insert(celulas, {
					l = l,
					c = c,
					posicao = Vector3.new(x, y, z)
				})
			end
		end
	end
	
	return celulas
end

-- ── posicaoEhValida ──────────────────────────────────────────
-- Verifica se uma posição candidata está longe o suficiente
-- de todas as posições já ocupadas no mapa.
-- COMO FUNCIONA:
-- .Magnitude calcula a distância entre dois pontos Vector3.
-- É equivalente a medir com uma régua em linha reta no mundo 3D.
-- Se QUALQUER posição ocupada estiver mais perto que
-- distanciaMinima, rejeita imediatamente (return false).
-- Só retorna true se passar por TODAS sem ser rejeitado.
--
-- USO TÍPICO:
-- Garante que checkpoints, spawns e videntes não apareçam
-- aglomerados — cada item tem seu espaço no labirinto.
--===============================================================

function Dados.posicaoEhValida(novaPosicao, posicoesOcupadas, distanciasMinima)
	distanciasMinima = distanciasMinima or 25
	for _, pos in ipairs(posicoesOcupadas) do
		if (novaPosicao - pos).Magnitude < distanciasMinima then
			return false
		end
	end
	return true
end

--| ( Checkpoint ) |--

function Dados.ativarCheckpoint(userId, indice)
	local checkpoints = Dados.checkpointsJogadores[userId]
	if not checkpoints or not checkpoints[indice] then return end
	
	checkpoints[indice].ativado = true
	Dados.ultimoCheckpoint[userId] = checkpoints[indice].posicao
end

function Dados.posicaoRespawn(userId)
	return Dados.ultimoCheckpoint[userId] or Dados.spawnsJogadores[userId]
end

--| ( Status ) |--

function Dados.inicializarStatusJogador(userId)
	if not Dados.statusJogadores[userId] then
		Dados.statusJogadores[userId] = {
			esferasColetadas = 0,
			mudouStatus = false,
		}
	end
end

function Dados.coletarEsfera(userId)
	Dados.inicializarStatusJogador(userId)
	Dados.statusJogadores[userId].esferasColetadas += 1
	Dados.statusJogadores[userId].mudouStatus = true
end

function Dados.reativarCheckpointProximo(userId, posicaoAtual)
	local status = Dados.statusJogadores[userId]
	local checkpoints = Dados.checkpointsJogadore[userId]
	
	if not status or not status.mudouStatus or not checkpoints then
		return nil
	end
	
	local melhorIndice = nil
	local melhorDistancia = math.huge
	
	for i, cp in ipairs(checkpoints) do
		if cp.ativado then
			local dist = (posicaoAtual - cp.posicao).Magnitude
			if dist < melhorDistancia then
				melhorDistancia = dist
				melhorIndice = i
			end 
		end
	end
	
	if melhorIndice then
		checkpoints[melhorIndice].ativado = false
		status.mudouStatus = false
		return melhorIndice
	end
	
	status.mudouStatus = false
	return nil
end

return Dados
