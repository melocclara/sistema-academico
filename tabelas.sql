CREATE TABLE Pessoa (
    cpf VARCHAR2(11),
    nome_completo VARCHAR2(150) NOT NULL,
    data_nasc DATE NOT NULL,
    identidade_genero VARCHAR2(25),
    email VARCHAR2(200) NOT NULL,
    usuario VARCHAR2(50) NOT NULL,
    senha VARCHAR2(300) NOT NULL,

    PRIMARY KEY (cpf),
    UNIQUE (email),
    UNIQUE (usuario),
    CHECK (LENGTH(cpf) = 11)
);

CREATE TABLE Departamento (
    sigla VARCHAR2(10),
    nome VARCHAR2(100) NOT NULL,
    localizacao VARCHAR2(150) NOT NULL,
    telefone VARCHAR2(15),

    PRIMARY KEY (sigla),
    UNIQUE (nome)
);

CREATE TABLE Sala (
    cod_sala INTEGER,
    capacidade INTEGER NOT NULL,
    predio VARCHAR2(50) NOT NULL,
    bloco VARCHAR2(10),
    andar INTEGER,

    PRIMARY KEY (cod_sala),
    CHECK (capacidade > 0)
);

CREATE TABLE Disciplina (
    codigo INTEGER,
    nome VARCHAR2(100) NOT NULL,
    ementa VARCHAR2(1000) NOT NULL,
    ch_teorica INTEGER NOT NULL,
    ch_pratica INTEGER NOT NULL,
    num_creditos INTEGER NOT NULL,

    PRIMARY KEY (codigo),
    UNIQUE (nome),
    CHECK (ch_teorica >= 0),
    CHECK (ch_pratica >= 0),
    CHECK (num_creditos> 0)
);


CREATE TABLE Professor (
    cpf_pessoa VARCHAR2(11),
    num_matricula_func VARCHAR2(20) NOT NULL,
    titulacao VARCHAR2(50) NOT NULL,

    PRIMARY KEY (cpf_pessoa),
    UNIQUE (num_matricula_func),

    CONSTRAINT fk_professor_pessoa
        FOREIGN KEY (cpf_pessoa)
        REFERENCES Pessoa(cpf)
);

CREATE TABLE Aluno (
    cpf_pessoa VARCHAR2(11),
    num_matricula VARCHAR2(20) NOT NULL,

    PRIMARY KEY (cpf_pessoa),
    UNIQUE (num_matricula),

    CONSTRAINT fk_aluno_pessoa
        FOREIGN KEY (cpf_pessoa)
        REFERENCES Pessoa(cpf)
);


-- cursos

CREATE TABLE Curso (
    codigo_id INTEGER,
    nome VARCHAR2(70) NOT NULL,
    ch_total INTEGER NOT NULL,
    modalidade VARCHAR2(20) NOT NULL,
    turno VARCHAR2(20) NOT NULL,
    num_vagas INTEGER NOT NULL,
    grau_academico VARCHAR2(30) NOT NULL,
    cpf_coordenador VARCHAR2(11) NOT NULL,
    sigla_departamento VARCHAR2(10) NOT NULL,

    PRIMARY KEY (codigo_id),
    UNIQUE (nome),
    UNIQUE (cpf_coordenador),

    CHECK (ch_total > 0),
    CHECK (num_vagas > 0),
    CHECK (modalidade IN ('Presencial', 'EAD', 'Híbrido')),
    CHECK (turno IN ('Manhã', 'Tarde', 'Noite', 'Integral')),
    CHECK (grau_academico IN ('Bacharelado', 'Licenciatura', 'Tecnólogo')),

    CONSTRAINT fk_curso_departamento
        FOREIGN KEY (sigla_departamento)
        REFERENCES Departamento(sigla),

    CONSTRAINT fk_curso_coordenador
        FOREIGN KEY (cpf_coordenador)
        REFERENCES Professor(cpf_pessoa)
);

