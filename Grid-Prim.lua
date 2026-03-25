local workspace = game.Workspace

local pasta = workspace:FindFirstChild("Labirinto") or Instance.new("Folder", workspace)
pasta.Name = "Labirinto"

-- |-- Configurações --| --

local LINHAS = 7
local COLUNAS = 5
local CELULAS = 10
local yChao = 0

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
end

criarDebugGrid()
