
-- Povoamento da Tabela

-- pessoa

INSERT INTO pessoa
(usuario, cpf, email, nome_completo, senha, identidade_genero, data_nasc)
VALUES
('ana.silva', '12345678901', 'ana.silva@exemplo.com', 'Ana Silva',
 'ana123', 'Mulher trans', TO_DATE('2002-05-14', 'YYYY-MM-DD'));

INSERT INTO pessoa
(usuario, cpf, email, nome_completo, senha, identidade_genero, data_nasc)
VALUES
('bruno.souza', '23456789012', 'bruno.souza@exemplo.com', 'Bruno Souza',
 'bruno123', 'Homem cis', TO_DATE('1980-08-20', 'YYYY-MM-DD'));

INSERT INTO pessoa
(usuario, cpf, email, nome_completo, senha, identidade_genero, data_nasc)
VALUES
('carla.lima', '34567890123', 'carla.lima@exemplo.com', 'Carla Lima',
 'carla123', 'Mulher cis', TO_DATE('2003-01-10', 'YYYY-MM-DD'));

INSERT INTO pessoa
(usuario, cpf, email, nome_completo, senha, identidade_genero, data_nasc)
VALUES
('diego.alves', '45678901234', 'diego.alves@exemplo.com', 'Diego Alves',
 'diego123', 'Homem trans', TO_DATE('2002-11-25', 'YYYY-MM-DD'));

INSERT INTO pessoa
(usuario, cpf, email, nome_completo, senha, identidade_genero, data_nasc)
VALUES
('eduarda.costa', '56789012345', 'eduarda.costa@exemplo.com', 'Eduarda Costa',
 'eduarda123', 'Não-binário', TO_DATE('2004-03-08', 'YYYY-MM-DD'));

INSERT INTO pessoa
(usuario, cpf, email, nome_completo, senha, identidade_genero, data_nasc)
VALUES
('felipe.rocha', '67890123456', 'felipe.rocha@exemplo.com', 'Felipe Rocha',
 'felipe123', 'Outro', TO_DATE('2001-07-19', 'YYYY-MM-DD'));

-- telefone das pessoas

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880001', '12345678901');

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880002', '12345678901');

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880003', '23456789012');

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880004', '34567890123');

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880005', '45678901234');

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880006', '56789012345');

INSERT INTO telefone_da_pessoa (telefone, cpf_pessoa)
VALUES ('81988880007', '67890123456');

-- alunos

INSERT INTO aluno (num_matricula, cpf_pessoa)
VALUES ('20260000001', '34567890123');

INSERT INTO aluno (num_matricula, cpf_pessoa)
VALUES ('20260000002', '45678901234');

INSERT INTO aluno (num_matricula, cpf_pessoa)
VALUES ('20260000003', '56789012345');

INSERT INTO aluno (num_matricula, cpf_pessoa)
VALUES ('20260000004', '67890123456');

-- professores

INSERT INTO professor (titulacao, cpf_pessoa, num_matricula_func)
VALUES ('Doutorado', '12345678901', '10000000001');

INSERT INTO professor (titulacao, cpf_pessoa, num_matricula_func)
VALUES ('Mestrado', '23456789012', '10000000002');

-- departamento

INSERT INTO departamento (telefone, localizacao, sigla, nome)
VALUES ('81333330001', 'Centro de Informática', 'CIN', 'Departamento de Informática');

INSERT INTO departamento (telefone, localizacao, sigla, nome)
VALUES ('81333330002', 'Centro de Ciências Exatas', 'DCC', 'Departamento de Ciências Exatas');

-- disciplinas

INSERT INTO disciplina
(ch_pratica, nome, num_creditos, codigo, ementa, ch_teorica)
VALUES
(30, 'Programação Orientada a Objetos', 4, 'POO101',
 'Conceitos de classes, objetos, herança, polimorfismo e encapsulamento.',
 30);

INSERT INTO disciplina
(ch_pratica, nome, num_creditos, codigo, ementa, ch_teorica)
VALUES
(30, 'Banco de Dados', 4, 'BD101',
 'Modelagem de dados, modelo relacional, SQL e normalização.',
 30);

INSERT INTO disciplina
(ch_pratica, nome, num_creditos, codigo, ementa, ch_teorica)
VALUES
(15, 'Algoritmos', 4, 'ALG101',
 'Estudo de algoritmos, estruturas de controle e resolução de problemas.',
 45);

INSERT INTO disciplina
(ch_pratica, nome, num_creditos, codigo, ementa, ch_teorica)
VALUES
(15, 'Redes de Computadores', 4, 'RED101',
 'Fundamentos de redes, protocolos e comunicação entre computadores.',
 45);

