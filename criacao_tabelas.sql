CREATE TABLE Pessoa (
    cpf VARCHAR2(11) PRIMARY KEY CHECK (LENGTH(cpf) = 11),
    nome_completo VARCHAR2(150) NOT NULL,
    data_nasc DATE NOT NULL,
    identidade_genero VARCHAR2(25),
    email VARCHAR2(200) NOT NULL UNIQUE,
    usuario VARCHAR2(50) NOT NULL UNIQUE,
    senha VARCHAR2(300) NOT NULL
);

CREATE TABLE Departamento (
    sigla VARCHAR2(10) PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL UNIQUE,
    localizacao VARCHAR2(150) NOT NULL,
    telefone VARCHAR2(15)
);

CREATE TABLE Disciplina (
    codigo INTEGER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL UNIQUE,
    ementa VARCHAR2(1000) NOT NULL,
    ch_teorica INTEGER NOT NULL CHECK (ch_teorica >= 0),
    ch_pratica INTEGER NOT NULL CHECK (ch_pratica >= 0),
    num_creditos INTEGER NOT NULL CHECK (num_creditos > 0)
);

CREATE TABLE Sala (
    cod_sala INTEGER PRIMARY KEY,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0),
    predio VARCHAR2(50) NOT NULL,
    bloco VARCHAR2(10),
    andar INTEGER
);

CREATE TABLE Aluno (
    cpf_pessoa VARCHAR2(11) PRIMARY KEY,
    num_matricula VARCHAR2(20) NOT NULL UNIQUE,
    CONSTRAINT fk_aluno_pessoa FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf)
);

CREATE TABLE Professor (
    cpf_pessoa VARCHAR2(11) PRIMARY KEY,
    num_matricula_func VARCHAR2(20) NOT NULL UNIQUE,
    titulacao VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_professor_pessoa FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf)
);

CREATE TABLE Curso (
    codigo_id INTEGER PRIMARY KEY,
    nome VARCHAR2(70) NOT NULL UNIQUE,
    ch_total INTEGER NOT NULL CHECK (ch_total > 0),
    modalidade VARCHAR2(20) NOT NULL CHECK (modalidade IN ('Presencial', 'EAD', 'Híbrido')),
    turno VARCHAR2(20) NOT NULL CHECK (turno IN ('Manhã', 'Tarde', 'Noite', 'Integral')),
    num_vagas INTEGER NOT NULL CHECK (num_vagas > 0),
    grau_academico VARCHAR2(30) NOT NULL CHECK (grau_academico IN ('Bacharelado', 'Licenciatura', 'Tecnólogo')),
    cpf_coordenador VARCHAR2(11) NOT NULL,
    sigla_departamento VARCHAR2(10) NOT NULL,
    
    CONSTRAINT fk_curso_coordenador FOREIGN KEY (cpf_coordenador) REFERENCES Professor(cpf_pessoa),
    CONSTRAINT fk_curso_departamento FOREIGN KEY (sigla_departamento) REFERENCES Departamento(sigla)
);

CREATE TABLE Turma (
    cod_turma INTEGER PRIMARY KEY,
    periodo VARCHAR2(10) NOT NULL,
    turno VARCHAR2(20) NOT NULL CHECK (turno IN ('Manhã', 'Tarde', 'Noite')),
    num_vagas INTEGER NOT NULL CHECK (num_vagas > 0),
    codigo_disciplina INTEGER NOT NULL,
    
    CONSTRAINT fk_turma_disciplina FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina(codigo)
);

