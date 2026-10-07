-- PESSOA E ESPECIALIZAÇÕES
CREATE TABLE pessoa
(
    cpf char(11),
    nome_completo varchar2(70) NOT NULL,
    data_nasc date NOT NULL,
    identidade_genero varchar2(20),
    email varchar2(50) NOT NULL,
    usuario varchar2(15) NOT NULL,
    senha varchar2(30) NOT NULL,
    -- PRIMARY KEY já impede NULL
    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    -- UNIQUE constraints
    CONSTRAINT pessoa_email_uk UNIQUE (email),
    CONSTRAINT pessoa_usuario_uk UNIQUE (usuario),
    -- CHECK constraints
    CONSTRAINT pessoa_cpf_ck CHECK (REGEXP_LIKE(cpf, '^[0-9]{11}$')),
    CONSTRAINT pessoa_email_ck CHECK (REGEXP_LIKE(email, '^[^@ ]+@[^@ ]+\.[^@ ]+$')),
    CONSTRAINT pessoa_usuario_ck CHECK (usuario NOT LIKE '% %'),
    CONSTRAINT pessoa_senha_ck CHECK (senha LIKE '________%' AND senha NOT LIKE '% %'),
    CONSTRAINT pessoa_genero_ck CHECK (identidade_genero IN ('Mulher cis', 'Mulher trans', 'Homem cis', 'Homem trans', 'Não-binário', 'Outro'))
);

CREATE TABLE telefone_pessoa
(
    cpf_pessoa char(11),
    telefone varchar2(11),
    CONSTRAINT telefone_pessoa_pk PRIMARY KEY (cpf_pessoa, telefone),
    CONSTRAINT telefone_pessoa_cpf_fk FOREIGN KEY (cpf_pessoa) REFERENCES pessoa(cpf),
    CONSTRAINT departamento_telefone_ck CHECK (REGEXP_LIKE(telefone, '^[0-9]{10,11}$'))
);

CREATE TABLE aluno
(
    cpf_pessoa char(11),
    num_matricula char(11) NOT NULL,
    CONSTRAINT aluno_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT aluno_cpf_fk FOREIGN KEY (cpf_pessoa) REFERENCES pessoa(cpf),
    CONSTRAINT aluno_matricula_uk UNIQUE (num_matricula)
);

CREATE TABLE professor
(
    cpf_pessoa char(11),
    num_matricula_func char(11) NOT NULL,
    titulacao varchar2(20) NOT NULL,
    CONSTRAINT professor_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT professor_cpf_fk FOREIGN KEY (cpf_pessoa) REFERENCES pessoa(cpf),
    CONSTRAINT professor_matricula_uk UNIQUE (num_matricula_func),
    CONSTRAINT professor_titulacao_ck CHECK (titulacao IN ('Doutorado', 'Mestrado', 'Especialização', 'Graduação'))
);

-- ENTIDADES PRINCIPAIS
CREATE TABLE departamento
(
    sigla varchar2(10),
    nome varchar2(100) NOT NULL,
    localizacao varchar2(70),
    telefone varchar2(11) NOT NULL,
    CONSTRAINT dep_g1_pk PRIMARY KEY (sigla),
    CONSTRAINT dep_g1_nome_uk UNIQUE (nome),
    CONSTRAINT dep_g1_tel_uk UNIQUE (telefone),
    CONSTRAINT dep_g1_tel_ck
        CHECK (REGEXP_LIKE(telefone, '^[0-9]{10,11}$'))
);

CREATE SEQUENCE curso_seq INCREMENT BY 1 START WITH 1;

