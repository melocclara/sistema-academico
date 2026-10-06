-- segue a mesma ordem do criacao.sql !
-- TABELA PESSOA
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('20000000001', 'Helena Duarte Campos', DATE '1978-05-12', 'Mulher cis', 'helena.campos@professor.edu.br', 'hdcampos', 'Helena#1978x');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('20000000002', 'Marcos Vinícius Teles', DATE '1982-11-03', 'Homem cis', 'marcos.teles@professor.edu.br', 'mvteles', 'Teles!8211mv');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('20000000003', 'Renata Albuquerque Sá', DATE '1985-02-20', 'Mulher cis', 'renata.sa@professor.edu.br', 'ralsa', 'Rsa@2020mat');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('20000000004', 'Fábio Henrique Lins', DATE '1975-07-08', 'Homem cis', 'fabio.lins@professor.edu.br', 'fhlins', 'Lins$1975fh');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('20000000005', 'Juliana Costa Moraes', DATE '1990-09-30', 'Mulher trans', 'juliana.moraes@professor.edu.br', 'jcmoraes', 'Moraes2022!jc');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000001', 'Ana Beatriz Ferreira', DATE '2005-04-17', 'Mulher cis', 'ana.ferreira@aluno.edu.br', 'anabf', 'Ana@2005bd');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000002', 'Bruno Carvalho Melo', DATE '2004-10-02', 'Homem cis', 'bruno.melo@aluno.edu.br', 'brunocm', 'Bruno#7781');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000003', 'Camila Souza Nogueira', DATE '2005-01-25', NULL, 'camila.nogueira@aluno.edu.br', 'camilasn', 'Cami2025!sn');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000004', 'Diego Araújo Pires', DATE '2004-06-11', 'Homem cis', 'diego.pires@aluno.edu.br', 'diegoap', 'Diego$Pires4');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000005', 'Pedro Elias Rocha', DATE '2007-03-14', 'Homem cis', 'pedro.rocha@aluno.edu.br', 'pedroer', 'Pedro2026@r');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000006', 'Marina Liz Rocha', DATE '2007-12-01', 'Mulher cis', 'marina.rocha@aluno.edu.br', 'marinalr', 'Marina!2026');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000007', 'Gabriel Santos Oliveira', DATE '2006-09-19', 'Não-binário', 'gabriel.oliveira@aluno.edu.br', 'gabrielso', 'Gabi#so2026');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000008', 'Rafael Monteiro Barros', DATE '2000-02-27', 'Homem cis', 'rafael.barros@aluno.edu.br', 'rafaelmb', 'Rafa@Mb2000');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('10000000009', 'Larissa Gomes Tavares', DATE '2007-05-05', 'Mulher cis', 'larissa.tavares@aluno.edu.br', 'larissagt', 'Lari$2026gt');
INSERT INTO pessoa (cpf, nome_completo, data_nasc, identidade_genero, email, usuario, senha) VALUES ('01000000010', 'Tiago Batista Freitas', DATE '2003-12-12', 'Homem trans', 'tiago.freitas@aluno.edu.br', 'tiagobf', 'Tiago#Bf03');

-- TABELA TELEFONE_PESSOA
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000001', '81991110001');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000001', '8133011001');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000002', '81991110002');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000003', '81991110003');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000004', '81991110004');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000004', '8134410004');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('20000000005', '81991110005');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000001', '81992220001');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000001', '81992220011');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000002', '81992220002');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000004', '81992220004');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000005', '81992220005');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000005', '8132451020');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000006', '81992220006');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000006', '8132451020');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000008', '81992220008');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('10000000009', '81992220009');
INSERT INTO telefone_pessoa (cpf_pessoa, telefone) VALUES ('01000000010', '81992220010');

-- TABELA ALUNO
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000001', '20251000001');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000002', '20251000002');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000003', '20251000003');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000004', '20251000004');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000005', '20261000001');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000006', '20261000002');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000007', '20261000003');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000008', '20261000004');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('10000000009', '20261000005');
INSERT INTO aluno (cpf_pessoa, num_matricula) VALUES ('01000000010', '20251000005');

