-- entidades

CREATE TABLE pessoa(
    usuario varchar2(30) NOT NULL,
    cpf char(11),
    email varchar2(60) NOT NULL,
    nome_completo varchar2(90) NOT NULL,
    senha varchar2(30) NOT NULL,
    identidade_genero varchar2(30),
    data_nasc DATE NOT NULL,

    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT pessoa_email_uk UNIQUE (email),
    CONSTRAINT pessoa_usuario_uk UNIQUE (usuario),
    CONSTRAINT pessoa_genero_ck CHECK
        (identidade_genero IN ('Mulher cis', 'Mulher trans', 'Homem cis',
        'Homem trans', 'Não-binário', 'Outro'))
);

CREATE TABLE telefone_da_pessoa(
    telefone varchar2(11),
    cpf_pessoa char(11),

    CONSTRAINT telefone_da_pessoa_pk PRIMARY KEY (cpf_pessoa, telefone),
    CONSTRAINT telefone_da_pessoa_cpf_fk
        FOREIGN KEY (cpf_pessoa) REFERENCES pessoa(cpf)
);

CREATE TABLE aluno(
    num_matricula char(11) NOT NULL,
    cpf_pessoa char(11),

    CONSTRAINT aluno_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT aluno_cpf_fk
        FOREIGN KEY (cpf_pessoa) REFERENCES pessoa(cpf),
    CONSTRAINT aluno_matricula_uk UNIQUE (num_matricula)
);

CREATE TABLE professor(
    titulacao varchar2(25) NOT NULL,
    cpf_pessoa char(11),
    num_matricula_func char(11) NOT NULL,

    CONSTRAINT professor_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT professor_cpf_fk
        FOREIGN KEY (cpf_pessoa) REFERENCES pessoa(cpf),
    CONSTRAINT professor_matricula_uk UNIQUE (num_matricula_func),
    CONSTRAINT professor_titulacao_ck CHECK
        (titulacao IN ('Doutorado', 'Mestrado', 'Especialização', 'Graduação'))
);

CREATE TABLE departamento(
    telefone varchar2(11) NOT NULL,
    localizacao varchar2(80),
    sigla varchar2(10),
    nome varchar2(90) NOT NULL,

    CONSTRAINT departamento_pk PRIMARY KEY (sigla),
    CONSTRAINT departamento_nome_uk UNIQUE (nome),
    CONSTRAINT departamento_telefone_uk UNIQUE (telefone)
);

CREATE SEQUENCE curso_seq
INCREMENT BY 1
START WITH 1;

CREATE TABLE disciplina(
    ch_pratica integer NOT NULL,
    nome varchar2(90) NOT NULL,
    num_creditos integer NOT NULL,
    codigo varchar2(10),
    ementa varchar2(800) NOT NULL,
    ch_teorica integer NOT NULL,

    CONSTRAINT disciplina_pk PRIMARY KEY (codigo),
    CONSTRAINT disciplina_ch_teorica_ck CHECK (ch_teorica >= 0),
    CONSTRAINT disciplina_ch_pratica_ck CHECK (ch_pratica >= 0),
    CONSTRAINT disciplina_ch_total_ck CHECK (ch_teorica + ch_pratica > 0),
    CONSTRAINT disciplina_num_creditos_ck CHECK (num_creditos > 0)
);

CREATE TABLE sala(
    andar integer NOT NULL,
    bloco varchar2(15),
    capacidade integer NOT NULL,
    cod_sala integer,
    predio varchar2(45) NOT NULL,

    CONSTRAINT sala_pk PRIMARY KEY (cod_sala),
    CONSTRAINT sala_capacidade_ck CHECK (capacidade > 0),
    CONSTRAINT sala_andar_ck CHECK (andar >= 0)
);

