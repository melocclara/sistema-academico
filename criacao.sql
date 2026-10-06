-- SEQUENCES
CREATE SEQUENCE seq_curso START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_turma START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_sala START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- TABELAS INDEPENDENTES
CREATE TABLE Pessoa (
    cpf CHAR(11) NOT NULL,
    nome_completo VARCHAR2(120) NOT NULL,
    data_nasc DATE NOT NULL,
    identidade_genero VARCHAR2(40),
    email VARCHAR2(120) NOT NULL,
    usuario VARCHAR2(30)  NOT NULL,
    senha VARCHAR2(100) NOT NULL,

    CONSTRAINT pk_pessoa PRIMARY KEY (cpf),

    CONSTRAINT uq_pessoa_email UNIQUE (email),
    CONSTRAINT uq_pessoa_usuario UNIQUE (usuario),

    CONSTRAINT ck_pessoa_cpf CHECK (REGEXP_LIKE(cpf, '^[0-9]{11}$')),
    CONSTRAINT ck_pessoa_email CHECK (REGEXP_LIKE(email, '^[^@ ]+@[^@ ]+\.[^@ ]+$')),
    CONSTRAINT ck_pessoa_nasc CHECK (data_nasc >= DATE '1900-01-01')
);

CREATE TABLE Departamento (
    sigla VARCHAR2(10)  NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    localizacao VARCHAR2(100),
    telefone VARCHAR2(11),

    CONSTRAINT pk_departamento PRIMARY KEY (sigla),

    CONSTRAINT uq_depto_nome UNIQUE (nome),

    CONSTRAINT ck_depto_sigla CHECK (sigla = UPPER(sigla)),
    CONSTRAINT ck_depto_tel CHECK (telefone IS NULL OR REGEXP_LIKE(telefone, '^[0-9]{10,11}$'))
);

CREATE TABLE Sala (
    cod_sala NUMBER(5) NOT NULL,
    capacidade NUMBER(4) NOT NULL,
    predio VARCHAR2(40) NOT NULL,
    bloco VARCHAR2(10),
    andar NUMBER(2) NOT NULL,

    CONSTRAINT pk_sala PRIMARY KEY (cod_sala),

    CONSTRAINT ck_sala_cap CHECK (capacidade > 0),
    CONSTRAINT ck_sala_andar CHECK (andar >= 0) -- 0 = térreo
);

CREATE TABLE Disciplina (
    codigo VARCHAR2(10)   NOT NULL,
    nome VARCHAR2(100)  NOT NULL,
    ementa VARCHAR2(1000),
    ch_teorica NUMBER(3) DEFAULT 0 NOT NULL,
    ch_pratica NUMBER(3) DEFAULT 0 NOT NULL,
    num_creditos NUMBER(2) NOT NULL,

    CONSTRAINT pk_disciplina PRIMARY KEY (codigo),

    CONSTRAINT ck_disc_ch CHECK (ch_teorica >= 0 AND ch_pratica >= 0 AND ch_teorica + ch_pratica > 0),
    CONSTRAINT ck_disc_creditos CHECK (num_creditos > 0)
);

-- ESPECIALIZAÇÕES DE PESSOA E MULTIVALORADOS DE PESSOA
CREATE TABLE Telefone_pessoa (
    cpf CHAR(11) NOT NULL,
    telefone VARCHAR2(11) NOT NULL,

    CONSTRAINT pk_telefone_pessoa PRIMARY KEY (cpf, telefone),

    CONSTRAINT fk_telpessoa_pessoa FOREIGN KEY (cpf) REFERENCES Pessoa (cpf) ON DELETE CASCADE,

    CONSTRAINT ck_telpessoa_fmt CHECK (REGEXP_LIKE(telefone, '^[0-9]{10,11}$'))
);

CREATE TABLE Aluno (
    cpf_pessoa CHAR(11) NOT NULL,
    num_matricula VARCHAR2(12) NOT NULL,

    CONSTRAINT pk_aluno PRIMARY KEY (cpf_pessoa),

    CONSTRAINT uq_aluno_matricula UNIQUE (num_matricula),

    CONSTRAINT fk_aluno_pessoa FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa (cpf),

    CONSTRAINT ck_aluno_matricula CHECK (REGEXP_LIKE(num_matricula, '^[0-9]{8,12}$'))
);

CREATE TABLE Professor (
    cpf_pessoa CHAR(11) NOT NULL,
    num_matricula_func VARCHAR2(10) NOT NULL,
    titulacao VARCHAR2(20) NOT NULL,

    CONSTRAINT pk_professor PRIMARY KEY (cpf_pessoa),

    CONSTRAINT uq_prof_matricula UNIQUE (num_matricula_func),

    CONSTRAINT fk_prof_pessoa FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa (cpf),

    CONSTRAINT ck_prof_titulacao CHECK (titulacao IN ('GRADUACAO','ESPECIALIZACAO','MESTRADO','DOUTORADO','POS-DOUTORADO'))
);