-- TABELA PROFESSOR
INSERT INTO professor (cpf_pessoa, num_matricula_func, titulacao) VALUES ('20000000001', 'PROF0000001', 'Doutorado');
INSERT INTO professor (cpf_pessoa, num_matricula_func, titulacao) VALUES ('20000000002', 'PROF0000002', 'Doutorado');
INSERT INTO professor (cpf_pessoa, num_matricula_func, titulacao) VALUES ('20000000003', 'PROF0000003', 'Mestrado');
INSERT INTO professor (cpf_pessoa, num_matricula_func, titulacao) VALUES ('20000000004', 'PROF0000004', 'Doutorado');
INSERT INTO professor (cpf_pessoa, num_matricula_func, titulacao) VALUES ('20000000005', 'PROF0000005', 'Especialização');

-- TABELA DEPARTAMENTO
INSERT INTO departamento (sigla, nome, localizacao, telefone) VALUES ('DC', 'Departamento de Computação', 'Prédio de Computação, Campus Central', '8121260001');
INSERT INTO departamento (sigla, nome, localizacao, telefone) VALUES ('DMAT', 'Departamento de Matemática', 'Prédio de Ciências Exatas, Campus Central', '8121260002');

-- TABELA CURSO
INSERT INTO curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento) VALUES (curso_seq.NEXTVAL, 'Ciência da Computação', 3210, 'Presencial', 'Integral', 100, 'Bacharelado', '20000000001', 'DC');
INSERT INTO curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento) VALUES (curso_seq.NEXTVAL, 'Engenharia da Computação', 3600, 'Presencial', 'Integral', 60, 'Bacharelado', '20000000002', 'DC');
INSERT INTO curso (codigo_id, nome, ch_total, modalidade, turno, num_vagas, grau_academico, cpf_coordenador, sigla_departamento) VALUES (curso_seq.NEXTVAL, 'Matemática', 2900, 'Presencial', 'Noturno', 40, 'Licenciatura', '20000000003', 'DMAT');

-- TABELA DISCIPLINA
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('CC101', 'Introdução à Programação', 'Algoritmos e lógica de programação. Variáveis, tipos de dados, estruturas condicionais e de repetição. Funções. Introdução à linguagem Python.', 30, 30, 4);
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('CC102', 'Algoritmos e Estruturas de Dados', 'Análise de complexidade. Listas, pilhas, filas, árvores e grafos. Algoritmos de ordenação e busca.', 60, 30, 6);
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('CC201', 'Banco de Dados', 'Modelagem conceitual e relacional. Normalização. Linguagem SQL. Transações e controle de concorrência.', 45, 15, 4);
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('CC202', 'Engenharia de Software', 'Processos de desenvolvimento de software. Engenharia de requisitos. Projeto, testes e manutenção de software.', 60, 0, 4);
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('MAT101', 'Cálculo Diferencial e Integral 1', 'Limites e continuidade. Derivadas e aplicações. Integrais definidas e indefinidas. Teorema Fundamental do Cálculo.', 90, 0, 6);
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('MAT102', 'Álgebra Linear', 'Sistemas lineares e matrizes. Espaços vetoriais. Transformações lineares. Autovalores e autovetores.', 60, 0, 4);
INSERT INTO disciplina (codigo, nome, ementa, ch_teorica, ch_pratica, num_creditos) VALUES ('MAT201', 'Matemática Discreta', 'Lógica proposicional. Conjuntos, relações e funções. Indução matemática. Combinatória e grafos.', 60, 0, 4);