CREATE TABLE curso
(
    codigo_id integer,
    nome varchar2(100) NOT NULL,
    ch_total integer NOT NULL,
    modalidade varchar2(15) NOT NULL,
    turno varchar2(15) NOT NULL,
    num_vagas integer NOT NULL,
    grau_academico varchar2(20) NOT NULL,
    cpf_coordenador char(11) NOT NULL,
    sigla_departamento varchar2(10) NOT NULL,
    -- PRIMARY KEY já impede NULL
    CONSTRAINT curso_pk PRIMARY KEY (codigo_id),
    -- FOREIGN KEY constraints
    CONSTRAINT curso_cpf_fk FOREIGN KEY (cpf_coordenador) REFERENCES professor(cpf_pessoa),
    CONSTRAINT curso_sigla_fk FOREIGN KEY (sigla_departamento) REFERENCES departamento(sigla),
    -- UNIQUE constraints
    CONSTRAINT curso_uk UNIQUE (nome, modalidade, turno, grau_academico),
    CONSTRAINT curso_coordenador_uk UNIQUE (cpf_coordenador),
    -- CHECK constraints
    CONSTRAINT curso_ch_total_ck CHECK (ch_total > 0),
    CONSTRAINT curso_num_vagas_ck CHECK (num_vagas > 0),
    CONSTRAINT curso_modalidade_ck CHECK (modalidade IN ('Presencial', 'EAD', 'Híbrido')),
    CONSTRAINT curso_turno_ck CHECK (turno IN ('Matutino', 'Vespertino', 'Noturno', 'Integral')),
    CONSTRAINT curso_grau_ck CHECK (grau_academico IN ('Bacharelado', 'Licenciatura', 'Tecnólogo'))
);

CREATE TABLE disciplina
(
    codigo varchar2(10),
    nome varchar2(100) NOT NULL,
    ementa varchar2(1000) NOT NULL,
    ch_teorica integer NOT NULL,
    ch_pratica integer NOT NULL,
    num_creditos integer NOT NULL,
    CONSTRAINT disciplina_pk PRIMARY KEY (codigo),
    CONSTRAINT disciplina_ch_teorica_ck CHECK (ch_teorica >= 0),
    CONSTRAINT disciplina_ch_pratica_ck CHECK (ch_pratica >= 0),
    CONSTRAINT disciplina_ch_total_ck CHECK (ch_teorica + ch_pratica > 0),
    CONSTRAINT disciplina_num_creditos_ck CHECK (num_creditos > 0)
);

CREATE TABLE bibliografia_disciplina
(
    codigo_disciplina varchar2(10),
    referencia varchar2(500),
    CONSTRAINT bibliografia_disciplina_pk PRIMARY KEY (codigo_disciplina, referencia),
    CONSTRAINT bibliografia_disciplina_fk FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
);

CREATE TABLE turma
(
    cod_turma varchar2(10),
    periodo varchar2(10) NOT NULL,
    turno varchar2(15) NOT NULL,
    num_vagas integer NOT NULL,
    codigo_disciplina varchar2(10) NOT NULL,
    CONSTRAINT turma_pk PRIMARY KEY (cod_turma),
    CONSTRAINT turma_disciplina_fk FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    CONSTRAINT turma_turno_ck CHECK (turno IN ('Matutino', 'Vespertino', 'Noturno', 'Integral')),
    CONSTRAINT turma_num_vagas_ck CHECK (num_vagas > 0),
    CONSTRAINT turma_periodo_ck CHECK (REGEXP_LIKE(periodo, '^[0-9]{4}\.[12]$'))
);

CREATE TABLE horario_turma
(
    cod_turma varchar2(10),
    horario varchar2(20),
    CONSTRAINT horario_turma_pk PRIMARY KEY (cod_turma, horario),
    CONSTRAINT horario_turma_fk FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma),
    CONSTRAINT horario_turma_ck CHECK (REGEXP_LIKE(horario, '^[2-7]+[MTN][1-6]+$'))
);

CREATE TABLE sala
(
    cod_sala varchar2(10),
    capacidade integer NOT NULL,
    predio varchar2(50) NOT NULL,
    bloco varchar2(10) NOT NULL,
    andar integer NOT NULL,
    CONSTRAINT sala_pk PRIMARY KEY (cod_sala),
    CONSTRAINT sala_capacidade_ck CHECK (capacidade > 0),
    CONSTRAINT sala_andar_ck CHECK (andar >= 0)
);

