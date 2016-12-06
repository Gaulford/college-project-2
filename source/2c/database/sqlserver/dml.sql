/* Verifica se a base de dados existe */
if(db_id('senac_pi_2') is not null)
	/* Usa a base de dados criada */
	use senac_pi_2;
	go
	
	/* Verifica se a tabela existe para executar a inserção */
	if(object_id('Categoria') is not null)
		insert into Categoria(
			nomeCategoria
		,	DescCategoria
		)
		values(
			'Tênis'
		,	'Tênis'
		);
	go

	/* Verifica se a tabela existe para executar a inserção */
	if(object_id('Usuario') is not null)
		insert into Usuario(
			loginUsuario
		,	senhaUsuario
		,	nomeUsuario
		,	tipoPerfil
		,	usuarioAtivo
		)
		values(
			'someone@gmail.com'
		,	'123456'
		,	'William'
		,	1
		,	1
		);
	go

	/* Verifica se a tabela existe para executar a inserção */
	if(object_id('Produto') is not null)
		insert into Produto(
			nomeProduto
		,	descProduto
		,	precProduto
		,	descontoPromocao
		,	idCategoria
		,	ativoProduto
		,	idUsuario
		,	qtdMinEstoque
		)
		values(
			'Tênis Nike'
		,	'Um tênis da nike'
		,	199.90
		,	50.00
		,	1
		,	1
		,	1
		,	30
		);
	go
go