-- TABELA BIBLIOGRAFIA_DISCIPLINA
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('CC101', 'MENEZES, N. N. C. Introdução à programação com Python. São Paulo: Novatec.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('CC102', 'CORMEN, T. H. et al. Algoritmos: teoria e prática. Rio de Janeiro: Elsevier.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('CC102', 'ZIVIANI, N. Projeto de algoritmos com implementações em Pascal e C. São Paulo: Cengage Learning.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('CC201', 'ELMASRI, R.; NAVATHE, S. B. Sistemas de banco de dados. São Paulo: Pearson.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('CC201', 'SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. Sistema de banco de dados. Rio de Janeiro: Elsevier.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('CC202', 'SOMMERVILLE, I. Engenharia de software. São Paulo: Pearson.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('MAT101', 'STEWART, J. Cálculo. v. 1. São Paulo: Cengage Learning.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('MAT102', 'BOLDRINI, J. L. et al. Álgebra linear. São Paulo: Harbra.');
INSERT INTO bibliografia_disciplina (codigo_disciplina, referencia) VALUES ('MAT201', 'ROSEN, K. H. Matemática discreta e suas aplicações. Porto Alegre: AMGH.');

-- TABELA TURMA
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T01', '2026.1', 'Matutino', 40, 'CC101');
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T02', '2026.1', 'Matutino', 50, 'MAT101');
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T03', '2026.1', 'Vespertino', 40, 'CC102');
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T04', '2026.1', 'Vespertino', 40, 'MAT201');
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T05', '2026.2', 'Vespertino', 45, 'CC201');
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T06', '2026.2', 'Matutino', 35, 'CC202');
INSERT INTO turma (cod_turma, periodo, turno, num_vagas, codigo_disciplina) VALUES ('T07', '2026.2', 'Matutino', 50, 'MAT102');

-- TABELA HORARIO_TURMA
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T01', '24M12');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T02', '35M12');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T02', '6M34');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T03', '35T12');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T04', '24T34');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T05', '24T12');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T06', '35M34');
INSERT INTO horario_turma (cod_turma, horario) VALUES ('T07', '24M12');

-- TABELA SALA
INSERT INTO sala (cod_sala, capacidade, predio, bloco, andar) VALUES ('A101', 60, 'Prédio de Computação', 'A', 1);
INSERT INTO sala (cod_sala, capacidade, predio, bloco, andar) VALUES ('A102', 50, 'Prédio de Computação', 'A', 1);
INSERT INTO sala (cod_sala, capacidade, predio, bloco, andar) VALUES ('LAB01', 40, 'Prédio de Computação', 'A', 0);
INSERT INTO sala (cod_sala, capacidade, predio, bloco, andar) VALUES ('B201', 60, 'Prédio de Ciências Exatas', 'B', 2);

-- TABELA AVALIACAO
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T01', 'Prova', 0.4, DATE '2026-04-14');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T01', 'Prova', 0.6, DATE '2026-06-23');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T02', 'Lista', 0.3, DATE '2026-04-10');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T02', 'Prova', 0.7, DATE '2026-06-30');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T03', 'Lista', 0.2, DATE '2026-03-31');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T03', 'Prova', 0.4, DATE '2026-05-05');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (3, 'T03', 'Trabalho', 0.4, DATE '2026-06-16');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T04', 'Prova', 0.50, DATE '2026-04-22');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T04', 'Seminário', 0.50, DATE '2026-06-17');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T05', 'Prova', 0.40, DATE '2026-09-22');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T05', 'Trabalho', 0.60, DATE '2026-11-24');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T06', 'Apresentação', 0.30, DATE '2026-09-29');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T06', 'Prova', 0.70, DATE '2026-12-01');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (1, 'T07', 'Lista', 0.30, DATE '2026-09-15');
INSERT INTO avaliacao (num_avaliacao, cod_turma, tipo, peso, data_avaliacao) VALUES (2, 'T07', 'Prova', 0.70, DATE '2026-11-17');