CREATE TABLE curso(
    turno varchar2(15) NOT NULL,
    cpf_coordenador char(11) NOT NULL,
    nome varchar2(90) NOT NULL,
    grau_academico varchar2(20) NOT NULL,
    codigo_id integer,
    sigla_departamento varchar2(10) NOT NULL,
    num_vagas integer NOT NULL,
    modalidade varchar2(15) NOT NULL,
    ch_total integer NOT NULL,

    CONSTRAINT curso_pk PRIMARY KEY (codigo_id),
    CONSTRAINT curso_cpf_fk
        FOREIGN KEY (cpf_coordenador) REFERENCES professor(cpf_pessoa),
    CONSTRAINT curso_sigla_fk
        FOREIGN KEY (sigla_departamento) REFERENCES departamento(sigla),
    CONSTRAINT curso_uk UNIQUE (nome, modalidade, turno, grau_academico),
    CONSTRAINT curso_ch_total_ck CHECK (ch_total > 0),
    CONSTRAINT curso_num_vagas_ck CHECK (num_vagas > 0),
    CONSTRAINT curso_modalidade_ck CHECK
        (modalidade IN ('Presencial', 'EAD', 'Híbrido')),
    CONSTRAINT curso_turno_ck CHECK
        (turno IN ('Matutino', 'Vespertino', 'Noturno', 'Integral')),
    CONSTRAINT curso_grau_ck CHECK
        (grau_academico IN ('Bacharelado', 'Licenciatura', 'Tecnólogo'))
);

CREATE TABLE turma(
    codigo_disciplina varchar2(10) NOT NULL,
    num_vagas integer NOT NULL,
    cod_turma integer,
    turno varchar2(15) NOT NULL,
    periodo varchar2(20) NOT NULL,

    CONSTRAINT turma_pk PRIMARY KEY (cod_turma),
    CONSTRAINT turma_disciplina_fk
        FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    CONSTRAINT turma_num_vagas_ck CHECK (num_vagas > 0),
    CONSTRAINT turma_turno_ck CHECK
        (turno IN ('Matutino', 'Vespertino', 'Noturno', 'Integral'))
);

CREATE TABLE avaliacao(
    data_avaliacao DATE NOT NULL,
    peso number(4,2) NOT NULL,
    cod_turma integer,
    tipo varchar2(25) NOT NULL,
    num_avaliacao integer,

    CONSTRAINT avaliacao_pk PRIMARY KEY (cod_turma, num_avaliacao),
    CONSTRAINT avaliacao_turma_fk
        FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma),
    CONSTRAINT avaliacao_peso_ck CHECK (peso > 0)
);

-- relacionamentos

CREATE TABLE monitora(
    cod_turma integer,
    cpf_aluno char(11),

    CONSTRAINT monitora_pk PRIMARY KEY (cpf_aluno, cod_turma),
    CONSTRAINT monitora_aluno_fk
        FOREIGN KEY (cpf_aluno) REFERENCES aluno(cpf_pessoa),
    CONSTRAINT monitora_turma_fk
        FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);

CREATE TABLE matricula(
    situacao varchar2(20) NOT NULL,
    frequencia number(5,2),
    cod_turma integer,
    cpf_aluno char(11),

    CONSTRAINT matricula_pk PRIMARY KEY (cpf_aluno, cod_turma),
    CONSTRAINT matricula_aluno_fk
        FOREIGN KEY (cpf_aluno) REFERENCES aluno(cpf_pessoa),
    CONSTRAINT matricula_turma_fk
        FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma),
    CONSTRAINT matricula_frequencia_ck
        CHECK (frequencia >= 0 AND frequencia <= 100),
    CONSTRAINT matricula_situacao_ck CHECK
        (situacao IN ('Matriculado', 'Aprovado', 'Reprovado', 'Trancado'))
);

CREATE TABLE pre_requisito(
    codigo_requisito varchar2(10),
    codigo_disciplina varchar2(10),

    CONSTRAINT pre_requisito_pk
        PRIMARY KEY (codigo_disciplina, codigo_requisito),
    CONSTRAINT pre_requisito_disciplina_fk
        FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    CONSTRAINT pre_requisito_requisito_fk
        FOREIGN KEY (codigo_requisito) REFERENCES disciplina(codigo),
    CONSTRAINT pre_requisito_diferente_ck
        CHECK (codigo_disciplina <> codigo_requisito)
);

CREATE TABLE ministra(
    cod_turma integer,
    cpf_professor char(11),

    CONSTRAINT ministra_pk PRIMARY KEY (cpf_professor, cod_turma),
    CONSTRAINT ministra_professor_fk
        FOREIGN KEY (cpf_professor) REFERENCES professor(cpf_pessoa),
    CONSTRAINT ministra_turma_fk
        FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);

