/* Departamento */
INSERT INTO Departamento (sigla, nome, localizacao, telefone)
VALUES ('CIN', 'CENTRO DE INFORMÁTICA', 'AV. DOS REITORES, 140', 5581912345678);

/* Pessoas */
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (12345678901, 'Ana Silva de Albuquerque', TO_DATE('2002-02-26', 'YYYY-MM-DD'), 'MULHER CIS', 'asa@ufpe.br', 'asa', 'AlB2387%#');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (23456789012, 'Filipe Bastos Cavalcanti', TO_DATE('1978-12-04', 'YYYY-MM-DD'), 'HOMEM TRANS', 'fbc@ufpe.br', 'fbc', 'FopC937@@%');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (34567890123, 'Renata Gomes Tavares', TO_DATE('1975-05-17', 'YYYY-MM-DD'), 'MULHER CIS', 'rgt@ufpe.br', 'rgt', 'Rg7T!2024');

/* Aluno E Professor */
INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (12345678901, 20251000001);
INSERT INTO Professor (cpf_pessoa, num_matricula_func, titulacao) VALUES (23456789012, 90000001, 'ADJUNTO');
INSERT INTO Professor (cpf_pessoa, num_matricula_func, titulacao) VALUES (34567890123, 90000002, 'TITULAR');

/* Curso */
INSERT INTO Curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento)
VALUES (seq_curso.NEXTVAL, 'CIÊNCIA DA COMPUTAÇÃO', 4000, 'PRESENCIAL', 'INTEGRAL', 100, 'BACHARELADO', 34567890123, 'CIN');

/* Disciplina */
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('CIN001', 'Banco de Dados', 'Modelagem, relacional, gerenciamento de dados e informação, SQL', 60, 30, 6);

/* Turma */
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina)
VALUES (seq_turma.NEXTVAL, '2026.2', 'MATUTINO', 50, 'CIN001');

/* Sala */
INSERT INTO Sala (cod_sala, capacidade, predio, bloco, andar)
VALUES (seq_sala.NEXTVAL, 60, 'CENTRO DE INFORMÁTICA', 'A', 2);


/* CASOS: Departamentos */
INSERT INTO Departamento (sigla, nome, localizacao, telefone)
VALUES ('DMAT', 'DEPARTAMENTO DE MATEMÁTICA', 'CCEN - AV. PROF. LUIZ FREIRE, S/N', 5581912340001);
INSERT INTO Departamento (sigla, nome, localizacao, telefone)
VALUES ('DEINFO', 'DEPARTAMENTO DE ESTATÍSTICA E INFORMÁTICA', 'AV. DOS FUNDADORES, 50', 5581912340002);
INSERT INTO Departamento (sigla, nome, localizacao, telefone)
VALUES ('DF', 'DEPARTAMENTO DE FÍSICA', 'CCEN - BLOCO B', NULL);
INSERT INTO Departamento (sigla, nome, localizacao, telefone)
VALUES ('DLET', 'DEPARTAMENTO DE LETRAS', 'CAC - 3º ANDAR', NULL);


/* CASOS: Pessoas */
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (45678901234, 'João Pedro Ferreira Lima', TO_DATE('2003-07-14', 'YYYY-MM-DD'), 'HOMEM CIS', 'jpfl@ufpe.br', 'jpfl', 'Jp#2003!a');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (56789012345, 'Beatriz Nascimento Rocha', TO_DATE('1999-11-30', 'YYYY-MM-DD'), 'MULHER TRANS', 'bnr@ufpe.br', 'bnr', 'Bn@R1130');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (67890123456, 'Alex Menezes Barbosa', TO_DATE('2004-01-09', 'YYYY-MM-DD'), 'NAO-BINARIO', 'amb@ufpe.br', 'amb', 'Am*B0109');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (78901234567, 'Luiza Carvalho Duarte', TO_DATE('2000-04-22', 'YYYY-MM-DD'), 'OUTRO', 'lcd@ufpe.br', 'lcd', 'Lc$D2204');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (89012345678, 'Marcos Antônio de Souza', TO_DATE('1985-09-03', 'YYYY-MM-DD'), NULL, 'mas@ufpe.br', 'mas', 'Mz#S0903');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (90123456789, 'Sofia Lima Pereira', TO_DATE('2005-12-01', 'YYYY-MM-DD'), 'MULHER CIS', 'slp@ufpe.br', 'slp', 'So!P0112');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (10123456789, 'Roberto Alves Neto', TO_DATE('1969-06-18', 'YYYY-MM-DD'), 'HOMEM CIS', 'ran@ufpe.br', 'ran', 'Rb@N1806');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (11234567890, 'Camila Ribeiro Santos', TO_DATE('1990-02-14', 'YYYY-MM-DD'), 'MULHER CIS', 'crs@ufpe.br', 'crs', 'Cm@S1402');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (12234567890, 'Paulo Henrique Duarte', TO_DATE('1982-08-25', 'YYYY-MM-DD'), 'HOMEM CIS', 'phd@ufpe.br', 'phd', 'Ph%D2508');
INSERT INTO Pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha)
VALUES (13234567890, 'Tereza Cristina Lopes', TO_DATE('1972-03-11', 'YYYY-MM-DD'), 'MULHER CIS', 'tcl@ufpe.br', 'tcl', 'Tc!L1103');