CREATE TABLE Turma (
    cod_turma INTEGER,
    periodo VARCHAR2(10) NOT NULL,
    turno VARCHAR2(20) NOT NULL,
    num_vagas INTEGER NOT NULL,
    codigo_disciplina INTEGER NOT NULL,

    PRIMARY KEY (cod_turma),

    CHECK (num_vagas > 0),
    CHECK (turno IN ('Manhã', 'Tarde', 'Noite')),

    CONSTRAINT fk_turma_disciplina
        FOREIGN KEY (codigo_disciplina)
        REFERENCES Disciplina(codigo)
);


-- relacoes m:n academicas

CREATE TABLE Ministra (
    cpf_professor VARCHAR2(11),
    cod_turma INTEGER,

    PRIMARY KEY (cpf_professor, cod_turma),

    CONSTRAINT fk_ministra_turma
        FOREIGN KEY (cod_turma)
        REFERENCES Turma(cod_turma),

    CONSTRAINT fk_ministra_professor
        FOREIGN KEY (cpf_professor)
        REFERENCES Professor(cpf_pessoa)
);

CREATE TABLE Monitora (
    cpf_aluno VARCHAR2(11),
    cod_turma INTEGER,

    PRIMARY KEY (cpf_aluno, cod_turma),

    CONSTRAINT fk_monitora_turma
        FOREIGN KEY (cod_turma)
        REFERENCES Turma(cod_turma),

    CONSTRAINT fk_monitora_aluno
        FOREIGN KEY (cpf_aluno)
        REFERENCES Aluno(cpf_pessoa)
);

CREATE TABLE Matricula (
    cpf_aluno VARCHAR2(11),
    cod_turma INTEGER,
    frequencia NUMBER(5,2),
    situacao VARCHAR2(20) NOT NULL,

    PRIMARY KEY (cpf_aluno, cod_turma),

    CHECK (frequencia BETWEEN 0 AND 100),
    CHECK (situacao IN ('Aprovado', 'Reprovado', 'Cursando', 'Trancado')),

    CONSTRAINT fk_matricula_turma
        FOREIGN KEY (cod_turma)
        REFERENCES Turma(cod_turma),

    CONSTRAINT fk_matricula_aluno
        FOREIGN KEY (cpf_aluno)
        REFERENCES Aluno(cpf_pessoa)
);


-- avaliações

CREATE TABLE Avaliacao (
    num_avaliacao INTEGER,
    cod_turma INTEGER,
    tipo VARCHAR2(30) NOT NULL,
    peso NUMBER(4,2) NOT NULL,
    data_avaliacao DATE NOT NULL,

    PRIMARY KEY (cod_turma, num_avaliacao),

    CHECK (peso > 0),

    CONSTRAINT fk_avaliacao_turma
        FOREIGN KEY (cod_turma)
        REFERENCES Turma(cod_turma)
);

CREATE TABLE Desempenho_em (
    cod_turma INTEGER,
    cpf_aluno VARCHAR2(11),
    num_avaliacao INTEGER,
    nota NUMBER(4,2),

    PRIMARY KEY (cod_turma, cpf_aluno, num_avaliacao),

    CHECK (nota BETWEEN 0 AND 10),

    CONSTRAINT fk_desempenho_avaliacao
        FOREIGN KEY (cod_turma, num_avaliacao)
        REFERENCES Avaliacao(cod_turma, num_avaliacao),

    CONSTRAINT fk_desempenho_matricula
        FOREIGN KEY (cpf_aluno, cod_turma)
        REFERENCES Matricula(cpf_aluno, cod_turma)
);


-- estrutura curricular

CREATE TABLE Pre_requisito (
    codigo_disciplina INTEGER,
    codigo_requisito INTEGER,

    PRIMARY KEY (codigo_disciplina, codigo_requisito),

    CHECK (codigo_disciplina <> codigo_requisito),

    CONSTRAINT fk_pre_req_requisito
        FOREIGN KEY (codigo_requisito)
        REFERENCES Disciplina(codigo),

    CONSTRAINT fk_pre_req_disciplina
        FOREIGN KEY (codigo_disciplina)
        REFERENCES Disciplina(codigo)
);