-- salas

INSERT INTO sala (andar, bloco, capacidade, cod_sala, predio)
VALUES (1, 'A', 40, 101, 'Bloco de Informática');

INSERT INTO sala (andar, bloco, capacidade, cod_sala, predio)
VALUES (2, 'B', 35, 102, 'Bloco de Informática');

INSERT INTO sala (andar, bloco, capacidade, cod_sala, predio)
VALUES (0, 'C', 50, 103, 'Centro de Ciências Exatas');

-- cursos

INSERT INTO curso
(turno, cpf_coordenador, nome, grau_academico, codigo_id,
 sigla_departamento, num_vagas, modalidade, ch_total)
VALUES
('Integral', '12345678901', 'Ciência da Computação',
 'Bacharelado', curso_seq.NEXTVAL, 'CIN', 40, 'Presencial', 3000);

INSERT INTO curso
(turno, cpf_coordenador, nome, grau_academico, codigo_id,
 sigla_departamento, num_vagas, modalidade, ch_total)
VALUES
('Noturno', '23456789012', 'Sistemas de Informação',
 'Bacharelado', curso_seq.NEXTVAL, 'DCC', 35, 'Presencial', 2800);

-- turmas

INSERT INTO turma
(codigo_disciplina, num_vagas, cod_turma, turno, periodo)
VALUES ('POO101', 40, 101, 'Matutino', '2026.1');

INSERT INTO turma
(codigo_disciplina, num_vagas, cod_turma, turno, periodo)
VALUES ('BD101', 35, 102, 'Vespertino', '2026.1');

INSERT INTO turma
(codigo_disciplina, num_vagas, cod_turma, turno, periodo)
VALUES ('ALG101', 40, 201, 'Noturno', '2026.1');

INSERT INTO turma
(codigo_disciplina, num_vagas, cod_turma, turno, periodo)
VALUES ('RED101', 35, 202, 'Integral', '2026.1');

-- avalaição

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-03-20', 'YYYY-MM-DD'), 1.00, 101, 'Prova', 1);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-05-15', 'YYYY-MM-DD'), 1.00, 101, 'Trabalho', 2);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-03-22', 'YYYY-MM-DD'), 1.00, 102, 'Prova', 1);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-05-18', 'YYYY-MM-DD'), 1.00, 102, 'Projeto', 2);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-03-25', 'YYYY-MM-DD'), 1.00, 201, 'Prova', 1);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-05-20', 'YYYY-MM-DD'), 1.00, 201, 'Trabalho', 2);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-03-27', 'YYYY-MM-DD'), 1.00, 202, 'Prova', 1);

INSERT INTO avaliacao
(data_avaliacao, peso, cod_turma, tipo, num_avaliacao)
VALUES (TO_DATE('2026-05-22', 'YYYY-MM-DD'), 1.00, 202, 'Projeto', 2);

-- matriculas

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 95, 101, '34567890123');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 90, 102, '34567890123');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Aprovado', 85, 101, '45678901234');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 92, 201, '45678901234');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 98, 102, '56789012345');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 88, 202, '56789012345');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 91, 201, '67890123456');

INSERT INTO matricula (situacao, frequencia, cod_turma, cpf_aluno)
VALUES ('Matriculado', 94, 202, '67890123456');

-- pré-requisitos

INSERT INTO pre_requisito (codigo_requisito, codigo_disciplina)
VALUES ('ALG101', 'POO101');

INSERT INTO pre_requisito (codigo_requisito, codigo_disciplina)
VALUES ('ALG101', 'BD101');

INSERT INTO pre_requisito (codigo_requisito, codigo_disciplina)
VALUES ('POO101', 'RED101');

-- professores ministrando turmas

INSERT INTO ministra (cod_turma, cpf_professor)
VALUES (101, '12345678901');

INSERT INTO ministra (cod_turma, cpf_professor)
VALUES (102, '12345678901');

INSERT INTO ministra (cod_turma, cpf_professor)
VALUES (201, '23456789012');

INSERT INTO ministra (cod_turma, cpf_professor)
VALUES (202, '23456789012');

-- monitoria

INSERT INTO monitora (cod_turma, cpf_aluno)
VALUES (101, '34567890123');

INSERT INTO monitora (cod_turma, cpf_aluno)
VALUES (102, '56789012345');

-- disciplinas compondo a grade dos cursos

