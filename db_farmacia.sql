
CREATE DATABASE IF NOT EXISTS db_farmacia COLLATE utf8mb4_general_ci CHARSET utf8mb4;


USE db_farmacia;

CREATE TABLE IF NOT EXISTS tb_setor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(20) NOT NULL
);


CREATE TABLE IF NOT EXISTS tb_categoria (
    id INT PRIMARY KEY NOT NULL,
    classificacao VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS tb_marca (
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS tb_fornecedor (
    id INT PRIMARY KEY NOT NULL,
    CNPJ BIGINT NOT NULL,
    nome VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS tb_estoque (
    id INT PRIMARY KEY NOT NULL,
    quantidade INT NOT NULL,
    id_fornecedor INT,
    CONSTRAINT fk_estoque_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id)
);


CREATE TABLE IF NOT EXISTS tb_produto (
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR(255) NOT NULL,
    dt_fabricacao DATE NOT NULL,
    dt_vencimento DATE NOT NULL,
    valor DECIMAL(9,2) NOT NULL,
    id_fornecedor INT,
    id_estoque INT,
    id_marca INT,
    id_categoria INT,
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id),
    CONSTRAINT fk_produto_estoque FOREIGN KEY (id_estoque) REFERENCES tb_estoque(id),
    CONSTRAINT fk_produto_marca FOREIGN KEY (id_marca) REFERENCES tb_marca(id),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categoria(id)
);


CREATE TABLE IF NOT EXISTS tb_desconto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    valor_desconto DECIMAL(3,2) NOT NULL,
    id_funcionario INT,
    CONSTRAINT fk_desconto_funcionario FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id)
);


CREATE TABLE IF NOT EXISTS tb_cliente (
    id INT PRIMARY KEY NOT NULL,
    CPF BIGINT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    dt_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS tb_funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    CPF BIGINT NOT NULL,
    dt_nascimento DATE NOT NULL,
    id_setor INT,
    CONSTRAINT fk_funcionario_setor FOREIGN KEY (id_setor) REFERENCES tb_setor(id)
);


CREATE TABLE IF NOT EXISTS tb_compra (
    id INT PRIMARY KEY NOT NULL,
    valor_inicial DECIMAL(9,5) NOT NULL,
    valor_final DECIMAL(9,5) NOT NULL,
    dt_compra DATE NOT NULL,
    id_cliente INT,
    id_desconto INT,
    CONSTRAINT fk_compra_cliente FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id),
    CONSTRAINT fk_compra_desconto FOREIGN KEY (id_desconto) REFERENCES tb_desconto(id)
);