-- CURSO (depende de Departamento e Professor)
CREATE TABLE Curso (
    codigo_id NUMBER(5) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    ch_total NUMBER(5) NOT NULL,
    modalidade VARCHAR2(12) NOT NULL,
    turno CHAR(1) NOT NULL,
    num_vagas NUMBER(4) NOT NULL,
    grau_academico VARCHAR2(15) NOT NULL,
    cpf_coordenador CHAR(11),
    sigla_departamento VARCHAR2(10) NOT NULL,

    CONSTRAINT pk_curso PRIMARY KEY (codigo_id),

    CONSTRAINT uq_curso_coord UNIQUE (cpf_coordenador),

    CONSTRAINT fk_curso_coord FOREIGN KEY (cpf_coordenador) REFERENCES Professor (cpf_pessoa),
    CONSTRAINT fk_curso_depto FOREIGN KEY (sigla_departamento) REFERENCES Departamento (sigla),

    CONSTRAINT ck_curso_ch CHECK (ch_total > 0),
    CONSTRAINT ck_curso_vagas CHECK (num_vagas > 0),
    CONSTRAINT ck_curso_modal CHECK (modalidade IN ('PRESENCIAL','EAD','HIBRIDO')),
    CONSTRAINT ck_curso_turno CHECK (turno IN ('M','T','N','I')),   -- I = integral
    CONSTRAINT ck_curso_grau CHECK (grau_academico IN ('BACHARELADO','LICENCIATURA','TECNOLOGO'))
);

-- RELAÇÕES TEMPORAIS (Vincula_se_a e Lotacao)
CREATE TABLE Vincula_se_a (
    cpf_aluno CHAR(11) NOT NULL,
    codigo_curso NUMBER(5) NOT NULL,
    data_ingresso DATE NOT NULL,
    status_vinculo VARCHAR2(12) NOT NULL,
    coeficiente_rendimento NUMBER(4,2),
    forma_ingresso VARCHAR2(25) NOT NULL,
    data_saida DATE,

    CONSTRAINT pk_vincula_se_a PRIMARY KEY (cpf_aluno, codigo_curso, data_ingresso),

    CONSTRAINT fk_vinc_aluno FOREIGN KEY (cpf_aluno) REFERENCES Aluno (cpf_pessoa),
    CONSTRAINT fk_vinc_curso FOREIGN KEY (codigo_curso) REFERENCES Curso (codigo_id),

    CONSTRAINT ck_vinc_status CHECK (status_vinculo IN ('ATIVO','TRANCADO','CONCLUIDO','CANCELADO','TRANSFERIDO')),
    CONSTRAINT ck_vinc_cr CHECK (coeficiente_rendimento IS NULL OR coeficiente_rendimento BETWEEN 0 AND 10),
    CONSTRAINT ck_vinc_forma CHECK (forma_ingresso IN ('SISU','TRANSFERENCIA INTERNA','TRANSFERENCIA EXTERNA','PORTADOR DE DIPLOMA')),
    CONSTRAINT ck_vinc_datas CHECK (data_saida IS NULL OR data_saida >= data_ingresso),
    -- vínculo em aberto (ATIVO/TRANCADO) não tem saída; vínculo encerrado tem
    CONSTRAINT ck_vinc_saida    CHECK ((status_vinculo IN ('ATIVO','TRANCADO') AND data_saida IS NULL) OR (status_vinculo IN ('CONCLUIDO','CANCELADO','TRANSFERIDO') AND data_saida IS NOT NULL))
);
-- só pode existir 1 vínculo em aberto por aluno
CREATE UNIQUE INDEX uq_vinculo_em_aberto ON Vincula_se_a (CASE WHEN data_saida IS NULL THEN cpf_aluno END);

CREATE TABLE Lotacao (
    cpf_professor CHAR(11) NOT NULL,
    sigla_dept VARCHAR2(10) NOT NULL,
    data_admissao DATE NOT NULL,
    regime_trabalho VARCHAR2(3) NOT NULL,
    data_encerramento DATE,

    CONSTRAINT pk_lotacao PRIMARY KEY (cpf_professor, sigla_dept, data_admissao),

    CONSTRAINT fk_lot_prof FOREIGN KEY (cpf_professor) REFERENCES Professor (cpf_pessoa),
    CONSTRAINT fk_lot_depto FOREIGN KEY (sigla_dept)    REFERENCES Departamento (sigla),

    CONSTRAINT ck_lot_regime CHECK (regime_trabalho IN ('20H','40H','DE')),  -- DE = dedicação exclusiva
    CONSTRAINT ck_lot_datas CHECK (data_encerramento IS NULL OR data_encerramento >= data_admissao)
);
-- só 1 lotação vigente por professor
CREATE UNIQUE INDEX uq_lotacao_vigente ON Lotacao (CASE WHEN data_encerramento IS NULL THEN cpf_professor END);

