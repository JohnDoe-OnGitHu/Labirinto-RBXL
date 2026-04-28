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

return Dados

