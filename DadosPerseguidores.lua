local DadosPerseguidores = {	
	INTEVALO_ENTRE_ONDAS 			= 120,
	DURACAO_ONDA 					= 45,
	TEMPO_ALERTA 					= 5,
	TEMPO_ARMA	 					= 80,

	--| ( Configuração de batalha ) |--

	GOLPES_PARA_MATAR 				= 3,
	DANO_PERSEGUIDOR 				= 34,
	NOME_MODEL_ARMA 				= "Espada",

	--| ( Quantidade ) |--

	QUANTIDADE_PERSEGUIDORES 		= 20,

	--| ( Pontuação ) |--

	perseguidoresMortos				= 0,

	--| ( Movimento ) |--

	VELOCIDADE_PATRULHA 			= 10,
	VELOCIDADE_PERSEGUIR 			= 20,
	RAIO_DETECCAO 					= 20,
	RAIO_DANO 						= 4,
	PASSO_PATRULHA 					= 5,

	--| ( Modelo ) |--

	NOME_MODEL_PERSEGUIDOR 			= "Perseguidor",
	NOME_PASTA_ATIVOS 				= "PerseguidoresAtivos",

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
