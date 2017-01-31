use senac_pi_2;

/* Inserting a new Category */
insert into categoria
(
	nomeCategoria
,	DescCategoria
)
values
(
	"Tênis"
,	"Tênis"
);

/* Inserting a new User */
insert into usuario
(
	loginUsuario
,	senhaUsuario
,	nomeUsuario
,	tipoPerfil
,	usuarioAtivo
)
values
(
	"someone@gmail.com"
,	"123456"
,	"William"
,	"A"
,	1
);

/* Inserting a new product */
insert into produto
(
	nomeProduto
,	descProduto
,	precProduto
,	descontoPromocao
,	idCategoria
,	ativoProduto
,	idUsuario
,	qtdMinEstoque
)
values
(
	"Tênis Nike"
,	"Um tênis da nike"
,	199.90
,	50.00
,	1
,	1
,	1
,	30
);