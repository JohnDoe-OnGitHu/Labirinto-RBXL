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
local tamBloco = 10

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

local labirinto = {
	{1,1,1,1,1,1},
	{1,0,0,0,0,1},
	{1,0,1,1,0,1},
	{1,0,0,1,0,1},
	{1,1,0,0,0,1},
	{1,1,1,1,1,1},
}

-- |-- SAIDA --| --

labirinto[3][6] = 0

-- |-- GERAR --| --

local function gerarLabirinto(matriz, offsetX)
	for linha = 1, #matriz do
		for coluna = 1, #matriz[linha] do
			if matriz[linha][coluna] == 1 then

				local x = (coluna * tamBloco) + offsetX
				local z = (linha * tamBloco)
				
				criarParte(
					Vector3.new(tamBloco, altura, tamBloco),
					Vector3.new(x, yChao + altura/2, z)
				)
			end
		end
	end
end

gerarLabirinto(labirinto, 0)

--[[

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

--[[

criarParte(
	Vector3.new(100.000, altura, 1.000),
	Vector3.new(7.932, yChao + altura/2, -58.567),
	"Medium stone grey",
	"Wall_Front"
)

criarParte(
	Vector3.new(100.000, altura, 1.000),
	Vector3.new(8.898, yChao + altura/2, 41.428),
	"Medium stone grey",
	"Wall_Back"
)

criarParte(
	Vector3.new(1.000, altura, 101.000),
	Vector3.new(-40.583, yChao + altura/2, -5.000),
	"Medium stone grey",
	"Wall_Left"
)

criarParte(
	Vector3.new(1.000, altura, 100.000),
	Vector3.new(58.413, yChao + altura/2, -9.052),
	"Medium stone grey",
	"Wall_Right"
)

--------------------------------------------------------

-- FAZER LABIRINTO

--------------------------------------------------------

criarParte(
	Vector3.new(4.386, altura, 14.000),
	Vector3.new(-10.867, yChao + altura/2, 34.119)
)

criarParte(
	Vector3.new(24.385, altura, 5.000),
	Vector3.new(-0.900, yChao + altura/2, 30.523)
)

criarParte(
	Vector3.new(25.386, altura, 4.999),
	Vector3.new(40.598, yChao + altura/2, 30.122)
)

criarParte(
	Vector3.new(4.386, altura, 29.999),
	Vector3.new(20.065, yChao + altura/2, 26.820)
)

criarParte(
	Vector3.new(5.385, altura, 15.000),
	Vector3.new(-1.449, yChao + altura/2, 25.528)
)

criarParte(
	Vector3.new(4.386, altura, 14.999),
	Vector3.new(30.050, yChao + altura/2, 25.223)
)

criarParte(
	Vector3.new(4.386, altura, 13.999),
	Vector3.new(51.054, yChao + altura/2, 25.520)
)

criarParte(
	Vector3.new(4.386, altura, 14.000),
	Vector3.new(-20.958, yChao + altura/2, 24.716)
)

criarParte(
	Vector3.new(15.385, altura, 4.999),
	Vector3.new(35.501, yChao + altura/2, 20.170)
)

criarParte(
	Vector3.new(10.385, altura, 2.999),
	Vector3.new(54.000, yChao + altura/2, 19.992)
)

criarParte(
	Vector3.new(4.000, altura, 14.000),
	Vector3.new(-10.893, yChao + altura/2, 14.859)
)

criarParte(
	Vector3.new(3.786, altura, 13.999),
	Vector3.new(9.249, yChao + altura/2, 14.924)
)

criarParte(
	Vector3.new(36.000, altura, 4.000),
	Vector3.new(-16.893, yChao + altura/2, 9.859)
)

criarParte(
	Vector3.new(25.786, altura, 3.999),
	Vector3.new(20.201, yChao + altura/2, 9.818)
)

criarParte(
	Vector3.new(15.385, altura, 4.999),
	Vector3.new(46.404, yChao + altura/2, 10.065)
)

criarParte(
	Vector3.new(4.786, altura, 13.999),
	Vector3.new(30.652, yChao + altura/2, 4.717)
)

criarParte(
	Vector3.new(4.385, altura, 34.999),
	Vector3.new(40.856, yChao + altura/2, 5.118)
)

criarParte(
	Vector3.new(36.786, altura, 3.999),
	Vector3.new(14.604, yChao + altura/2, -0.129)
)

criarParte(
	Vector3.new(12.000, altura, 5.000),
	Vector3.new(-35.893, yChao + altura/2, -0.641)
)

criarParte(
	Vector3.new(9.385, altura, 4.000),
	Vector3.new(54.302, yChao + altura/2, -0.512)
)

criarParte(
	Vector3.new(5.000, altura, 15.000),
	Vector3.new(-32.393, yChao + altura/2, -5.641)
)

criarParte(
	Vector3.new(4.786, altura, 14.999),
	Vector3.new(-1.448, yChao + altura/2, -5.474)
)

criarParte(
	Vector3.new(4.999, altura, 45.000),
	Vector3.new(-22.393, yChao + altura/2, -10.641)
)

criarParte(
	Vector3.new(15.786, altura, 4.999),
	Vector3.new(4.003, yChao + altura/2, -10.527)
)

criarParte(
	Vector3.new(25.385, altura, 4.000),
	Vector3.new(41.206, yChao + altura/2, -10.386)
)

criarParte(
	Vector3.new(4.000, altura, 26.000),
	Vector3.new(-10.893, yChao + altura/2, -11.141)
)

criarParte(
	Vector3.new(3.385, altura, 20.500),
	Vector3.new(20.186, yChao + altura/2, -12.433)
)

criarParte(
	Vector3.new(4.786, altura, 24.999),
	Vector3.new(9.406, yChao + altura/2, -20.579)
)

criarParte(
	Vector3.new(15.385, altura, 4.500),
	Vector3.new(36.108, yChao + altura/2, -20.587)
)

criarParte(
	Vector3.new(33.000, altura, 6.000),
	Vector3.new(-25.393, yChao + altura/2, -21.141)
)

criarParte(
	Vector3.new(4.385, altura, 25.000),
	Vector3.new(51.604, yChao + altura/2, -20.987)
)

criarParte(
	Vector3.new(4.385, altura, 16.500),
	Vector3.new(30.550, yChao + altura/2, -26.534)
)

criarParte(
	Vector3.new(10.786, altura, 5.000),
	Vector3.new(-8.699, yChao + altura/2, -31.405)
)

criarParte(
	Vector3.new(10.786, altura, 5.000),
	Vector3.new(-8.699, yChao + altura/2, -31.405)
)

criarParte(
	Vector3.new(4.999, altura, 25.000),
	Vector3.new(-0.806, yChao + altura/2, -31.481)
)

criarParte(
	Vector3.new(4.385, altura, 35.500),
	Vector3.new(41.458, yChao + altura/2, -36.140)
)

criarParte(
	Vector3.new(15.000, altura, 4.000),
	Vector3.new(-27.393, yChao + altura/2, -41.141)
)

criarParte(
	Vector3.new(5.000, altura, 25.000),
	Vector3.new(-32.393, yChao + altura/2, -41.641)
)

criarParte(
	Vector3.new(25.385, altura, 4.500),
	Vector3.new(30.905, yChao + altura/2, -41.538)
)

criarParte(
	Vector3.new(4.786, altura, 29.000),
	Vector3.new(-11.815, yChao + altura/2, -43.376)
)

criarParte(
	Vector3.new(4.385, altura, 30.000),
	Vector3.new(20.379, yChao + altura/2, -44.187)
)

criarParte(
	Vector3.new(4.614, altura, 15.000),
	Vector3.new(-22.201, yChao + altura/2, -46.641)
)

criarParte(
	Vector3.new(4.786, altura, 14.999),
	Vector3.new(9.155, yChao + altura/2, -46.578)
)

criarParte(
	Vector3.new(4.385, altura, 19.500),
	Vector3.new(51.332, yChao + altura/2, -49.236)
)

criarParte(
	Vector3.new(11.614, altura, 4.000),
	Vector3.new(-35.701, yChao + altura/2, -52.141)
)

criarParte(
	Vector3.new(25.786, altura, 3.999),
	Vector3.new(-1.397, yChao + altura/2, -51.977)
)

criarParte(
	Vector3.new(4.786, altura, 8.000),
	Vector3.new(-11.916, yChao + altura/2, -53.875)
)

criarParte(
	Vector3.new(3.385, altura, 10.000),
	Vector3.new(30.782, yChao + altura/2, -54.288)
)

]]
