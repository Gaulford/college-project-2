create database if not exist senac_pi_2;

use senac_pi_2;

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

create table Produto(
    idProduto int identity not null,
    nomeProduto varchar(256) not null,
    descProduto varchar(256),
    precProduto numeric(15,2) not null,
    descontoPromocao numeric(15,2),
    idCategoria int,
    ativoProduto boolean,
    idUsuario int,
    qtdMinEstoque numeric(15,2),
    imagem blob
);

create table Usuario(
    idUsuario int not null,
    loginUsuario varchar(256) not null,
    senhaUsuario varchar(256) not null,
    nomeUsuario varchar(256) not null,
    tipoPerfil int(2) not null,
    usuarioAtivo boolean not null
);

create table Cliente(
    idCliente int not null,
    nomeCompletoCliente varchar(256) not null,
    emailCliente varchar(256) not null,
    senhaCliente varchar(20) not null,
    CPFCliente int(11) not null,
    celularCliente int(11) not null,
    TelComercialCliente int(10),
    telResidencialCliente int(10),
    dtNascimentoCLiente date,
    recebeNewsletter boolean
);

create table Endereco(
    idEndereco int not null,
    idCliente int,
    nomeEndereco varchar(256) not null,
    logradouroEndereco varchar(256),
    numeroEndereco int not null,
    CEPEndereco int(8) not null,
    complementoEndereco varchar(256),
    cidadeEndereco varchar(256) not null,
    paisEndereco varchar(256) not null,
    UFEndereco varchar(256) not null
);

create table Pedido(
    idPedido int not null,
    idCliente int,
    idStatus varchar(20),
    dataPedido date not null,
    idTipoPagamento int,
    idEndereco int,
    idAplicacao int
);

create table ItemPedido(
    idProduto int,
    idPedido int,
    qtdProduto int not null,
    precoVendaItem numeric(15,2) not null
);

create table Estoque(
    idProduto int,
    qtdProdutoDisponivel int not null
);

create table Categoria(
    idCategoria int not null,
    nomeCategoria varchar(256) not null,
    descCategoria varchar(256) not null
);

create table Aplicacao(
    idAplicacao int not null,
    descAplicacao varchar(256),
    tipoAplicacao varchar(256)
);

create table StatusPedido(
    idStatus int not null,
    descStatus varchar(256)
);

create table TipoPagamento(
    idTipoPagto int not null,
    descTipoPagto varchar(256)
);

alter table Produto
add constraint PK_Produto
primary key (idProduto);

alter table Produto
change idUsuario idUsuario int not null auto_increment;

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

alter table Estoque
add constraint PK_Estoque
primary key (idEstoque);

alter table Estoque
change idEstoque idEstoque int not null auto_increment;

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
primary key (idTipoTipoPagto);

alter table TipoPagamento
change idTipoPagto idTipoPagto int not null auto_increment;

