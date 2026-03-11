local workspace = game.Workspace

local pastaLabirinto = workspace:FindFirstChild("Labirinto")

if not pastaLabirinto then
	pastaLabirinto = Instance.new("Folder")
	pastaLabirinto.Name = "Labirinto"
	pastaLabirinto.Parent = workspace
end



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

-- |-- CONATDORES --| --

local ContadorD = 1
local ContadorE = 1

-- |-- FUNÇÕES DE CRIAR PAREDES --| --

local function criarParte(tamanho, posicao, cor, nome)
	local part = Instance.new("Part")
	part.Size = tamanho
	part.Position = posicao
	part.Anchored = true
	part.BrickColor = BrickColor.new(cor or "Medium stone grey")
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = pastaLabirinto

	if nome then
		part.Name = nome
	else
		if posicao.Z >= 0 then
			part.Name = "D-" .. string.format("%02d", ContadorD)
			ContadorD += 1
		else
			part.Name = "E-" .. string.format("%02d", ContadorE)
			ContadorE += 1
		end
	end
	return part
end




--------------------------------------------------------

-- FAZER CHÃO

--------------------------------------------------------

criarParte(
	Vector3.new(largura, 1, comprimento),
	Vector3.new(0, yChao, 0),
	"Dark stone grey",
	"Floor"
)

--------------------------------------------------------

-- FAZER TETO ( ainda não vamos trabalhar com o teto )

--------------------------------------------------------

--[[criarParte(
	Vector3.new(largura, 1, comprimento),
	Vector3.new(0, yChao + altura, 0),
	"Dark stone grey",
	"Roof"
)]]

--------------------------------------------------------

-- FAZER PAREDES

--------------------------------------------------------

criarParte(
	Vector3.new(largura, altura, 1),
	Vector3.new(0, yChao + altura/2, -comprimento/2),
	"Medium stone grey",
	"Wall_Front"
)

criarParte(
	Vector3.new(largura, altura, 1),
	Vector3.new(0, yChao + altura/2, comprimento/2),
	"Medium stone grey",
	"Wall_Back"
)

criarParte(
	Vector3.new(1, altura, comprimento),
	Vector3.new(-largura/2, yChao + altura/2, 0),
	"Medium stone grey",
	"Wall_Left"
)

criarParte(
	Vector3.new(1, altura, comprimento),
	Vector3.new(largura/2, yChao + altura/2, 0),
	"Medium stone grey",
	"Wall_Right"
)

--------------------------------------------------------

-- FAZER LABIRINTO

--------------------------------------------------------

criarParte(
	Vector3.new(1, altura, 44),
	Vector3.new(-37, yChao + altura/2, 28)
)

criarParte(
	Vector3.new(18, altura, 1),
	Vector3.new(-28.5, yChao + altura/2, 6.5)
)

criarParte(
	Vector3.new(1, altura, 26),
	Vector3.new(-20, yChao + altura/2, 19)
)