-- TABELA MATRICULA
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000005', 'T01', 95, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000006', 'T01', 88, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000007', 'T01', 60, 'Reprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000008', 'T01', 100, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000005', 'T02', 90, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000006', 'T02', 80, 'Reprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000007', 'T02', 55, 'Reprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000009', 'T02', 92, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000001', 'T03', 98, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000002', 'T03', 85, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000003', 'T03', 92, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000004', 'T03', 78, 'Reprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('01000000010', 'T03', 90, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000001', 'T04', 96, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000002', 'T04', 80, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000003', 'T04', 88, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000004', 'T04', 82, 'Aprovado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('01000000010', 'T04', 30, 'Trancado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000001', 'T05', 100, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000002', 'T05', 88, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000003', 'T05', 94, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000001', 'T06', 100, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000002', 'T06', 90, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000003', 'T06', 96, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('01000000010', 'T06', 92, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000004', 'T07', 85, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000005', 'T07', 97, 'Matriculado');
INSERT INTO matricula (cpf_aluno, cod_turma, frequencia, situacao) VALUES ('10000000009', 'T07', 100, 'Matriculado');

-- TABELA MONITORA
INSERT INTO monitora (cpf_aluno, cod_turma) VALUES ('10000000001', 'T01');
INSERT INTO monitora (cpf_aluno, cod_turma) VALUES ('10000000003', 'T02');
INSERT INTO monitora (cpf_aluno, cod_turma) VALUES ('10000000002', 'T07');

-- TABELA PRE_REQUISITO
INSERT INTO pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CC102', 'CC101');
INSERT INTO pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CC201', 'CC102');
INSERT INTO pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CC201', 'MAT201');
INSERT INTO pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('CC202', 'CC102');
INSERT INTO pre_requisito (codigo_disciplina, codigo_requisito) VALUES ('MAT102', 'MAT101');

-- TABELA MINISTRA
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000001', 'T01');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000005', 'T01');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000004', 'T02');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000001', 'T03');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000003', 'T04');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000002', 'T05');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000001', 'T06');
INSERT INTO ministra (cpf_professor, cod_turma) VALUES ('20000000003', 'T07');

-- TABELA COMPOE_A_GRADE_CURRICULAR_DE
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC101', 1, 'Obrigatória', 1);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT101', 1, 'Obrigatória', 1);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC102', 1, 'Obrigatória', 2);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT102', 1, 'Obrigatória', 2);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT201', 1, 'Obrigatória', 3);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC201', 1, 'Obrigatória', 4);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC202', 1, 'Obrigatória', 5);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC101', 2, 'Obrigatória', 1);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT101', 2, 'Obrigatória', 1);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC102', 2, 'Obrigatória', 2);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT102', 2, 'Obrigatória', 2);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC202', 2, 'Obrigatória', 6);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC201', 2, 'Eletiva', NULL);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT101', 3, 'Obrigatória', 1);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT102', 3, 'Obrigatória', 2);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('MAT201', 3, 'Obrigatória', 3);
INSERT INTO compoe_a_grade_curricular_de (codigo_disciplina, codigo_id, tipo, periodo_sugerido) VALUES ('CC101', 3, 'Eletiva', NULL);