-- os códigos correspondem aos cursos inseridos acima,

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (1, 1, 'Obrigatória', 'ALG101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (2, 1, 'Obrigatória', 'POO101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (3, 1, 'Obrigatória', 'BD101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (4, 1, 'Eletiva', 'RED101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (1, 2, 'Obrigatória', 'ALG101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (2, 2, 'Obrigatória', 'BD101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (3, 2, 'Obrigatória', 'POO101');

INSERT INTO compoe_a_grade_curricular_de
(periodo_sugerido, codigo_id, tipo, codigo_disciplina)
VALUES (4, 2, 'Eletiva', 'RED101');

-- nota dos alunos
-- nota correspondendo a uma matrícula e a uma avaliação da turma.

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (8.50, 1, '34567890123', 101);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (9.00, 2, '34567890123', 101);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (7.50, 1, '45678901234', 101);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (8.00, 1, '34567890123', 102);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (9.50, 2, '34567890123', 102);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (8.00, 1, '56789012345', 102);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (7.00, 1, '45678901234', 201);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (8.50, 2, '45678901234', 201);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (9.00, 1, '67890123456', 201);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (8.00, 1, '56789012345', 202);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (9.00, 2, '56789012345', 202);

INSERT INTO desempenho_em (nota, num_avaliacao, cpf_aluno, cod_turma)
VALUES (7.50, 1, '67890123456', 202);

-- vinculo aluno curso

INSERT INTO vincula_se_a
(forma_ingresso, cpf_aluno, coeficiente_rendimento, data_saida,
 codigo_curso, situacao, data_ingresso)
VALUES
('SISU', '34567890123', 8.50, NULL, 1, 'Ativo',
 TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO vincula_se_a
(forma_ingresso, cpf_aluno, coeficiente_rendimento, data_saida,
 codigo_curso, situacao, data_ingresso)
VALUES
('Vestibular', '45678901234', 7.80, NULL, 1, 'Ativo',
 TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO vincula_se_a
(forma_ingresso, cpf_aluno, coeficiente_rendimento, data_saida,
 codigo_curso, situacao, data_ingresso)
VALUES
('SISU', '56789012345', 9.10, NULL, 2, 'Ativo',
 TO_DATE('2025-03-01', 'YYYY-MM-DD'));

INSERT INTO vincula_se_a
(forma_ingresso, cpf_aluno, coeficiente_rendimento, data_saida,
 codigo_curso, situacao, data_ingresso)
VALUES
('Transferência', '67890123456', 8.00, NULL, 2, 'Ativo',
 TO_DATE('2025-03-01', 'YYYY-MM-DD'));

-- lotação professores

INSERT INTO lotacao
(regime_trabalho, data_encerramento, sigla_dept, cpf_professor, data_admissao)
VALUES
('Dedicação exclusiva', NULL, 'CIN', '12345678901',
 TO_DATE('2018-02-01', 'YYYY-MM-DD'));

INSERT INTO lotacao
(regime_trabalho, data_encerramento, sigla_dept, cpf_professor, data_admissao)
VALUES
('40 horas', NULL, 'DCC', '23456789012',
 TO_DATE('2020-08-01', 'YYYY-MM-DD'));

-- blibiografia

INSERT INTO bibliografia_disciplina (referencia, codigo_disciplina)
VALUES ('Introdução à Programação Orientada a Objetos', 'POO101');

INSERT INTO bibliografia_disciplina (referencia, codigo_disciplina)
VALUES ('Fundamentos de Banco de Dados', 'BD101');

INSERT INTO bibliografia_disciplina (referencia, codigo_disciplina)
VALUES ('Algoritmos e Lógica de Programação', 'ALG101');

INSERT INTO bibliografia_disciplina (referencia, codigo_disciplina)
VALUES ('Redes de Computadores: Uma Abordagem Top-Down', 'RED101');

-- horarios das turmas

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Segunda 08:00-10:00', 101);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Quarta 08:00-10:00', 101);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Terça 14:00-16:00', 102);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Quinta 14:00-16:00', 102);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Segunda 19:00-21:00', 201);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Quarta 19:00-21:00', 201);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Terça 08:00-10:00', 202);

INSERT INTO horario_turma (horario, cod_turma)
VALUES ('Sexta 08:00-10:00', 202);

-- reserva das salas

INSERT INTO reserva (cod_turma, cpf_pessoa, cod_sala)
VALUES (101, '12345678901', 101);

INSERT INTO reserva (cod_turma, cpf_pessoa, cod_sala)
VALUES (102, '12345678901', 102);

INSERT INTO reserva (cod_turma, cpf_pessoa, cod_sala)
VALUES (201, '23456789012', 103);

INSERT INTO reserva (cod_turma, cpf_pessoa, cod_sala)
VALUES (202, '23456789012', 101);

COMMIT;