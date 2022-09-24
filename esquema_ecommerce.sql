-- Criação do banco de dados para o cenário de E-commerce --
create database ecommerce;
use ecommerce;

-- Tabela de Cliente --
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
		adress varchar(30),
        constraint unique_cpf_client unique (CPF)
);

-- Tabela de Produto --
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        categorys enum("Eletrônico", "Vestimenta", "Brinquedos", "Alimentos", "Móveis") not null,
		avaliation float default 0,
        size varchar(10),
        constraint unique_cpf_client unique (CPF)
);

-- Tabela de Pagamento --
create table payments(
	idClient int,
    idPayment int,
    typePayment enum("Boleto", "Cartão", "Dois cartões"),
    limitAvailable float,
    dateValid float,
    primary key(idClient, idPayment)
);

-- Tabela de Pedido --
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum("Cancelado", "Confirmado", "Em processamento") default "Em processamento",
        orderDescripton varchar(255),
        sendValue float default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
);

-- Tabela de Estoque --
create table productStorage(
		idProdSorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);

create table productOrder(
		idPOProduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum("Disponível", "Em estoque") default "Disponível", 
        primary key (idPOProduct, idPOorder),
        constraint fk_product_seller foreign key (idPOProduct) references product(idProduct),
        constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
		idLProduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLProduct, idLstorage),
        constraint fk_product_seller foreign key (idLProduct) references product(idProduct),
        constraint fk_product_product foreign key (idLstorage) references orders(idOrder)
);

-- Tabela de Fornecedor --
create table supplier (
		idSupplier int auto_increment primary key,
        socialName varchar(45) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

-- Tabela de Vendedor --
create table seller(
		idSeller int auto_increment primary key,
        socialName varchar(45) not null,
        abstName varchar(45),
        CNPJ char(15) not null,
        CPF char(9) not null,
        location varchar(255) not null,
        contact char(11) not null,
        constraint unique_cpf_seller unique (CPF),
		constraint unique_cnpj_seller unique (CNPJ)
);

-- Tabela de produto por vendedor --
create table productSeller(
		idPseller int,
        idPproduct int,
        pQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idSeller) references seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);