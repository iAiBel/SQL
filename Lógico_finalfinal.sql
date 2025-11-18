/* Lógico_: */

CREATE TABLE Segurado (
    id_segurado INTEGER PRIMARY KEY,
    Nome CHAR(60),
    CPF DECIMAL(11),
    Data_nascimento DATE,
    Email CHAR(100),
    Telefone DECIMAL(14),
    Rua CHAR(30),
    Bairro CHAR(30),
    CEP CHAR(8),
    Cidade CHAR(30),
    UF DECIMAL(2,0),
    fk_Seguro_id_seguro INTEGER
);

CREATE TABLE Seguro (
    id_seguro INTEGER PRIMARY KEY,
    data_inicio DATE,
    Tipo CHAR(17),
    data_fim DATE,
    valor_total DECIMAL(10,2),
    Status CHAR(13),
    data_renovacao DATE,
    fk_Veiculo_id_veiculo INTERGER,
    fk_Bem_id_bem INTEGER,
    fk_Segurado_id_segurado INTEGER
);

CREATE TABLE Parcelas (
    Id_pacela INTEGER PRIMARY KEY,
    numero_parcela INTEGER,
    data_vencimento DATE,
    status CHAR(20),
    data_pagamento DATE,
    valor DECIMAL(10,2),
    fk_Seguro_id_seguro INTEGER
);

CREATE TABLE Sinistro (
    id_sinistro INTEGER PRIMARY KEY,
    categoria_seguro CHAR(60),
    tipo_sinistro CHAR(60),
    descricao CHAR(250),
    data_ocorrencia DATE,
    valor_indenizacao DECIMAL(10,2),
    data_indenizacao DATE,
    status CHAR(20),
    fk_Seguro_id_seguro INTEGER
);

CREATE TABLE Beneficiario (
    id_beneficiario INTEGER PRIMARY KEY,
    nome CHAR(60),
    CPF DECIMAL(11),
    percentual DECIMAL(5,2),
    parentesco CHAR(60),
    fk_Seguro_id_seguro INTEGER
);

CREATE TABLE Veiculo (
    id_veiculo INTERGER PRIMARY KEY,
    marca CHAR(20),
    modelo CHAR(60),
    ano DECIMAL(9),
    placa CHAR(7),
    chassi CHAR(17)
);

CREATE TABLE Bem (
    id_bem INTEGER PRIMARY KEY,
    descricao INTEGER,
    valor_estimado DECIMAL(10),
    rua CHAR(30),
    bairro CHAR(30),
    CEP DECIMAL(11),
    UF DECIMAL(2,0),
    cidade CHAR(30)
);
 
ALTER TABLE Segurado ADD CONSTRAINT FK_Segurado_2
    FOREIGN KEY (fk_Segurado_id_segurado)
    REFERENCES Seguro (id_seguro)
    ON DELETE RESTRICT;
 
ALTER TABLE Segurado ADD CONSTRAINT FK_Segurado_3
    FOREIGN KEY (fk_Seguro_id_seguro)
    REFERENCES Segurado (id_segurado);
 
ALTER TABLE Seguro ADD CONSTRAINT FK_Seguro_2
    FOREIGN KEY (fk_Veiculo_id_veiculo)
    REFERENCES Veiculo (id_veiculo)
    ON DELETE CASCADE;
 
ALTER TABLE Seguro ADD CONSTRAINT FK_Seguro_3
    FOREIGN KEY (fk_Bem_id_bem)
    REFERENCES Bem (id_bem)
    ON DELETE CASCADE;
 
ALTER TABLE Seguro ADD CONSTRAINT FK_Seguro_4
    FOREIGN KEY (fk_Segurado_id_segurado)
    REFERENCES Seguro (id_seguro);
 
ALTER TABLE Parcelas ADD CONSTRAINT FK_Parcelas_2
    FOREIGN KEY (fk_Seguro_id_seguro)
    REFERENCES Seguro (id_seguro)
    ON DELETE CASCADE;
 
ALTER TABLE Sinistro ADD CONSTRAINT FK_Sinistro_2
    FOREIGN KEY (fk_Seguro_id_seguro)
    REFERENCES Seguro (id_seguro)
    ON DELETE CASCADE;
 
ALTER TABLE Beneficiario ADD CONSTRAINT FK_Beneficiario_2
    FOREIGN KEY (fk_Seguro_id_seguro)
    REFERENCES Seguro (id_seguro)
    ON DELETE RESTRICT;