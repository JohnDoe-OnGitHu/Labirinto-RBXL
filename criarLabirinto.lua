local workspace = game:GetService("Workspace")

--------------------------------------------------------

-- CONFIGURAÇÕES DE SALA

--------------------------------------------------------

local largura 	= 100
local comprimento = 100
local altura 		= 20
local yChao 		= 0

-- |-- MOVER SPAWN --| --

local spawn = workspace:WaitForChild("SpawnLocation")
spawn.Position = Vector3.new(-43.5, yChao + 1, 43)

-- |-- FUNÇÕES DE CRIAR PAREDES --| --

local function criarParte(tamanho, posicao, cor)
	local part = Instance.new("Part")
	part.Size = tamanho
	part.Position = posicao
	part.Anchored = true
	part.BrickColor = BrickColor.new(cor or "Medium stone grey")
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = workspace
	return part
end

--------------------------------------------------------

-- FAZER CHÃO

--------------------------------------------------------

criarParte(
	Vector3.new(largura, 1, comprimento),
	Vector3.new(0, yChao, 0),
	"Dark stone grey"
)

--------------------------------------------------------

-- FAZER TETO ( ainda não vamos trabalhar com o teto )

--------------------------------------------------------

--[[criarParte(
	Vector3.new(largura, 1, comprimento),
	Vector3.new(0, yChao + altura, 0),
	"Dark stone grey"
)]]

--------------------------------------------------------

-- FAZER PAREDES

--------------------------------------------------------

criarParte(
	Vector3.new(largura, altura, 1),
	Vector3.new(0, yChao + altura/2, -comprimento/2)
)

criarParte(
	Vector3.new(largura, altura, 1),
	Vector3.new(0, yChao + altura/2, comprimento/2)
)

criarParte(
	Vector3.new(1, altura, comprimento),
	Vector3.new(-largura/2, yChao + altura/2, 0)
)

criarParte(
	Vector3.new(1, altura, comprimento),
	Vector3.new(largura/2, yChao + altura/2, 0)
)

--------------------------------------------------------

-- FAZER LABIRINTO

--------------------------------------------------------

criarParte(
	Vector3.new(1, altura, 60),
	Vector3.new(-37, yChao + altura/2, 20)
)