CREATE TABLE Avaliacao (
    num_avaliacao INTEGER,
    cod_turma INTEGER,
    tipo VARCHAR2(30) NOT NULL,
    peso NUMBER(4,2) NOT NULL CHECK (peso > 0),
    data_avaliacao DATE NOT NULL,
    
    CONSTRAINT pk_avaliacao PRIMARY KEY (cod_turma, num_avaliacao),
    CONSTRAINT fk_avaliacao_turma FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

CREATE TABLE Matricula (
    cpf_aluno VARCHAR2(11),
    cod_turma INTEGER,
    frequencia NUMBER(5,2) CHECK (frequencia BETWEEN 0 AND 100),
    situacao VARCHAR2(20) NOT NULL CHECK (situacao IN ('Aprovado', 'Reprovado', 'Cursando', 'Trancado')),
    
    CONSTRAINT pk_matricula PRIMARY KEY (cpf_aluno, cod_turma),
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (cpf_aluno) REFERENCES Aluno(cpf_pessoa),
    CONSTRAINT fk_matricula_turma FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

CREATE TABLE Monitora (
    cpf_aluno VARCHAR2(11),
    cod_turma INTEGER,
    
    CONSTRAINT pk_monitora PRIMARY KEY (cpf_aluno, cod_turma),
    CONSTRAINT fk_monitora_aluno FOREIGN KEY (cpf_aluno) REFERENCES Aluno(cpf_pessoa),
    CONSTRAINT fk_monitora_turma FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

CREATE TABLE Pre_requisito (
    codigo_disciplina INTEGER,
    codigo_requisito INTEGER,
    
    CONSTRAINT pk_pre_requisito PRIMARY KEY (codigo_disciplina, codigo_requisito),
    CONSTRAINT fk_pre_req_disciplina FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina(codigo),
    CONSTRAINT fk_pre_req_requisito FOREIGN KEY (codigo_requisito) REFERENCES Disciplina(codigo)
);

CREATE TABLE Ministra (
    cpf_professor VARCHAR2(11),
    cod_turma INTEGER,
    
    CONSTRAINT pk_ministra PRIMARY KEY (cpf_professor, cod_turma),
    CONSTRAINT fk_ministra_professor FOREIGN KEY (cpf_professor) REFERENCES Professor(cpf_pessoa),
    CONSTRAINT fk_ministra_turma FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

CREATE TABLE Compoe_a_grade_curricular_de (
    codigo_disciplina INTEGER,
    codigo_id INTEGER,
    tipo VARCHAR2(20) NOT NULL CHECK (tipo IN ('Obrigatória', 'Eletiva')),
    periodo_sugerido INTEGER CHECK (periodo_sugerido > 0),
    
    CONSTRAINT pk_compoe_grade PRIMARY KEY (codigo_disciplina, codigo_id),
    CONSTRAINT fk_grade_disciplina FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina(codigo),
    CONSTRAINT fk_grade_curso FOREIGN KEY (codigo_id) REFERENCES Curso(codigo_id)
);

CREATE TABLE Vincula_se_a (
    cpf_aluno VARCHAR2(11),
    codigo_curso INTEGER,
    data_ingresso DATE,
    status VARCHAR2(20) NOT NULL,
    coeficiente_rendimento NUMBER(4,2) CHECK (coeficiente_rendimento BETWEEN 0 AND 10),
    forma_ingresso VARCHAR2(50) NOT NULL,
    data_saida DATE,
    
    CONSTRAINT pk_vincula_se_a PRIMARY KEY (cpf_aluno, codigo_curso, data_ingresso),
    CONSTRAINT fk_vincula_aluno FOREIGN KEY (cpf_aluno) REFERENCES Aluno(cpf_pessoa),
    CONSTRAINT fk_vincula_curso FOREIGN KEY (codigo_curso) REFERENCES Curso(codigo_id)
);

CREATE TABLE Lotacao (
    cpf_professor VARCHAR2(11),
    sigla_dept VARCHAR2(10),
    data_admissao DATE,
    regime_trabalho VARCHAR2(20) NOT NULL,
    data_encerramento DATE,
    
    CONSTRAINT pk_lotacao PRIMARY KEY (cpf_professor, sigla_dept, data_admissao),
    CONSTRAINT fk_lotacao_prof FOREIGN KEY (cpf_professor) REFERENCES Professor(cpf_pessoa),
    CONSTRAINT fk_lotacao_dept FOREIGN KEY (sigla_dept) REFERENCES Departamento(sigla)
);

CREATE TABLE Reserva (
    cpf_pessoa VARCHAR2(11),
    cod_sala INTEGER,
    cod_turma INTEGER,
    
    CONSTRAINT pk_reserva PRIMARY KEY (cpf_pessoa, cod_sala, cod_turma),
    CONSTRAINT fk_reserva_prof FOREIGN KEY (cpf_pessoa) REFERENCES Professor(cpf_pessoa),
    CONSTRAINT fk_reserva_sala FOREIGN KEY (cod_sala) REFERENCES Sala(cod_sala),
    CONSTRAINT fk_reserva_turma FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

CREATE TABLE Telefone_pessoa (
    cpf_pessoa VARCHAR2(11),
    telefone VARCHAR2(15),
    CONSTRAINT pk_telefone PRIMARY KEY (cpf_pessoa, telefone),
    CONSTRAINT fk_telefone_pessoa FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf)
);

CREATE TABLE Bibliografia_disciplina (
    codigo_disciplina INTEGER,
    referencia VARCHAR2(500),
    CONSTRAINT pk_bibliografia PRIMARY KEY (codigo_disciplina, referencia),
    CONSTRAINT fk_bibliografia_disc FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina(codigo)
);

CREATE TABLE Horario_turma (
    cod_turma INTEGER,
    horario VARCHAR2(20),
    CONSTRAINT pk_horario PRIMARY KEY (cod_turma, horario),
    CONSTRAINT fk_horario_turma FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

CREATE TABLE Desempenho_em (
    cod_turma INTEGER,
    cpf_aluno VARCHAR2(11),
    num_avaliacao INTEGER,
    nota NUMBER(4,2) CHECK (nota BETWEEN 0 AND 10),
    
    CONSTRAINT pk_desempenho PRIMARY KEY (cod_turma, cpf_aluno, num_avaliacao),
    CONSTRAINT fk_desempenho_matricula FOREIGN KEY (cpf_aluno, cod_turma) REFERENCES Matricula(cpf_aluno, cod_turma),
    CONSTRAINT fk_desempenho_avaliacao FOREIGN KEY (cod_turma, num_avaliacao) REFERENCES Avaliacao(cod_turma, num_avaliacao)
);

CREATE SEQUENCE seq_curso START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_disciplina START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_turma START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sala START WITH 1 INCREMENT BY 1;
