-- Criar o banco de dados para o supermercado
CREATE DATABASE IF NOT EXISTS supermercado_db;

-- Usar o banco de dados recém-criado
USE supermercado_db;

-- Criar tabela de clientes
CREATE TABLE tbl_clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(200),
    telefone VARCHAR(15),
    email VARCHAR(240),
    data_nascimento DATE
);

-- Criar tabela de fornecedores
CREATE TABLE tbl_fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    endereco VARCHAR(200),
    telefone VARCHAR(15)
);

-- Criar tabela de produtos
CREATE TABLE tbl_produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    codigo_barras VARCHAR(13) NOT NULL UNIQUE,
    descricao TEXT,
    categoria VARCHAR(50),
    id_fornecedor INT NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    validade DATE,
    FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor) ON DELETE CASCADE
);

-- Criar tabela de colaboradores
CREATE TABLE tbl_colaboradores (
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    nome_colaborador VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    funcao VARCHAR(50),
    data_contratacao DATE NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    jornada_trabalho VARCHAR(50),
    supervisor VARCHAR(100)
);

-- Criar tabela de vendas
CREATE TABLE tbl_vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_colaborador INT NOT NULL,
    data_venda DATETIME NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_colaborador) REFERENCES tbl_colaboradores(id_colaborador) ON DELETE CASCADE
);

-- Criar tabela de itens de venda
CREATE TABLE tbl_itens_venda (
    id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES tbl_vendas(id_venda) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto) ON DELETE CASCADE
);

-- Criar tabela de pagamentos
CREATE TABLE tbl_pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES tbl_vendas(id_venda) ON DELETE CASCADE
);
