CREATE DATABASE IF NOT EXISTS banco_sangue;
USE banco_sangue;

CREATE TABLE candidato (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(20),
    rg VARCHAR(20),
    data_nasc DATE,
    sexo VARCHAR(10),
    mae VARCHAR(100),
    pai VARCHAR(100),
    email VARCHAR(100),
    cep VARCHAR(20),
    endereco VARCHAR(100),
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    telefone_fixo VARCHAR(20),
    celular VARCHAR(20),
    altura DOUBLE,
    peso DOUBLE,
    tipo_sanguineo VARCHAR(5)
);
	