-- TABELAS DE RELACIONAMENTO
CREATE TABLE avaliacao
(
    num_avaliacao integer,
    cod_turma varchar2(10),
    tipo varchar2(20) NOT NULL,
    peso number(3,2) NOT NULL,
    data_avaliacao date NOT NULL,
    CONSTRAINT avaliacao_pk PRIMARY KEY (num_avaliacao, cod_turma),
    CONSTRAINT avaliacao_turma_fk FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma),
    CONSTRAINT avaliacao_tipo_ck CHECK (tipo IN ('Prova', 'Trabalho', 'Seminário', 'Apresentação', 'Lista')),
    CONSTRAINT avaliacao_peso_ck CHECK (peso > 0 AND peso <= 1)
);

CREATE TABLE matricula
(
    cpf_aluno char(11),
    cod_turma varchar2(10),
    frequencia number(3) NOT NULL,
    situacao varchar2(20) NOT NULL,
    CONSTRAINT matricula_pk PRIMARY KEY (cpf_aluno, cod_turma),
    CONSTRAINT matricula_aluno_fk FOREIGN KEY (cpf_aluno) REFERENCES aluno(cpf_pessoa),
    CONSTRAINT matricula_turma_fk FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma),
    CONSTRAINT matricula_frequencia_ck CHECK (frequencia BETWEEN 0 AND 100),
    CONSTRAINT matricula_situacao_ck CHECK (situacao IN ('Aprovado', 'Reprovado', 'Trancado', 'Matriculado'))
);

CREATE TABLE monitora
(
    cpf_aluno char(11),
    cod_turma varchar2(10),
    CONSTRAINT monitora_pk PRIMARY KEY (cpf_aluno, cod_turma),
    CONSTRAINT monitora_aluno_fk FOREIGN KEY (cpf_aluno) REFERENCES aluno(cpf_pessoa),
    CONSTRAINT monitora_turma_fk FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);

CREATE TABLE pre_requisito
(
    codigo_disciplina varchar2(10),
    codigo_requisito varchar2(10),
    CONSTRAINT pre_requisito_pk PRIMARY KEY (codigo_disciplina, codigo_requisito),
    CONSTRAINT pre_requisito_disciplina_fk FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    CONSTRAINT pre_requisito_requisito_fk FOREIGN KEY (codigo_requisito) REFERENCES disciplina(codigo),
    CONSTRAINT pre_requisito_ck CHECK (codigo_disciplina <> codigo_requisito)
);

CREATE TABLE ministra
(
    cpf_professor char(11),
    cod_turma varchar2(10),
    CONSTRAINT ministra_pk PRIMARY KEY (cpf_professor, cod_turma),
    CONSTRAINT ministra_professor_fk FOREIGN KEY (cpf_professor) REFERENCES professor(cpf_pessoa),
    CONSTRAINT ministra_turma_fk FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);

CREATE TABLE compoe_a_grade_curricular_de
(
    codigo_disciplina varchar2(10),
    codigo_id integer,
    tipo varchar2(20) NOT NULL,
    periodo_sugerido integer,
    CONSTRAINT compoe_pk PRIMARY KEY (codigo_disciplina, codigo_id),
    CONSTRAINT compoe_disciplina_fk FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    CONSTRAINT compoe_curso_fk FOREIGN KEY (codigo_id) REFERENCES curso(codigo_id),
    CONSTRAINT compoe_tipo_ck CHECK (tipo IN ('Obrigatória', 'Eletiva')),
    CONSTRAINT compoe_periodo_ck CHECK (periodo_sugerido IS NULL OR periodo_sugerido BETWEEN 1 AND 12),CONSTRAINT compoe_obrigatoria_ck CHECK (tipo = 'Eletiva' OR periodo_sugerido IS NOT NULL)
);

