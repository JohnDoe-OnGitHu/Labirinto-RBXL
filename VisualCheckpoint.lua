--| ( Serviços ) |--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--| ( RemoteEvent ) |--

local remoteCriar = ReplicatedStorage:WaitForChild("CriarCheckpoints")
local remoteAtivado = ReplicatedStorage:WaitForChild("CheckpointAtivado")
local remoteReativar = ReplicatedStorage:WaitForChild("ReativarCheckpoint")

--| ( ID da imagem ) |--

local ASSET_ID = "rbxassetid://12621451421"

--| ( Tabela ) |--

local listaCheckpoint = {}

--| ( Animação ) |--

local ALTURA_FLUTUAR = 3.5 -- Quão alto ele flutua do chão (em studs)
local AMPLITUDE_SENO = 0.6 -- Quão "longo" é o movimento de sobe-e-desce
local VELOCIDADE_SENO = 1.2 -- Quão rápido ele sobe e desce
local VELOCIDADE_ROTACAO = 0.5 -- Velocidade do giro (em radianos por segundo)

--| ( Função: Atualizar Visual ) |--

local function atualizarVisual(part, ativado)
	for _, decal in ipairs(part:GetChildren()) do
		if decal:IsA("Decal") then
			decal.Transparency = ativado and 1 or 0
		end
	end
	
	if ativado then
		part.Transparency = 0.95
		part.Material = Enum.Material.SmoothPlastic
		part.BrickColor = BrickColor.new("Mid gray")
	else
		part.Transparency = 1
		part.Material = Enum.Material.Neon
		part.BrickColor = BrickColor.new("Lime green")
	end
end

--| ( Criar Partes ) |--

remoteCriar.OnClientEvent:Connect(function(dadosCheckpoints)
	for _, dados in ipairs(dadosCheckpoints) do
		dados.part:Destroy()
	end
	listaCheckpoint = {}
	
	for i, dados in ipairs(dadosCheckpoints) do
		local cp = Instance.new("Part")
		cp.Name = "CP_" .. i
		cp.Size = Vector3.new(4, 4, 0.05)
		cp.Position = dados.posicao
		cp.Anchored = true
		cp.CanCollide = false
		cp.Parent = workspace
		
		local decalFrente = Instance.new("Decal")
		decalFrente.Texture = ASSET_ID
		decalFrente.Face = Enum.NormalId.Front
		decalFrente.Parent = cp
		
		local decalVerso = Instance.new("Decal")
		decalVerso.Texture = ASSET_ID
		decalVerso.Face = Enum.NormalId.Back
		decalVerso.Parent = cp
		
		atualizarVisual(cp, dados.ativado)
		
		table.insert(listaCheckpoint, {
			part = cp,
			dadosServer = dados,
			offsetAnima = math.random() * math.pi * 2,
			baseY = dados.posicao.Y,
			baseX = dados.posicao.X,
			baseZ = dados.posicao.Z,
			rotacaoAtual = 0,
		})
		
		local indiceLocal = i
		
		cp.Touched:Connect(function(hit)
			local personagem = hit.Parent
			if personagem:FindFirstChild("Humanoid") then
				local dadosCp = listaCheckpoint[indiceLocal]
				if dadosCp and not dadosCp.dadosServer.ativado then
					dadosCp.dadosServer.ativado = true
					atualizarVisual(cp, true)
					remoteAtivado:FireServer(indiceLocal)
				end
			end
		end)
	end
end)

--| ( Animação ) |--

RunService.RenderStepped:Connect(function(dt)
	local tempo = tick()
	for _, dados in ipairs(listaCheckpoint) do
		if dados.part and dados.part.Parent then
			if not dados.dadosServer.ativado then
				dados.rotacaoAtual += VELOCIDADE_ROTACAO * dt
				
				local novoY = dados.baseY + ALTURA_FLUTUAR
					+ (math.sin(tempo * VELOCIDADE_SENO
						+ dados.offsetAnima) * AMPLITUDE_SENO)
				
				
				dados.part.CFrame =
					CFrame.new(dados.baseX, novoY, dados.baseZ)
					* CFrame.Angles(0, dados.rotacaoAtual, 0)
			end
		end
	end
end)