/* Telefones */
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (12345678901, 5581988880001);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (12345678901, 5581988880002);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (12345678901, 558133330001);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (23456789012, 5581977770001);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (34567890123, 5581966660001);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (10123456789, 5581955550001);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (10123456789, 5581955550002);
INSERT INTO Telefone_pessoa (cpf, telefone) VALUES (13234567890, 558132720001);


/* CASOS: Funções */
INSERT INTO Professor (cpf_pessoa, num_matricula_func, titulacao) VALUES (10123456789, 90000003, 'ASSOCIADO');
INSERT INTO Professor (cpf_pessoa, num_matricula_func, titulacao) VALUES (11234567890, 90000004, 'ASSISTENTE');
INSERT INTO Professor (cpf_pessoa, num_matricula_func, titulacao) VALUES (12234567890, 90000005, 'AUXILIAR');
INSERT INTO Professor (cpf_pessoa, num_matricula_func, titulacao) VALUES (89012345678, 90000006, 'SUBSTITUTO');

INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (45678901234, 20241000002);
INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (56789012345, 20231000003);
INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (67890123456, 20251000004);
INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (78901234567, 20211000005);
INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (90123456789, 20241000006);
INSERT INTO Aluno (cpf_pessoa, num_matricula) VALUES (89012345678, 20261000007);


/* CASOS: Lotação */
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (23456789012, 'CIN', TO_DATE('2010-03-01', 'YYYY-MM-DD'), 'DEDICACAO EXCLUSIVA', NULL);
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (34567890123, 'DMAT', TO_DATE('1999-02-01', 'YYYY-MM-DD'), '40H', TO_DATE('2005-08-14', 'YYYY-MM-DD'));
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (34567890123, 'CIN', TO_DATE('2005-08-15', 'YYYY-MM-DD'), 'DEDICACAO EXCLUSIVA', NULL);
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (10123456789, 'DMAT', TO_DATE('2001-06-01', 'YYYY-MM-DD'), '40H', NULL);
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (10123456789, 'CIN', TO_DATE('2015-01-10', 'YYYY-MM-DD'), '20H', NULL);
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (11234567890, 'DMAT', TO_DATE('2018-09-03', 'YYYY-MM-DD'), 'DEDICACAO EXCLUSIVA', NULL);
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (12234567890, 'DF', TO_DATE('2020-02-17', 'YYYY-MM-DD'), '20H', TO_DATE('2023-02-16', 'YYYY-MM-DD'));
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (12234567890, 'DF', TO_DATE('2024-03-01', 'YYYY-MM-DD'), '40H', NULL);
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (12234567890, 'DLET', TO_DATE('2019-05-10', 'YYYY-MM-DD'), '20H', TO_DATE('2019-05-10', 'YYYY-MM-DD'));
INSERT INTO Lotacao (cpf_professor, sigla_dept, data_admissao, regime_trabalho, data_encerramento)
VALUES (89012345678, 'DEINFO', TO_DATE('2024-08-01', 'YYYY-MM-DD'), '40H', TO_DATE('2026-07-31', 'YYYY-MM-DD'));


