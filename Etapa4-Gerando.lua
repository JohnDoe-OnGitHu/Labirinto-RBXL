local workspace = game.Workspace

local pasta = workspace:FindFirstChild("Labirinto") or Instance.new("Folder", workspace)
pasta.Name = "Labirinto"

-- |-- Configurações --| --

local LINHAS = 11
local COLUNAS = 11
local CELULA = 10
local yChao = 0
local DELAY = 0.003 -- a velocidade do coiso fazendo o labirinto

-- |-- Referencia de partes --| --

local part = {}
for l = 1, LINHAS do
	part[l] = {}
	for c = 1, COLUNAS do
		local x = (c - 1) * CELULA + CELULA / 2
		local z = -(l - 1) * CELULA - CELULA / 2
		
		local p = Instance.new("Part")
		p.Size = Vector3.new(CELULA - 0.5, 1, CELULA - 0.5)
		p.Position = Vector3.new(x, yChao, z)
		p.Anchored = true
		p.BrickColor = BrickColor.new("Medium stone grey")
		p.Material = Enum.Material.SmoothPlastic
		p.Parent = pasta
		
		part[l][c] = p -- ele guardo a referencia no coiso
	end
end

-- |-- Mudar a cor da celula mudada uau que legal muiheheheheheh --| --

local function pintar(l, c, cor)
	if part[l] and part[l][c] then
		part[l][c].BrickColor = BrickColor.new(cor) 
	end
end

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

-- |-- Fronteira --| --

local fronteira = {}

local function adicionarFronteira(l, c)
	for _, v in ipairs(vizinhos2(l, c)) do
		local nl, nc = v[1], v[2]
		if dentro(nl, nc) and grid[nl][nc] == 0 then
			table.insert(fronteira, {nl, nc, l, c})
			pintar(nl, nc, "Bright red") -- fila
		end
	end
end

-- |-- Debug --| --

local function criarDebugGrid()
	local corLinha = BrickColor.new("Gold")

	for l = 1, LINHAS + 1 do
		local z = -(l - 1) * CELULA
		local p = Instance.new("Part")
		p.Size = Vector3.new(COLUNAS * CELULA, 0.2, 0.2)
		p.Position = Vector3.new((COLUNAS / 2) * CELULA, yChao + 1.5, z)
		p.Anchored = true
		p.CanCollide = false
		p.BrickColor = corLinha
		p.Material = Enum.Material.Neon
		p.Parent = pasta
	end

	for c = 1, COLUNAS + 1 do
		local x = (c - 1) * CELULA
		local p = Instance.new("Part")
		p.Size = Vector3.new(0.2, 0.2, LINHAS * CELULA)
		p.Position = Vector3.new(x, yChao + 1.5, -(LINHAS / 2) * CELULA - CELULA / 2)
		p.Anchored = true
		p.CanCollide = false
		p.BrickColor = corLinha
		p.Material = Enum.Material.Neon
		p.Parent = pasta
	end

	for l = 1, LINHAS do
		for c = 1, COLUNAS do
			local x = (c - 1) * CELULA + CELULA / 2
			local z = -(l - 1) * CELULA - CELULA / 2

			local p = Instance.new("Part")
			p.Size = Vector3.new(CELULA * 2, 0.3, CELULA * 2)
			p.Position = Vector3.new(x, yChao + 1.6, z)
			p.Anchored = true
			p.CanCollide = false
			p.Transparency = 1
			p.Parent = pasta

			local gui = Instance.new("SurfaceGui")
			gui.Face = Enum.NormalId.Top
			gui.AlwaysOnTop = true
			gui.PixelsPerStud = 5
			gui.Parent = p

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, 0, 1, 0)
			label.AnchorPoint = Vector2.new(0.5, 0.5)
			label.Position = UDim2.new(0.5, 0, 0.5, 0)
			label.BackgroundTransparency = 1
			label.Text = "L=" .. l .. "\nC=" .. c
			label.TextColor3 = Color3.new(0.364706, 0, 1)
			label.TextScaled = false
			label.TextSize = 69
			label.Font = Enum.Font.Arial
			label.Parent = gui
		end
	end
end

criarDebugGrid()

-- |-- Passo Inicial --| --

math.randomseed(12345)

local startL, startC = 2, 2
grid[startL][startC] = 1
pintar(startL, startC, "Pink")
adicionarFronteira(startL, startC)

task.wait(1)

while #fronteira > 0 do
	task.wait(DELAY)
	
	local idx = math.random(#fronteira)
	local f = table.remove(fronteira, idx)
	local l, c, pl, pc = f[1], f[2], f[3], f[4]
	
	if grid[l][c] == 0 then
		pintar(l, c, "Bright yellow")
		task.wait(DELAY * 1.5)
		
		grid[l][c] = 1
		pintar(l, c, "Pink")
		
		local ml = (l + pl) // 2
		local mc = (c + pc) // 2
		grid[ml][mc] = 1
		pintar(ml, mc, "Pink")
		
		adicionarFronteira(l, c)
	end
end