-- TABELA DESEMPENHO_EM
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000005', 'T01', 1, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000005', 'T01', 2, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000006', 'T01', 1, 7.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000006', 'T01', 2, 7.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000007', 'T01', 1, 6.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000007', 'T01', 2, 5.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000008', 'T01', 1, 9.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000008', 'T01', 2, 10.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000005', 'T02', 1, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000005', 'T02', 2, 7.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000006', 'T02', 1, 6.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000006', 'T02', 2, 3.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000007', 'T02', 1, 5.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000007', 'T02', 2, 2.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000009', 'T02', 1, 8.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000009', 'T02', 2, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T03', 1, 10.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T03', 2, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T03', 3, 9.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T03', 1, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T03', 2, 7.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T03', 3, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T03', 1, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T03', 2, 8.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T03', 3, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000004', 'T03', 1, 7.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000004', 'T03', 2, 4.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000004', 'T03', 3, 5.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('01000000010', 'T03', 1, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('01000000010', 'T03', 2, 7.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('01000000010', 'T03', 3, 8.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T04', 1, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T04', 2, 9.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T04', 1, 7.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T04', 2, 7.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T04', 1, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T04', 2, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000004', 'T04', 1, 7.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000004', 'T04', 2, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('01000000010', 'T04', 1, 6.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T05', 1, 8.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T05', 1, 6.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T05', 1, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000001', 'T06', 1, 9.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000002', 'T06', 1, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000003', 'T06', 1, 7.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('01000000010', 'T06', 1, 8.5);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000004', 'T07', 1, 7.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000005', 'T07', 1, 8.0);
INSERT INTO desempenho_em (cpf_aluno, cod_turma, num_avaliacao, nota) VALUES ('10000000009', 'T07', 1, 9.5);

-- TABELA VINCULA_SE_A
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000001', 1, DATE '2025-03-10', 'Ativo', 9.3, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000002', 1, DATE '2025-03-10', 'Ativo', 7.4, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000003', 1, DATE '2025-03-10', 'Ativo', 8.6, 'Vestibular', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000004', 1, DATE '2025-03-10', 'Ativo', 6.2, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000005', 1, DATE '2026-03-09', 'Ativo', 8.3, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000006', 1, DATE '2026-03-09', 'Ativo', 5.8, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000007', 1, DATE '2026-03-09', 'Trancado', 4.1, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000008', 3, DATE '2019-03-11', 'Formado', 8.9, 'Vestibular', DATE '2023-12-15');
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000008', 2, DATE '2026-03-09', 'Ativo', 9.8, 'Outro', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('10000000009', 3, DATE '2026-03-09', 'Ativo', 8.2, 'SISU', NULL);
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('01000000010', 2, DATE '2023-03-13', 'Desligado', 5.2, 'SISU', DATE '2025-02-14');
INSERT INTO vincula_se_a (cpf_aluno, codigo_curso, data_ingresso, situacao, coeficiente_rendimento, forma_ingresso, data_saida) VALUES ('01000000010', 1, DATE '2025-03-10', 'Ativo', 7.9, 'Transferência', NULL);

-- TABELA LOTACAO
INSERT INTO lotacao (cpf_professor, sigla_dept, data_admissao, data_encerramento, regime_trabalho) VALUES ('20000000001', 'DC', DATE '2010-08-02', NULL, 'Dedicação exclusiva');
INSERT INTO lotacao (cpf_professor, sigla_dept, data_admissao, data_encerramento, regime_trabalho) VALUES ('20000000002', 'DC', DATE '2014-03-10', NULL, 'Dedicação exclusiva');
INSERT INTO lotacao (cpf_professor, sigla_dept, data_admissao, data_encerramento, regime_trabalho) VALUES ('20000000003', 'DMAT', DATE '2016-08-01', NULL, '40 horas');
INSERT INTO lotacao (cpf_professor, sigla_dept, data_admissao, data_encerramento, regime_trabalho) VALUES ('20000000004', 'DC', DATE '2012-02-13', DATE '2018-07-31', 'Dedicação exclusiva');
INSERT INTO lotacao (cpf_professor, sigla_dept, data_admissao, data_encerramento, regime_trabalho) VALUES ('20000000004', 'DMAT', DATE '2018-08-01', NULL, 'Dedicação exclusiva');
INSERT INTO lotacao (cpf_professor, sigla_dept, data_admissao, data_encerramento, regime_trabalho) VALUES ('20000000005', 'DC', DATE '2022-03-07', NULL, '20 horas');

-- TABELA RESERVA
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000005', 'LAB01', 'T01');
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000004', 'B201', 'T02');
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000001', 'A101', 'T03');
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000003', 'B201', 'T04');
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000002', 'A102', 'T05');
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000001', 'A101', 'T06');
INSERT INTO reserva (cpf_pessoa, cod_sala, cod_turma) VALUES ('20000000003', 'B201', 'T07');

COMMIT;