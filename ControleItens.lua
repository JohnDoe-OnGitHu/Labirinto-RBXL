
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dados = require(ReplicatedStorage:WaitForChild("DadosLabirinto"))
local Evento = ReplicatedStorage:WaitForChild("EventoColetarItem") or Instance.new("RemoteEvent", ReplicatedStorage)
Evento.Name = "EventoColetarItem"

local ITENS = {
	{Nome = "Chave Dourada", Imagem = "rbxassetid://17368155868", Cor = Color3.new(1, 0.8, 0)},
	{Nome = "Poção Azul", Imagem = "rbxassetid://16112286685", Cor = Color3.new(0, 0.5, 1)},
	{Nome = "Cristal", Imagem = "rbxassetid://1374798438", Cor = Color3.new(0, 1, 1)},
}

task.wait(3)

local celulasLivres = Dados.obterCelulasAbertas()
local posicoesOcupadas = {}

for i = 1, 20 do
	if #celulasLivres == 0 then break end
	
	local indiceAleatorio = math.random(#celulasLivres)
	local celula = table.remove(celulasLivres, indiceAleatorio)
	local pos = celula.posicao
	
	if Dados.posicaoEhValida(pos, posicoesOcupadas, 15) then
		table.insert(posicoesOcupadas, pos)
		
		local infoItem = ITENS[math.random(#ITENS)]
		
		local p = Instance.new("Part")
		p.Name = infoItem.Nome
		p.Size = Vector3.new(2, 2, 2)
		p.Position = pos + Vector3.new(0, 1, 0)
		p.Anchored = true
		p.CanCollide = false
		p.Color = infoItem.Cor
		p.Material = Enum.Material.Neon
		p.Parent = game.Workspace:FindFirstChild("Labirinto")
		
		p.Touched:Connect(function(hit)
			local player = game.Players:GetPlayerFromCharacter(hit.Parent)
			if player then
				Evento:FireClient(player, infoItem.Nome, infoItem.Imagem)
				p:Destroy()
			end
		end)
	end
end