CREATE TABLE compoe_a_grade_curricular_de(
    periodo_sugerido integer,
    codigo_id integer,
    tipo varchar2(20) NOT NULL,
    codigo_disciplina varchar2(10),

    CONSTRAINT compoe_grade_pk
        PRIMARY KEY (codigo_disciplina, codigo_id),
    CONSTRAINT compoe_grade_disciplina_fk
        FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    CONSTRAINT compoe_grade_curso_fk
        FOREIGN KEY (codigo_id) REFERENCES curso(codigo_id),
    CONSTRAINT compoe_grade_tipo_ck
        CHECK (tipo IN ('Obrigatória', 'Eletiva')),
    CONSTRAINT compoe_grade_periodo_ck
        CHECK (periodo_sugerido > 0)
);

CREATE TABLE desempenho_em(
    nota number(4,2),
    num_avaliacao integer,
    cpf_aluno char(11),
    cod_turma integer,

    CONSTRAINT desempenho_em_pk
        PRIMARY KEY (cod_turma, cpf_aluno, num_avaliacao),
    CONSTRAINT desempenho_em_matricula_fk
        FOREIGN KEY (cpf_aluno, cod_turma)
        REFERENCES matricula(cpf_aluno, cod_turma),
    CONSTRAINT desempenho_em_avaliacao_fk
        FOREIGN KEY (cod_turma, num_avaliacao)
        REFERENCES avaliacao(cod_turma, num_avaliacao),
    CONSTRAINT desempenho_em_nota_ck CHECK (nota >= 0 AND nota <= 10)
);

CREATE TABLE vincula_se_a(
    forma_ingresso varchar2(30),
    cpf_aluno char(11),
    coeficiente_rendimento number(4,2),
    data_saida DATE,
    codigo_curso integer,
    situacao varchar2(20) NOT NULL,
    data_ingresso DATE,

    CONSTRAINT vincula_se_a_pk
        PRIMARY KEY (cpf_aluno, codigo_curso, data_ingresso),
    CONSTRAINT vincula_se_a_aluno_fk
        FOREIGN KEY (cpf_aluno) REFERENCES aluno(cpf_pessoa),
    CONSTRAINT vincula_se_a_curso_fk
        FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_id),
    CONSTRAINT vincula_se_a_cr_ck
        CHECK (coeficiente_rendimento >= 0 AND coeficiente_rendimento <= 10)
);

CREATE TABLE lotacao(
    regime_trabalho varchar2(30) NOT NULL,
    data_encerramento DATE,
    sigla_dept varchar2(10),
    cpf_professor char(11),
    data_admissao DATE,

    CONSTRAINT lotacao_pk
        PRIMARY KEY (cpf_professor, sigla_dept, data_admissao),
    CONSTRAINT lotacao_professor_fk
        FOREIGN KEY (cpf_professor) REFERENCES professor(cpf_pessoa),
    CONSTRAINT lotacao_dept_fk
        FOREIGN KEY (sigla_dept) REFERENCES departamento(sigla),
    CONSTRAINT lotacao_datas_ck
        CHECK (data_encerramento IS NULL OR data_encerramento >= data_admissao)
);

CREATE TABLE bibliografia_disciplina(
    referencia varchar2(450),
    codigo_disciplina varchar2(10),

    CONSTRAINT bibliografia_disciplina_pk
        PRIMARY KEY (codigo_disciplina, referencia),
    CONSTRAINT bibliografia_disciplina_fk
        FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
);

CREATE TABLE horario_turma(
    horario varchar2(40),
    cod_turma integer,

    CONSTRAINT horario_turma_pk PRIMARY KEY (cod_turma, horario),
    CONSTRAINT horario_turma_fk
        FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);

CREATE TABLE reserva(
    cod_turma integer,
    cpf_pessoa char(11),
    cod_sala integer,

    CONSTRAINT reserva_pk PRIMARY KEY (cpf_pessoa, cod_sala, cod_turma),
    CONSTRAINT reserva_professor_fk
        FOREIGN KEY (cpf_pessoa) REFERENCES professor(cpf_pessoa),
    CONSTRAINT reserva_sala_fk
        FOREIGN KEY (cod_sala) REFERENCES sala(cod_sala),
    CONSTRAINT reserva_turma_fk
        FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);