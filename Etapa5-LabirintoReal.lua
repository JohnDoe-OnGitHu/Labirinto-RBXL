local workspace = game.Workspace

local pasta = workspace:FindFirstChild("Labirinto") or Instance.new("Folder", workspace)
pasta.Name = "Labirinto"

-- |-- Configurações --| --

local LINHAS = 15
local COLUNAS = 15
local CELULA = 5
local ALTURA = 10
local ESPESSURA = 5
local yChao = 0

-- |-- Matriz --| --

local grid = {}
for l = 1, LINHAS do
	grid[l] = {}
	for c = 1, COLUNAS do
		grid[l][c] = 0
	end
end

-- |-- Verificar se Celula existe no grid --| --

local function dentro(l, c)
	return l > 0 and l <= LINHAS and c > 0 and c <= COLUNAS
end

-- |-- Vizinhos --| --

local function vizinhos2(l, c)
	return {
		{l-2, c, l-1, c }, -- ⬆️
		{l+2, c, l+1, c }, -- ⬇️
		{l, c-2, l, c-1}, -- ⬅️
		{l, c+2, l, c+1}  -- ➡️
	}
end

-- |-- Loop do Prim --| --

math.randomseed(12345)
local fronteira = {}

local function adicionarFronteira(l, c)
	for _, v in ipairs(vizinhos2(l, c)) do
		local nl, nc = v[1], v[2]
		if dentro(nl, nc) and grid[nl][nc] == 0 then
			table.insert(fronteira, {nl, nc, l, c})
		end
	end
end

-- |-- Passo Inicial --| --

local startL, startC = 2, 2
grid[startL][startC] = 1
adicionarFronteira(startL, startC)

while #fronteira > 0 do
	local idx = math.random(#fronteira)
	local f = table.remove(fronteira, idx)
	local l, c, pl, pc = f[1], f[2], f[3], f[4]
	
	if grid[l][c] == 0 then
		grid[l][c] = 1
		grid[(l+pl)//2][(c+pc)//2] = 1
		adicionarFronteira(l, c)
	end
end

-- |-- Entrada e Saida --| --
grid[1][2] = 1
grid[2][2] = 1
grid[LINHAS][COLUNAS - 1] = 1

local totalParts = 0

for l = 1, LINHAS do
	local inicio = nil
	
	for c = 1, COLUNAS do
		if grid[l][c] == 0 then
			if not inicio then inicio = c end
		else
			if inicio then
				local tamanho = c - inicio
				local centroX = ((inicio - 1) + tamanho / 2) * CELULA
				local centroZ = -(l - 1) * CELULA - CELULA / 2
				
				local p = Instance.new("Part")
				p.Size = Vector3.new(tamanho * CELULA, ALTURA, ESPESSURA)
				p.Position = Vector3.new(centroX, yChao + ALTURA / 2, centroZ)
				p.Anchored = true
				p.Material = Enum.Material.Concrete
				p.BrickColor = BrickColor.new("Medium stone grey")
				p.Parent = pasta
					
				totalParts = totalParts + 1
				inicio = nil
			end
		end
	end

	if inicio then
		local tamanho = COLUNAS - inicio + 1
		local centroX = ((inicio - 1) + tamanho / 2) * CELULA
		local centroZ = -(l - 1) * CELULA - CELULA / 2
		
		local p = Instance.new("Part")
		p.Size = Vector3.new(tamanho * CELULA, ALTURA, ESPESSURA)
		p.Position = Vector3.new(centroX, yChao + ALTURA / 2, centroZ)
		p.Anchored = true
		p.Material = Enum.Material.Concrete
		p.BrickColor = BrickColor.new("Medium stone grey")
		p.Parent = pasta
		
		totalParts = totalParts + 1
	end
end

local chao = Instance.new("Part")
chao.Size = Vector3.new(COLUNAS * CELULA, 1, LINHAS * CELULA)
chao.Position = Vector3.new(
	(COLUNAS / 2) * CELULA,
	yChao - 0.2,
	-(LINHAS / 2) * CELULA - CELULA / 2
)
chao.Anchored = true
chao.Material = Enum.Material.SmoothPlastic
chao.BrickColor = BrickColor.new("Institutional white")
chao.Parent = pasta