-- TABELAS LIGADAS A DISCIPLINA
CREATE TABLE Bibliografia_disciplina (
    codigo_disciplina VARCHAR2(10) NOT NULL,
    referencia VARCHAR2(300) NOT NULL,

    CONSTRAINT pk_bibliografia   PRIMARY KEY (codigo_disciplina, referencia),

    CONSTRAINT fk_bibl_disc      FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina (codigo) ON DELETE CASCADE
);

CREATE TABLE Pre_requisito (
    codigo_disciplina VARCHAR2(10) NOT NULL,
    codigo_requisito VARCHAR2(10) NOT NULL,

    CONSTRAINT pk_pre_requisito PRIMARY KEY (codigo_disciplina, codigo_requisito),

    CONSTRAINT fk_prereq_disc FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina (codigo),
    CONSTRAINT fk_prereq_req FOREIGN KEY (codigo_requisito)  REFERENCES Disciplina (codigo),

    CONSTRAINT ck_prereq_distintas CHECK (codigo_disciplina <> codigo_requisito)
);

CREATE TABLE Compoe_a_grade_curricular_de (
    codigo_disciplina VARCHAR2(10) NOT NULL,
    codigo_id NUMBER(5) NOT NULL,
    tipo VARCHAR2(11) NOT NULL,
    periodo_sugerido NUMBER(2),

    CONSTRAINT pk_grade_curricular PRIMARY KEY (codigo_disciplina, codigo_id),

    CONSTRAINT fk_grade_disc FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina (codigo),
    CONSTRAINT fk_grade_curso FOREIGN KEY (codigo_id)         REFERENCES Curso (codigo_id),

    CONSTRAINT ck_grade_tipo CHECK (tipo IN ('OBRIGATORIA','ELETIVA')),
    CONSTRAINT ck_grade_periodo CHECK (periodo_sugerido IS NULL OR periodo_sugerido BETWEEN 1 AND 12),
    CONSTRAINT ck_grade_obrig CHECK (tipo = 'ELETIVA' OR periodo_sugerido IS NOT NULL)  -- obrigatória precisa de período sugerido; eletiva não precisa
);

-- TURMA e seus multivalorados / dependentes
CREATE TABLE Turma (
    cod_turma NUMBER(8) NOT NULL,
    periodo VARCHAR2(6) NOT NULL, -- ex.: '2026.2'
    turno CHAR(1) NOT NULL,
    num_vagas NUMBER(3) NOT NULL,
    codigo_disciplina VARCHAR2(10) NOT NULL,

    CONSTRAINT pk_turma PRIMARY KEY (cod_turma),

    CONSTRAINT fk_turma_disc FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina (codigo),

    CONSTRAINT ck_turma_periodo CHECK (REGEXP_LIKE(periodo, '^[0-9]{4}\.[12]$')),
    CONSTRAINT ck_turma_turno CHECK (turno IN ('M','T','N')),
    CONSTRAINT ck_turma_vagas CHECK (num_vagas > 0)
);

-- horários na notação SIGAA: [dias][turno][aulas] ex: 24M12 = seg+qua, manhã, aulas 1 e 2
CREATE TABLE Horario_turma (
    cod_turma NUMBER(8) NOT NULL,
    horario VARCHAR2(20) NOT NULL,

    CONSTRAINT pk_horario_turma PRIMARY KEY (cod_turma, horario),

    CONSTRAINT fk_horario_turma FOREIGN KEY (cod_turma) REFERENCES Turma (cod_turma) ON DELETE CASCADE,

    CONSTRAINT ck_horario_fmt CHECK (REGEXP_LIKE(horario, '^[2-7]+[MTN][1-6]+$'))
);