/* CASOS: Curso */
INSERT INTO Curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento)
VALUES (seq_curso.NEXTVAL, 'ENGENHARIA DA COMPUTAÇÃO', 3600, 'PRESENCIAL', 'INTEGRAL', 60, 'BACHARELADO', 23456789012, 'CIN');
INSERT INTO Curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento)
VALUES (seq_curso.NEXTVAL, 'MATEMÁTICA - LICENCIATURA', 2800, 'PRESENCIAL', 'NOTURNO', 50, 'LICENCIATURA', 11234567890, 'DMAT');
INSERT INTO Curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento)
VALUES (seq_curso.NEXTVAL, 'FÍSICA - LICENCIATURA (EAD)', 2900, 'REMOTO', 'VESPERTINO', 120, 'LICENCIATURA', NULL, 'DF');
INSERT INTO Curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento)
VALUES (seq_curso.NEXTVAL, 'CIÊNCIA DE DADOS', 3000, 'HIBRIDO', 'MATUTINO', 40, 'BACHARELADO', 23456789012, 'DEINFO');
INSERT INTO Curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento)
VALUES (seq_curso.NEXTVAL, 'LETRAS - LÍNGUA PORTUGUESA', 2800, 'PRESENCIAL', 'MATUTINO', 0, 'LICENCIATURA', NULL, 'DLET');


/* CASOS: Disciplina */
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('CIN002', 'Estruturas de Dados', 'Listas, pilhas, filas, tabelas hash, árvores e grafos. Análise de complexidade.', 60, 30, 6);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('CIN003', 'Introdução à Programação', 'Variáveis, estruturas de controle, funções e vetores.', 30, 60, 6);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('MAT001', 'Cálculo 1', 'Limites, derivadas, integrais e aplicações.', 60, 0, 4);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('MAT002', 'Álgebra Vetorial e Linear para Computação', 'Geometria analítica, matrizes, sistemas lineares e espaços vetoriais.', 60, 0, 4);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('CIN004', 'Projeto de Software', 'Desenvolvimento em equipe de um sistema completo, com entregas incrementais.', 0, 60, 4);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('CIN005', 'Algoritmos Avançados', 'Programação dinâmica, grafos, algoritmos gulosos e NP-completude.', 45, 15, 4);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('FIS001', 'Fundamentos de Física', 'Mecânica clássica, ondas e termodinâmica (inclui o problema d''água em ebulição).', 45, 0, 3);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('LET001', 'Leitura e Produção de Textos', 'Gêneros textuais acadêmicos, resumo, resenha e artigo.', 30, 0, 2);
INSERT INTO Disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos)
VALUES ('CIN006', 'Tópicos Especiais em Banco de Dados', 'Bancos NoSQL, processamento de transações e otimização de consultas.', 30, 30, 4);


/* CASOS: - Bibliografia */
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('CIN001', 'ELMASRI, R.; NAVATHE, S. Sistemas de Banco de Dados. 7. ed. Pearson, 2018.');
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('CIN001', 'SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. Sistema de Banco de Dados. 6. ed. Elsevier, 2012.');
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('CIN001', 'DATE, C. J. Introdução a Sistemas de Bancos de Dados. 8. ed. Campus, 2004.');
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('CIN002', 'CORMEN, T. H. et al. Algoritmos: Teoria e Prática. 3. ed. Elsevier, 2012.');
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('CIN002', 'STROUSTRUP, B. The C++ Programming Language. 4. ed. Addison-Wesley, 2013.');
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('CIN005', 'CORMEN, T. H. et al. Algoritmos: Teoria e Prática. 3. ed. Elsevier, 2012.');
INSERT INTO Bibliografia_disciplina (codigo_disciplina, referencia)
VALUES ('MAT001', 'STEWART, J. Cálculo. v. 1. 7. ed. Cengage, 2013.');


/* CASOS: Pré-requisito */
INSERT INTO Pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CIN002', 'CIN003');
INSERT INTO Pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CIN001', 'CIN002');
INSERT INTO Pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CIN006', 'CIN001');
INSERT INTO Pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CIN004', 'CIN001');
INSERT INTO Pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CIN005', 'CIN002');
INSERT INTO Pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CIN005', 'MAT001');


/* CASOS: Grade curricular */
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN003', 1, 'OBRIGATORIA', 1);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT001', 1, 'OBRIGATORIA', 1);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN002', 1, 'OBRIGATORIA', 2);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT002', 1, 'OBRIGATORIA', 2);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN001', 1, 'OBRIGATORIA', 3);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN005', 1, 'OBRIGATORIA', 4);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN006', 1, 'ELETIVA DE PERFIL', 6);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN004', 1, 'OBRIGATORIA', 8);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('FIS001', 1, 'ELETIVA LIVRE', NULL);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('LET001', 1, 'ELETIVA LIVRE', NULL);

INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN003', 2, 'OBRIGATORIA', 1);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT001', 2, 'OBRIGATORIA', 1);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('FIS001', 2, 'OBRIGATORIA', 2);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN006', 2, 'ELETIVA LIVRE', NULL);

INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT001', 3, 'OBRIGATORIA', 1);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT002', 3, 'OBRIGATORIA', 2);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('LET001', 3, 'OBRIGATORIA', 1);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN003', 3, 'ELETIVA DE PERFIL', 5);

INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('FIS001', 4, 'OBRIGATORIA', 1);

INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN001', 5, 'OBRIGATORIA', 3);
INSERT INTO Compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CIN006', 5, 'OBRIGATORIA', 5);


/* CASOS: Turma */
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.2', 'VESPERTINO', 60, 'CIN002');  -- 2
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.2', 'NOTURNO', 40, 'MAT001');     -- 3
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.2', 'MATUTINO', 45, 'MAT002');    -- 4
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.1', 'MATUTINO', 50, 'CIN001');    -- 5
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.1', 'VESPERTINO', 40, 'CIN003');  -- 6
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2025.2', 'INTEGRAL', 30, 'CIN004');    -- 7
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.2', 'NOTURNO', 0, 'CIN005');      -- 8
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.2', 'VESPERTINO', 25, 'FIS001');  -- 9
INSERT INTO Turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES (seq_turma.NEXTVAL, '2026.2', 'VESPERTINO', 20, 'CIN006');  -- 10

INSERT INTO Horario_turma (cod_turma, horario) VALUES (1, '24M12');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (1, '6M34');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (2, '35T23');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (3, '246N12');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (4, '35M12');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (5, '24M12');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (6, '24T34');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (7, '2345M12');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (7, '2345T12');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (8, '35N34');
INSERT INTO Horario_turma (cod_turma, horario) VALUES (9, '7M1234');

INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (23456789012, 1);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (34567890123, 1);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (23456789012, 2);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (11234567890, 3);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (11234567890, 4);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (10123456789, 5);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (34567890123, 6);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (89012345678, 7);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (10123456789, 8);
INSERT INTO Ministra (cpf_professor, cod_turma) VALUES (12234567890, 9);


/* CASOS: Sala */
INSERT INTO Sala (cod_sala, capacidade, predio, bloco, andar) VALUES (seq_sala.NEXTVAL, 40, 'CENTRO DE INFORMÁTICA', 'A', 0);   -- 2
INSERT INTO Sala (cod_sala, capacidade, predio, bloco, andar) VALUES (seq_sala.NEXTVAL, 120, 'CENTRO DE INFORMÁTICA', 'B', 1);  -- 3
INSERT INTO Sala (cod_sala, capacidade, predio, bloco, andar) VALUES (seq_sala.NEXTVAL, 30, 'CCEN', 'C', 3);                    -- 4
INSERT INTO Sala (cod_sala, capacidade, predio, bloco, andar) VALUES (seq_sala.NEXTVAL, 80, 'CCEN', 'D1', 1);                   -- 5
INSERT INTO Sala (cod_sala, capacidade, predio, bloco, andar) VALUES (seq_sala.NEXTVAL, 0, 'CAC', 'E', 0);                      -- 6

INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (23456789012, 1, 1);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (23456789012, 3, 1);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (34567890123, 1, 6);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (23456789012, 2, 2);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (11234567890, 4, 3);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (11234567890, 4, 4);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (13234567890, 3, 8);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (45678901234, 5, 5);
INSERT INTO Reserva (cpf_pessoa, cod_sala, cod_turma) VALUES (12234567890, 5, 9);


