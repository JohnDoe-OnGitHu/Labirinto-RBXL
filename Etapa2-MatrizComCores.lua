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

-- |-- Fazendo o labirinto --| --

grid[2][2] = 1
grid[2][3] = 1
grid[2][4] = 1
grid[2][5] = 1
grid[3][6] = 1
grid[4][6] = 1
grid[5][6] = 1
grid[6][5] = 1
grid[6][4] = 1
grid[6][2] = 1
grid[6][3] = 1

-- |-- Pintar as Celulas --| --

for l = 1, LINHAS do
	for c = 1, COLUNAS do
		local x = (c - 1) * CELULAS + CELULAS / 2
		local z = -(l - 1) * CELULAS - CELULAS / 2

		local p = Instance.new("Part")
		p.Size = Vector3.new(CELULAS - 0.5, 1, CELULAS - 0.5)
		p.Position = Vector3.new(x, yChao, z)
		p.Anchored = true

		if grid[l][c] == 0 then
			p.BrickColor = BrickColor.new("Medium stone grey")
			p.Material = Enum.Material.Concrete
		else
			p.BrickColor = BrickColor.new("White")
			p.Material = Enum.Material.SmoothPlastic
		end

		p.Parent = pasta
	end
end

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
			local z = -(l - 1) * CELULAS

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
			label.Text = "L: " .. l ..  "\nC: " .. c
			label.TextColor3 = Color3.new(0.364706, 0, 1)
			label.TextScaled = false
			label.TextSize = 200
			label.Font = Enum.Font.Arial
			label.Parent = gui
		end
	end
end

criarDebugGrid()