-- avaliação 'FINAL' tem peso 0, não entra na média
CREATE TABLE Avaliacao (
    cod_turma NUMBER(8) NOT NULL,
    num_avaliacao NUMBER(2) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    peso NUMBER(3,2) NOT NULL,
    data_aplicacao DATE,

    CONSTRAINT pk_avaliacao PRIMARY KEY (cod_turma, num_avaliacao),

    CONSTRAINT fk_aval_turma FOREIGN KEY (cod_turma) REFERENCES Turma (cod_turma) ON DELETE CASCADE,

    CONSTRAINT ck_aval_num CHECK (num_avaliacao > 0),
    CONSTRAINT ck_aval_tipo CHECK (tipo IN ('PROVA','PROJETO','LISTA','SEMINARIO','FINAL')),
    CONSTRAINT ck_aval_peso CHECK (peso BETWEEN 0 AND 1),
    CONSTRAINT ck_aval_final CHECK ((tipo = 'FINAL' AND peso = 0) OR (tipo <> 'FINAL' AND peso > 0))
);

-- MATRÍCULA e tabelas que dependem dela
CREATE TABLE Matricula (
    cpf_aluno CHAR(11) NOT NULL,
    cod_turma NUMBER(8) NOT NULL,
    frequencia NUMBER(5,2) DEFAULT 0 NOT NULL,  -- percentual de presença
    situacao VARCHAR2(10) DEFAULT 'CURSANDO' NOT NULL,

    CONSTRAINT pk_matricula PRIMARY KEY (cpf_aluno, cod_turma),

    CONSTRAINT fk_matr_aluno FOREIGN KEY (cpf_aluno) REFERENCES Aluno (cpf_pessoa),
    CONSTRAINT fk_matr_turma FOREIGN KEY (cod_turma) REFERENCES Turma (cod_turma),

    CONSTRAINT ck_matr_freq CHECK (frequencia BETWEEN 0 AND 100),
    CONSTRAINT ck_matr_situacao CHECK (situacao IN ('CURSANDO','APROVADO','REPROVADO','TRANCADO')),
    CONSTRAINT ck_matr_aprov_freq CHECK (situacao <> 'APROVADO' OR frequencia >= 75) -- regra geral das universidades, não tá no minimundo!!! aprovado exige 75% de presença
);

CREATE TABLE Monitora (
    cpf_aluno CHAR(11) NOT NULL,
    cod_turma NUMBER(8) NOT NULL,

    CONSTRAINT pk_monitora PRIMARY KEY (cpf_aluno, cod_turma),

    CONSTRAINT fk_monit_aluno FOREIGN KEY (cpf_aluno) REFERENCES Aluno (cpf_pessoa),
    CONSTRAINT fk_monit_turma FOREIGN KEY (cod_turma) REFERENCES Turma (cod_turma)
);

CREATE TABLE Ministra (
    cpf_professor CHAR(11) NOT NULL,
    cod_turma NUMBER(8) NOT NULL,

    CONSTRAINT pk_ministra PRIMARY KEY (cpf_professor, cod_turma),

    CONSTRAINT fk_minist_prof FOREIGN KEY (cpf_professor) REFERENCES Professor (cpf_pessoa),
    CONSTRAINT fk_minist_turma FOREIGN KEY (cod_turma) REFERENCES Turma (cod_turma)
);

-- nota de um aluno (via matrícula) em uma avaliação da MESMA turma
-- cod_turma aparece uma vez só e participa das duas FKs compostas
CREATE TABLE Desempenho_em (
    cod_turma NUMBER(8) NOT NULL,
    cpf_aluno CHAR(11) NOT NULL,
    num_avaliacao NUMBER(2) NOT NULL,
    nota NUMBER(4,2) NOT NULL,

    CONSTRAINT pk_desempenho_em PRIMARY KEY (cod_turma, cpf_aluno, num_avaliacao),

    CONSTRAINT fk_desemp_aval FOREIGN KEY (cod_turma, num_avaliacao) REFERENCES Avaliacao (cod_turma, num_avaliacao),
    CONSTRAINT fk_desemp_matr FOREIGN KEY (cpf_aluno, cod_turma) REFERENCES Matricula (cpf_aluno, cod_turma),

    CONSTRAINT ck_desemp_nota CHECK (nota BETWEEN 0 AND 10)
);

-- reserva (N:1:N): cada turma tem UMA sala, reservada por UM professor DA PRÓPRIA turma
-- PK em cod_turma: uma turma -> uma reserva
-- a FK composta para Ministra garante que quem reserva é professor daquela turma
CREATE TABLE Reserva (
    cpf_pessoa CHAR(11) NOT NULL,
    cod_sala NUMBER(5) NOT NULL,
    cod_turma NUMBER(8) NOT NULL,

    CONSTRAINT pk_reserva PRIMARY KEY (cod_turma),

    CONSTRAINT fk_reserva_minist FOREIGN KEY (cpf_pessoa, cod_turma) REFERENCES Ministra (cpf_professor, cod_turma),
    CONSTRAINT fk_reserva_sala FOREIGN KEY (cod_sala) REFERENCES Sala (cod_sala)
);