/* CASOS: MatrÍcula e Monitora */
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (12345678901, 1, 95, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (12345678901, 3, 100, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (12345678901, 4, 88, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (12345678901, 6, 92, 'INATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (45678901234, 1, 0, 'INATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (45678901234, 2, 80, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (56789012345, 1, 100, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (56789012345, 5, 60, 'INATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (67890123456, 2, 75, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (67890123456, 9, 70, 'ATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (78901234567, 7, 100, 'INATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (90123456789, 3, 50, 'INATIVO');
INSERT INTO Matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES (89012345678, 10, 90, 'ATIVO');

INSERT INTO Monitora (cpf_aluno, cod_turma) VALUES (78901234567, 1);
INSERT INTO Monitora (cpf_aluno, cod_turma) VALUES (78901234567, 5);
INSERT INTO Monitora (cpf_aluno, cod_turma) VALUES (45678901234, 5);
INSERT INTO Monitora (cpf_aluno, cod_turma) VALUES (67890123456, 3);


/* CASOS: Avaliacao */
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (1, 1, 'PROVA', 30, TO_DATE('2026-09-15', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (1, 2, 'PROJETO', 40, TO_DATE('2026-10-30', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (1, 3, 'PROVA', 30, TO_DATE('2026-12-01', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (2, 1, 'LISTA', 0, TO_DATE('2026-09-01', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (3, 1, 'PROVA', 50, TO_DATE('2026-09-22', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (3, 2, 'PROVA', 50, TO_DATE('2026-11-10', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (4, 1, 'MINI-PROVA', 20, TO_DATE('2026-09-10', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (4, 2, 'MINI-PROVA', 20, TO_DATE('2026-10-01', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (4, 3, 'PROVA', 60, TO_DATE('2026-11-20', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (5, 1, 'PROVA', 50, TO_DATE('2026-04-20', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (5, 2, 'PROVA', 50, TO_DATE('2026-06-15', 'YYYY-MM-DD'));
INSERT INTO Avaliacao (cod_turma, num_avaliacao, tipo, peso, data) VALUES (6, 1, 'PROJETO', 100, TO_DATE('2026-06-30', 'YYYY-MM-DD'));

INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (1, 12345678901, 1, 8.50);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (1, 45678901234, 1, 0.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (1, 56789012345, 1, 10.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (2, 45678901234, 1, 10.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (2, 67890123456, 1, 8.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (3, 12345678901, 1, 7.25);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (3, 90123456789, 1, 3.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (4, 12345678901, 1, 9.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (4, 12345678901, 2, 6.50);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (5, 56789012345, 1, 4.00);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (5, 56789012345, 2, NULL);
INSERT INTO Desempenho_em (cod_turma, cpf_aluno, num_avaliacao, nota) VALUES (6, 12345678901, 1, 10.00);


/* CAOS: Vincula-se a */
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (12345678901, 1, TO_DATE('2025-08-04', 'YYYY-MM-DD'), 'ATIVO', 8.75, 'SISU', NULL);
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (45678901234, 2, TO_DATE('2024-03-04', 'YYYY-MM-DD'), 'TRANSFERIDO', 6.10, 'SISU', TO_DATE('2025-02-28', 'YYYY-MM-DD'));
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (45678901234, 1, TO_DATE('2025-03-03', 'YYYY-MM-DD'), 'ATIVO', 7.30, 'TRANSFERENCIA INTERNA', NULL);
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (56789012345, 3, TO_DATE('2018-03-05', 'YYYY-MM-DD'), 'CONCLUIDO', 8.00, 'SISU', TO_DATE('2022-12-16', 'YYYY-MM-DD'));
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (56789012345, 1, TO_DATE('2023-03-06', 'YYYY-MM-DD'), 'ATIVO', 9.20, 'PORTADOR DE DIPLOMA', NULL);
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (67890123456, 2, TO_DATE('2025-08-04', 'YYYY-MM-DD'), 'ATIVO', 7.80, 'TRANSFERENCIA EXTERNA', NULL);
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (78901234567, 1, TO_DATE('2021-03-01', 'YYYY-MM-DD'), 'CONCLUIDO', 8.90, 'SISU', TO_DATE('2025-12-19', 'YYYY-MM-DD'));
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (78901234567, 5, TO_DATE('2026-03-02', 'YYYY-MM-DD'), 'CANCELADO', NULL, 'PORTADOR DE DIPLOMA', TO_DATE('2026-03-02', 'YYYY-MM-DD'));
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (90123456789, 3, TO_DATE('2024-03-04', 'YYYY-MM-DD'), 'CANCELADO', 3.00, 'SISU', TO_DATE('2025-08-01', 'YYYY-MM-DD'));
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (90123456789, 3, TO_DATE('2026-03-02', 'YYYY-MM-DD'), 'TRANCADO', NULL, 'SISU', NULL);
INSERT INTO Vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, status, coeficiente_rendimento, forma_ingresso, data_saida)
VALUES (89012345678, 5, TO_DATE('2026-08-03', 'YYYY-MM-DD'), 'ATIVO', NULL, 'PORTADOR DE DIPLOMA', NULL);

COMMIT;