CREATE TABLE desempenho_em
(
    cpf_aluno char(11),
    cod_turma varchar2(10),
    num_avaliacao integer,
    nota number(3,1) NOT NULL,
    CONSTRAINT desempenho_pk PRIMARY KEY (cpf_aluno, cod_turma, num_avaliacao),
    CONSTRAINT desempenho_matricula_fk FOREIGN KEY (cpf_aluno, cod_turma) REFERENCES matricula(cpf_aluno, cod_turma),
    CONSTRAINT desempenho_avaliacao_fk FOREIGN KEY (num_avaliacao, cod_turma) REFERENCES avaliacao(num_avaliacao, cod_turma),
    CONSTRAINT desempenho_nota_ck CHECK (nota BETWEEN 0 AND 10)
);

CREATE TABLE vincula_se_a
(
    cpf_aluno char(11),
    codigo_curso integer,
    data_ingresso date,
    situacao varchar2(20) NOT NULL,
    coeficiente_rendimento number(3,1),
    forma_ingresso varchar2(20) NOT NULL,
    data_saida date,
    CONSTRAINT vincula_pk PRIMARY KEY (cpf_aluno, codigo_curso, data_ingresso),
    CONSTRAINT vincula_aluno_fk FOREIGN KEY (cpf_aluno) REFERENCES aluno(cpf_pessoa),
    CONSTRAINT vincula_curso_fk FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_id),
    CONSTRAINT vincula_situacao_ck CHECK (situacao IN ('Ativo', 'Trancado', 'Formado', 'Desligado')),
    CONSTRAINT vincula_coeficiente_ck CHECK (coeficiente_rendimento BETWEEN 0 AND 10),
    CONSTRAINT vincula_ingresso_ck CHECK (forma_ingresso IN ('Vestibular', 'SISU', 'Transferência', 'Outro')),
    CONSTRAINT vincula_saida_ck CHECK ((situacao IN ('Ativo', 'Trancado') AND data_saida IS NULL) OR (situacao IN ('Formado', 'Desligado') AND data_saida IS NOT NULL)),
    CONSTRAINT vincula_data_ck CHECK (data_saida IS NULL OR data_saida >= data_ingresso)
);

CREATE UNIQUE INDEX vinculo_ativo_uk
    ON vincula_se_a (
        CASE
            WHEN data_saida IS NULL THEN cpf_aluno
    END
);

CREATE TABLE lotacao
(
    cpf_professor char(11),
    sigla_dept varchar2(10),
    data_admissao date,
    data_encerramento date,
    regime_trabalho varchar2(30) NOT NULL,
    CONSTRAINT lotacao_pk PRIMARY KEY (cpf_professor, sigla_dept, data_admissao),
    CONSTRAINT lotacao_professor_fk FOREIGN KEY (cpf_professor) REFERENCES professor(cpf_pessoa),
    CONSTRAINT lotacao_departamento_fk FOREIGN KEY (sigla_dept) REFERENCES departamento(sigla),
    CONSTRAINT lotacao_data_ck
    CHECK (data_encerramento IS NULL OR data_encerramento >= data_admissao),
    CONSTRAINT lotacao_regime_ck CHECK (regime_trabalho IN ('40 horas', '20 horas', 'Dedicação exclusiva'))
);

CREATE UNIQUE INDEX lotacao_vigente_uk
ON lotacao (
    CASE
        WHEN data_encerramento IS NULL THEN cpf_professor
    END
);

CREATE TABLE reserva
(
    cpf_pessoa char(11),
    cod_sala varchar2(10),
    cod_turma varchar2(10),
    CONSTRAINT reserva_pk PRIMARY KEY (cpf_pessoa, cod_sala, cod_turma),
    CONSTRAINT reserva_pessoa_fk FOREIGN KEY (cpf_pessoa) REFERENCES professor(cpf_pessoa),
    CONSTRAINT reserva_sala_fk FOREIGN KEY (cod_sala) REFERENCES sala(cod_sala),
    CONSTRAINT reserva_turma_fk FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma)
);
