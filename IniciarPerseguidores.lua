local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GerenciadorArmas = require(game.ServerScriptService.GerenciadorArmas)

-- local Gerenciador = require(game.ServerScriptService.GerenciadorPerseguidores)
task.wait(5) -- espera o labirinto gerar
GerenciadorArmas.spawnar()
print("[ MODO BETA ] As armas foram ativadas. Os perseguidores foram desativados.")
-- Gerenciador.iniciar()

local eventoGolpe = ReplicatedStorage:WaitForChild("GolpeEspada")
eventoGolpe.OnServerEvent:Connect(function(jogador, perseguidor)
	GerenciadorArmas.registrarGolpe(jogador, perseguidor)
end)
