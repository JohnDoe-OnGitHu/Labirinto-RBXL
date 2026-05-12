local DadosPerseguidores = {	
	INTEVALO_ENTRE_ONDAS 			= 5,
	DURACAO_ONDA 					= 60,
	TEMPO_ALERTA 					= 5,
	
	--| ( Quantidade ) |--
	
	QUANTIDADE_PERSEGUIDORES 		= 1,
	
	--| ( Movimento ) |--
	
	VELOCIDADE_PATRULHA 			= 10,
	VELOCIDADE_PERSEGUIR 			= 20,
	RAIO_DETECCAO 					= 20,
	RAIO_DANO 						= 4,
	PASSO_PATRULHA 					= 5,
	
	--| ( Modelo ) |--
	
	NOME_MODEL_PERSEGUIDOR 			= "Perseguidor",
	
	--| ( Pasta ) |--
	
	perseguidoresAtivos				= {},
	ondaAtiva						= false,
}

--| ( Resgistrar ) |--

function DadosPerseguidores.registrar(model, humanoid, rootPart)
	table.insert(DadosPerseguidores.perseguidoresAtivos, {
		model = model,
		humanoid = humanoid,
		rootPart = rootPart,
		alvo = nil,
	})
end

--| ( Remover ) |--

function DadosPerseguidores.limparLista()
	DadosPerseguidores.perseguidoresAtivos = {}
end

--| ( Retornar ) |--

function DadosPerseguidores.obterAtivos()
	return DadosPerseguidores.perseguidoresAtivos
end

return DadosPerseguidores
