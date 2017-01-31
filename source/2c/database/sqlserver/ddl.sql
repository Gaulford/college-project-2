/* Cria a base de dados se não existir */
if( db_id('senac_pi_2') is null )
	create database senac_pi_2
go

/* Usa a base de dados criada */
USE senac_pi_2
go

/* Deleta as tabelas caso elasjá existirem */
if( object_id('Produto') is not null )
	drop table Produto
go

if( object_id('Usuario') is not null )
	drop table Usuario
go

if( object_id('Cliente') is not null )
	drop table Cliente
go

if( object_id('Endereco') is not null )
	drop table Endereco
go

if( object_id('Pedido') is not null )
	drop table Pedido
go

if( object_id('ItemPedido') is not null )
	drop table ItemPedido
go

if( object_id('Estoque') is not null )
	drop table Estoque
go

if( object_id('Categoria') is not null )
	drop table Categoria
go

if( object_id('Aplicacao') is not null )
	drop table Aplicacao
go

if( object_id('StatusPedido') is not null )
	drop table StatusPedido
go

if( object_id('TipoPagamento') is not null )
	drop table TipoPagamento
go

/* Criando a estrutura de tabelas */
create table Produto(
	idProduto int not null identity(1,1),
    nomeProduto varchar(100) not null,
    descProduto text,
    precProduto smallmoney not null,
    descontoPromocao smallmoney,
    idCategoria int not null,
    ativoProduto bit not null,
    idUsuario int not null,
    qtdMinEstoque int not null,
    imagem nvarchar(250)
);

create table Usuario(
    idUsuario int not null identity(1,1),
    loginUsuario varchar(50) not null,
    senhaUsuario varchar(20) not null,
    nomeUsuario varchar(100) not null,
    tipoPerfil bit not null,
    usuarioAtivo bit not null
);

create table Cliente(
    idCliente int not null identity(1,1),
    nomeCompletoCliente varchar(100) not null,
    emailCliente varchar(100) not null,
    senhaCliente varchar(20) not null,
    CPFCliente int not null,
    celularCliente int not null,
    TelComercialCliente int,
    telResidencialCliente int,
    dtNascimentoCLiente date not null,
    recebeNewsletter bit
);

create table Endereco(
    idEndereco int not null identity(1,1),
    idCliente int not null,
    nomeEndereco varchar(100) not null,
    logradouroEndereco varchar(100),
    numeroEndereco int not null,
    CEPEndereco int not null,
    complementoEndereco varchar(50),
    cidadeEndereco varchar(50) not null,
    paisEndereco varchar(50) not null,
    UFEndereco varchar(2) not null
);

create table Pedido(
    idPedido int not null identity(1,1),
    idCliente int not null,
    idStatus int not null,
    dataPedido date not null default getdate(),
    idTipoPagto int not null,
    idEndereco int not null,
    idAplicacao int not null
);

create table ItemPedido(
    idProduto int identity(1,1),
    idPedido int not null,
    qtdProduto int not null,
    precoVendaItem smallmoney not null
);

create table Estoque(
    idProduto int not null identity(1,1),
    qtdProdutoDisponivel int not null
);

create table Categoria(
    idCategoria int not null identity(1,1),
    nomeCategoria varchar(100) not null,
    descCategoria text
);

create table Aplicacao(
    idAplicacao int not null identity(1,1),
    descAplicacao text,
    tipoAplicacao bit not null
);

create table StatusPedido(
    idStatus int not null identity(1,1),
    descStatus text
);

create table TipoPagamento(
    idTipoPagto int not null identity(1,1),
    descTipoPagto text
);

/* Setando as chaves primárias */
alter table     Produto
add constraint  PK_Produto
primary key     (idProduto);

alter table     Usuario
add constraint  PK_Usuario
primary key     (idUsuario);

alter table     Cliente
add constraint  PK_Cliente
primary key     (idCliente);

alter table     Endereco
add constraint  PK_Endereco
primary key     (idEndereco);

alter table     Pedido
add constraint  PK_Pedido
primary key     (idPedido);

alter table     ItemPedido
add constraint  PK_Item_Pedido
primary key     (idProduto,idPedido);

alter table     Estoque
add constraint  PK_Estoque
primary key     (idProduto);

alter table     Categoria
add constraint  PK_Categoria
primary key     (idcategoria);

alter table     Aplicacao
add constraint  PK_Aplicacao
primary key     (idAplicacao);

alter table     StatusPedido
add constraint  PK_Status
primary key     (idStatus);

alter table     TipoPagamento
add constraint  PK_TipoPagto
primary key     (idTipoPagto);

/* Setando as chaves estrangeiras */
alter table     Produto
add constraint  FK_Produto_Categoria
foreign key     (idCategoria)
references      Categoria(idCategoria);

alter table     Produto
add constraint  FK_Produto_Usuario
foreign key     (idUsuario)
references      Usuario(idUsuario);

alter table     Endereco
add constraint  FK_Endereco_Cliente
foreign key     (idCliente)
references      Cliente(idCliente);

alter table     Pedido
add constraint  FK_Pedido_Cliente
foreign key     (idCliente)
references      Cliente(idCliente);

alter table     Pedido
add constraint  FK_Pedido_Status
foreign key     (idStatus)
references      StatusPedido(idStatus);

alter table     Pedido
add constraint  FK_Pedido_TipoPagto
foreign key     (idTipoPagto)
references      TipoPagamento(idTipoPagto);

alter table     Pedido
add constraint  FK_Pedido_Endereco
foreign key     (idEndereco)
references      Endereco(idEndereco);