local workspace = game.Workspace

local pasta = workspace:FindFirstChild("Labirinto") or Instance.new("Folder", workspace)
pasta.Name = "Labirinto"

-- |-- Configurações --| --

local LINHAS = 7
local COLUNAS = 7
local CELULAS = 10
local yChao = 0

-- |-- Matriz --| --

local grid = {}
for l = 1, LINHAS do
	grid[l] = {}
	for c = 1, COLUNAS do
		grid[l][c] = 0
	end
end

-- |-- Origens --| --

local origemL = 4
local origemC = 4
grid[origemL][origemC] = 1

-- |-- Verificar se Celula existe no grid --| --

local function dentro(l, c)
	return l >= 1 and l <= LINHAS and c >= 1 and c <= COLUNAS
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

-- |-- Valores Especiais --| --

for _, v in ipairs(vizinhos2(origemL, origemC)) do
	local nl, nc, ml, mc = v[1], v[2], v[3], v[4]
	if dentro(nl, nc) then grid[nl][nc] = 2 end
	if dentro(ml, mc) then grid[ml][mc] = 3 end
end

-- |-- Cores --| --

local cores = {
	[0] = BrickColor.new("Medium stone grey"), -- 🧱 Parede
	[1] = BrickColor.new("Brick yellow"), -- 🔨 Origem
	[2] = BrickColor.new("Bright blue"), -- 🕎 Vizinho Candidato
	[3] = BrickColor.new("Bright green"), -- 📶 Celula do Meio
}

-- |-- Pintar Celulas --| --

for l = 1, LINHAS do
	for c = 1, COLUNAS do
		local x = (c - 1) * CELULAS + CELULAS / 2
		local z = -(l - 1) * CELULAS - CELULAS / 2 -- 🔨 Z Arrumado
		
		local p = Instance.new("Part")
		p.Size = Vector3.new(CELULAS - 0.5, 1, CELULAS - 0.5)
		p.Position = Vector3.new(x, yChao, z)
		p.Anchored = true
		p.BrickColor = cores[grid[l][c]]
		p.Material = Enum.Material.SmoothPlastic
		p.Parent = pasta
	end
end

-- |-- Debug --| --]

local legenda = {
	[0] = "🧱 Parede",
	[1] = "🔨 Origem",
	[2] = "🎌 Vizinho\ndist 2",
	[3] = "📶 Meio",
}

local function criarDebugGrid()
	local corLinha = BrickColor.new("Gold")

	for l = 1, LINHAS + 1 do
		local z = -(l - 1) * CELULAS
		local p = Instance.new("Part")
		p.Size = Vector3.new(COLUNAS * CELULAS, 0.2, 0.2)
		p.Position = Vector3.new((COLUNAS / 2) * CELULAS, yChao + 0.5, z)
		p.Anchored = true
		p.CanCollide = false
		p.BrickColor = corLinha
		p.Material = Enum.Material.Neon
		p.Parent = pasta
	end

	for c = 1, COLUNAS + 1 do
		local x = (c - 1) * CELULAS
		local p = Instance.new("Part")
		p.Size = Vector3.new(0.2, 0.2, LINHAS * CELULAS)
		p.Position = Vector3.new(x, yChao + 0.5, -(LINHAS / 2) * CELULAS)
		p.Anchored = true
		p.CanCollide = false
		p.BrickColor = corLinha
		p.Material = Enum.Material.Neon
		p.Parent = pasta
	end

	for l = 1, LINHAS do
		for c = 1, COLUNAS do
			local x = (c - 1) * CELULAS + CELULAS / 2
			local z = -(l - 0.5) * CELULAS
			local val = grid[l][c]
			local valExibido = (val <= 1) and val or 0 -- 2 e 3 e Interno

			local p = Instance.new("Part")
			p.Size = Vector3.new(CELULAS * 2, 0.3, CELULAS * 2)
			p.Position = Vector3.new(x, yChao + 1.3, z)
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
			label.Text = "L=" .. l .. " C=" .. c .. "\n[" .. valExibido .. "]\n" .. legenda[val]
			label.TextColor3 = Color3.new(0.364706, 0, 1)
			label.TextScaled = false
			label.TextSize = 69
			label.Font = Enum.Font.Arial
			label.Parent = gui
		end
	end
end

criarDebugGrid()
