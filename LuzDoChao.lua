-- ============================================================
-- SCRIPT: LuzDoChao
-- TIPO: LocalScript  (roda no computador do jogador, não no servidor)
-- LOCAL: StarterPlayerScripts
--
-- O QUE FAZ: Cria uma luz ciano neon sob vindo do avatar,
-- com efeito de pulso elétrico instável.
--
-- POR QUE LocalScript?
-- A luz é visual e individual — cada jogador enxerga
-- a própria luz. O servidor não precisa saber disso.
-- ============================================================

--| ( Serviços ) |--

local Players		= game:GetService("Players")
local RunService 	= game:GetService("RunService")

--| Referências ao Jogador Local 

local jogador = Players.LocalPlayer
local personagem = jogador.Character or jogador.CharacterAdded:Wait()
local hrp = personagem:WaitForChild("HumanoidRootPart")

print("bapararampamPam! ( LuzDoChão iniciado )")

--| ( Configurações ) |--

local COR_CIANO = Color3.fromRGB(0, 220, 255)
local BRILHO_MIN = 1.2
local BRILHO_MAX = 7
local RANGE = 15
local VELOCIDADE = 3.5
local CHANCE_SOLTAR = 0.15

--| ( Criar Luz ) |--

local spot = Instance.new("SpotLight")
spot.Color		= COR_CIANO
spot.Brightness = BRILHO_MIN
spot.Range		= RANGE
spot.Angle		= 55
spot.Face		= Enum.NormalId.Bottom
spot.Shadows	= true
spot.Parent		= hrp

local halo = Instance.new("PointLight")
halo.Color		= COR_CIANO
halo.Brightness = 999
halo.Range		= 7
halo.Parent		= hrp

--| ( Animação ) |--

local tempoAcumulado = 0
local solucoAtivo = false
local tempSoluco = 0

RunService.RenderStepped:Connect(function(dt)
	tempoAcumulado = tempoAcumulado + dt
	
	local ondaBase = math.sin(tempoAcumulado * VELOCIDADE)
	local t = (ondaBase + 1) / 2
	local brilhoBase = BRILHO_MIN + (BRILHO_MAX - BRILHO_MIN) * t
	
	if not solucoAtivo and math.random() < 0.08 then
		solucoAtivo = true
		tempSoluco = 0.05 + math.random() * 0.1		
	end
	
	if solucoAtivo then
		tempSoluco = tempSoluco - dt
		spot.Brightness = math.random() < 0.5 and 0 or 2
		halo.Brightness = math.random() < 0.5 and 25 or 0
		if tempSoluco <= 0 then
			solucoAtivo = false
		end
	else
		spot.Brightness = brilhoBase
		halo.Brightness = brilhoBase * 0.1
	end
end)


--| ( Garantir que a luz sobreviva ao reset ) |--

jogador.CharacterAdded:Connect(function(novoPersonagem)
	personagem = novoPersonagem
	hrp 	   = novoPersonagem:WaitForChild("HumanoidRootPart")
	
	local spot = Instance.new("SpotLight")
	spot.Color		= COR_CIANO
	spot.Brightness = BRILHO_MIN
	spot.Range		= 25
	spot.Angle		= 120
	spot.Face		= Enum.NormalId.Bottom
	spot.Shadows	= true
	spot.Parent		= hrp

	local halo = Instance.new("PointLight")
	halo.Color		= COR_CIANO
	halo.Brightness = 0
	halo.Range		= 35
	halo.Parent		= hrp
end)
