/* Creating database */
create database if not exists senac_pi_2;

/* Seting created database to default schema */
use senac_pi_2;

/* Cleaning database if it exist  */
drop table if exists Produto;
drop table if exists Usuario;
drop table if exists Cliente;
drop table if exists Endereco;
drop table if exists Pedido;
drop table if exists ItemPedido;
drop table if exists Estoque;
drop table if exists Categoria;
drop table if exists Aplicacao;
drop table if exists StatusPedido;
drop table if exists TipoPagamento;

/* Creating all necessary tables */
create table Produto(
    idProduto int not null,
    nomeProduto varchar(100) not null,
    descProduto text,
    precProduto numeric(15,2) not null,
    descontoPromocao numeric(15,2),
    idCategoria int not null,
    ativoProduto boolean not null,
    idUsuario int not null,
    qtdMinEstoque numeric(15,2) not null,
    imagem blob
);

create table Usuario(
    idUsuario int not null,
    loginUsuario varchar(50) not null,
    senhaUsuario varchar(20) not null,
    nomeUsuario varchar(100) not null,
    tipoPerfil boolean not null,
    usuarioAtivo boolean not null
);

create table Cliente(
    idCliente int not null,
    nomeCompletoCliente varchar(100) not null,
    emailCliente varchar(100) not null,
    senhaCliente varchar(20) not null,
    CPFCliente int(11) not null,
    celularCliente int(11) not null,
    TelComercialCliente int(10),
    telResidencialCliente int(10),
    dtNascimentoCLiente date not null,
    recebeNewsletter boolean
);

create table Endereco(
    idEndereco int not null,
    idCliente int not null,
    nomeEndereco varchar(100) not null,
    logradouroEndereco varchar(100),
    numeroEndereco int not null,
    CEPEndereco int(8) not null,
    complementoEndereco varchar(50),
    cidadeEndereco varchar(50) not null,
    paisEndereco varchar(50) not null,
    UFEndereco varchar(2) not null
);

create table Pedido(
    idPedido int not null,
    idCliente int not null,
    idStatus int not null,
    dataPedido date not null default curdate(),
    idTipoPagto int not null,
    idEndereco int not null,
    idAplicacao int not null
);

create table ItemPedido(
    idProduto int not null,
    idPedido int not null,
    qtdProduto int not null,
    precoVendaItem numeric(15,2) not null
);

create table Estoque(
    idProduto int not null,
    qtdProdutoDisponivel int not null
);

create table Categoria(
    idCategoria int not null,
    nomeCategoria varchar(100) not null,
    descCategoria text not null
);

create table Aplicacao(
    idAplicacao int not null,
    descAplicacao text,
    tipoAplicacao boolean not null
);

create table StatusPedido(
    idStatus int not null,
    descStatus text
);

create table TipoPagamento(
    idTipoPagto int not null,
    descTipoPagto text
);

/* Setting all primary keys */
alter table Produto
add constraint PK_Produto
primary key (idProduto);

alter table Produto
change idProduto idProduto int not null auto_increment;

alter table Usuario
add constraint PK_Usuario
primary key (idUsuario);

alter table Usuario
change idUsuario idUsuario int not null auto_increment;

alter table Cliente
add constraint PK_Cliente
primary key (idCliente);

alter table Cliente
change idCliente idCliente int not null auto_increment;

alter table Endereco
add constraint PK_Endereco
primary key (idEndereco);

alter table Endereco
change idEndereco idEndereco int not null auto_increment;

alter table Pedido
add constraint PK_Pedido
primary key (idPedido);

alter table Pedido
change idPedido idPedido int not null auto_increment;

alter table ItemPedido
add constraint PK_ItemPedido
primary key (idProduto,idPedido);

alter table Estoque
add constraint PK_Estoque
primary key (idProduto);

alter table Categoria
add constraint PK_Categoria
primary key (idCategoria);

alter table Categoria
change idCategoria idCategoria int not null auto_increment;

alter table Aplicacao
add constraint PK_Aplicacao
primary key (idAplicacao);

alter table Aplicacao
change idAplicacao idAplicacao int not null auto_increment;

alter table StatusPedido
add constraint PK_Status
primary key (idStatus);

alter table StatusPedido
change idStatus idStatus int not null auto_increment;

alter table TipoPagamento
add constraint PK_TipoPagto
primary key (idTipoPagto);

alter table TipoPagamento
change idTipoPagto idTipoPagto int not null auto_increment;

/* Setting all foreign keys */
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