CREATE TABLE Compoe_a_grade_curricular_de (
    codigo_disciplina INTEGER,
    codigo_id INTEGER,
    tipo VARCHAR2(20) NOT NULL,
    periodo_sugerido INTEGER,

    PRIMARY KEY (codigo_disciplina, codigo_id),

    CHECK (tipo IN ('Obrigatória', 'Eletiva')),
    CHECK (periodo_sugerido > 0),

    CONSTRAINT fk_grade_curso
        FOREIGN KEY (codigo_id)
        REFERENCES Curso(codigo_id),

    CONSTRAINT fk_grade_disciplina
        FOREIGN KEY (codigo_disciplina)
        REFERENCES Disciplina(codigo)
);

-- vinculos

CREATE TABLE Vincula_se_a (
    cpf_aluno VARCHAR2(11),
    codigo_curso INTEGER,
    data_ingresso DATE,
    status VARCHAR2(20) NOT NULL,
    coeficiente_rendimento NUMBER(4,2),
    forma_ingresso VARCHAR2(50) NOT NULL,
    data_saida DATE,

    PRIMARY KEY (cpf_aluno, codigo_curso, data_ingresso),

    CHECK (coeficiente_rendimento BETWEEN 0 AND 10),
    CHECK (data_saida IS NULL OR data_saida >= data_ingresso),

    CONSTRAINT fk_vincula_curso
        FOREIGN KEY (codigo_curso)
        REFERENCES Curso(codigo_id),

    CONSTRAINT fk_vincula_aluno
        FOREIGN KEY (cpf_aluno)
        REFERENCES Aluno(cpf_pessoa)
);

CREATE TABLE Lotacao (
    cpf_professor VARCHAR2(11),
    sigla_dept VARCHAR2(10),
    data_admissao DATE,
    regime_trabalho VARCHAR2(20) NOT NULL,
    data_encerramento DATE,

    PRIMARY KEY (cpf_professor, sigla_dept, data_admissao),

    CHECK (data_encerramento IS NULL OR data_encerramento >= data_admissao),

    CONSTRAINT fk_lotacao_dept
        FOREIGN KEY (sigla_dept)
        REFERENCES Departamento(sigla),

    CONSTRAINT fk_lotacao_prof
        FOREIGN KEY (cpf_professor)
        REFERENCES Professor(cpf_pessoa)
);


-- reservas

CREATE TABLE Reserva (
    cpf_pessoa VARCHAR2(11),
    cod_sala INTEGER,
    cod_turma INTEGER,

    PRIMARY KEY (cpf_pessoa, cod_sala, cod_turma),

    CONSTRAINT fk_reserva_sala
        FOREIGN KEY (cod_sala)
        REFERENCES Sala(cod_sala),

    CONSTRAINT fk_reserva_turma
        FOREIGN KEY (cod_turma)
        REFERENCES Turma(cod_turma),

    CONSTRAINT fk_reserva_prof
        FOREIGN KEY (cpf_pessoa)
        REFERENCES Professor(cpf_pessoa)
);

-- atributos multivalorados

CREATE TABLE Telefone_pessoa (
    cpf_pessoa VARCHAR2(11),
    telefone VARCHAR2(15),

    PRIMARY KEY (cpf_pessoa, telefone),

    CONSTRAINT fk_telefone_pessoa
        FOREIGN KEY (cpf_pessoa)
        REFERENCES Pessoa(cpf)
);

CREATE TABLE Horario_turma (
    cod_turma INTEGER,
    horario VARCHAR2(20),

    PRIMARY KEY (cod_turma, horario),

    CONSTRAINT fk_horario_turma
        FOREIGN KEY (cod_turma)
        REFERENCES Turma(cod_turma)
);

CREATE TABLE Bibliografia_disciplina (
    codigo_disciplina INTEGER,
    referencia VARCHAR2(500),

    PRIMARY KEY (codigo_disciplina, referencia),

    CONSTRAINT fk_bibliografia_disc
        FOREIGN KEY (codigo_disciplina)
        REFERENCES Disciplina(codigo)
);


-- SEQUENCES

CREATE SEQUENCE seq_disciplina START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sala START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_curso START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_turma START WITH 1 INCREMENT BY 1;