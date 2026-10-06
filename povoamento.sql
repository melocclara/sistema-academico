
-- Professores
INSERT INTO Pessoa VALUES ('10000000001','Carlos Eduardo Menezes',DATE '1974-03-14','Homem cis','carlos.menezes@ufpe.br','cmenezes','$2b$12$Qa1xZp0Lm8Ru');
INSERT INTO Pessoa VALUES ('10000000002','Mariana Albuquerque Santos',DATE '1981-07-22','Mulher cis','mariana.santos@ufpe.br','malbuquerque','$2b$12$Wd7kLp3Tn5Vc');
INSERT INTO Pessoa VALUES ('10000000003','Roberto Cavalcanti Lima',DATE '1969-11-05','Homem cis','roberto.lima@ufpe.br','rclima','$2b$12$Hy4mBq9Xs2Je');
INSERT INTO Pessoa VALUES ('10000000004','Juliana Tavares Rocha',DATE '1985-01-30','Mulher cis','juliana.rocha@ufpe.br','jtavares','$2b$12$Nf8cRt6Ku1Ao');
INSERT INTO Pessoa VALUES ('10000000005','Fernando Bezerra Costa',DATE '1978-09-18','Homem cis','fernando.costa@ufpe.br','fbezerra','$2b$12$Ls2vGd5Pw7Mi');
INSERT INTO Pessoa VALUES ('10000000006','Patrícia Lins Gomes',DATE '1990-05-09','Mulher cis','patricia.gomes@ufpe.br','plins','$2b$12$Zc9hYe4Bq3Ut');
INSERT INTO Pessoa VALUES ('10000000007','Antônio Siqueira Neto',DATE '1972-12-02','Homem cis','antonio.neto@ufpe.br','asiqueira','$2b$12$Rb6nXk1Df8Oz');
-- Alunos
INSERT INTO Pessoa VALUES ('20000000001','Ana Beatriz Ferreira Lima',DATE '2007-02-11','Mulher cis','ana.lima@ufpe.br','ablima','$2b$12$Tp3wMe7Ja5Sx');
INSERT INTO Pessoa VALUES ('20000000002','Bruno Henrique Alves',DATE '2004-08-25','Homem cis','bruno.alves@ufpe.br','bhalves','$2b$12$Ek5dUq2Lc9Ny');
INSERT INTO Pessoa VALUES ('20000000003','Camila Duarte Nogueira',DATE '2006-04-17','Mulher cis','camila.nogueira@ufpe.br','cdnogueira','$2b$12$Vg1sOz8Hr4Wb');
INSERT INTO Pessoa VALUES ('20000000004','Dani Oliveira Pontes',DATE '1998-10-03','Não-binário','dani.pontes@ufpe.br','dopontes','$2b$12$Ya7jFt3Nm6Kd');
INSERT INTO Pessoa VALUES ('20000000005','Érica Souza Barbosa',DATE '2005-12-29','Mulher trans','erica.barbosa@ufpe.br','esbarbosa','$2b$12$Bn4lCw9Ge2Pu');
INSERT INTO Pessoa VALUES ('20000000006','Helena Martins Queiroz',DATE '2006-09-14','Mulher cis','helena.queiroz@ufpe.br','hmqueiroz','$2b$12$Mx8rIa5Zt1Vf');
INSERT INTO Pessoa VALUES ('20000000007','Igor Lacerda Pinheiro',DATE '2005-01-20','Homem cis','igor.pinheiro@ufpe.br','ilpinheiro','$2b$12$Dc2qHo6Yb7Ls');
INSERT INTO Pessoa VALUES ('20000000008','Joana Carvalho Medeiros',DATE '2005-05-30','Mulher cis','joana.medeiros@ufpe.br','jcmedeiros','$2b$12$Fu9eKv4Wn3Ra');
INSERT INTO Pessoa VALUES ('20000000009','Kauã Silva Ribeiro',DATE '2006-03-12','Homem cis','kaua.ribeiro@ufpe.br','ksribeiro','$2b$12$Gp5tNj1Xd8Mc');
INSERT INTO Pessoa VALUES ('20000000010','Lucas Farias Tenório',DATE '2003-06-08','Homem cis','lucas.tenorio@ufpe.br','lfarias','$2b$12$Ah6zSb3Qk9Ye');
INSERT INTO Pessoa VALUES ('20000000011','Marina Cabral Rangel',DATE '2004-07-07','Mulher cis','marina.rangel@ufpe.br','mcabral','$2b$12$Jw3uPd7Lf2Tg');

-- TELEFONE_PESSOA
INSERT INTO Telefone_pessoa VALUES ('10000000001','81987650001');
INSERT INTO Telefone_pessoa VALUES ('10000000001','8133330001');
INSERT INTO Telefone_pessoa VALUES ('10000000002','81987650002');
INSERT INTO Telefone_pessoa VALUES ('10000000003','81987650003');
INSERT INTO Telefone_pessoa VALUES ('10000000004','81987650004');
INSERT INTO Telefone_pessoa VALUES ('10000000004','8133330004');
INSERT INTO Telefone_pessoa VALUES ('10000000005','81987650005');
INSERT INTO Telefone_pessoa VALUES ('10000000006','81987650006');
INSERT INTO Telefone_pessoa VALUES ('10000000007','81987650007');
INSERT INTO Telefone_pessoa VALUES ('20000000001','81991110001');
INSERT INTO Telefone_pessoa VALUES ('20000000001','81991110101');
INSERT INTO Telefone_pessoa VALUES ('20000000002','81991110002');
INSERT INTO Telefone_pessoa VALUES ('20000000003','81991110003');
INSERT INTO Telefone_pessoa VALUES ('20000000004','81991110004');
INSERT INTO Telefone_pessoa VALUES ('20000000005','81991110005');
INSERT INTO Telefone_pessoa VALUES ('20000000006','81991110006');
INSERT INTO Telefone_pessoa VALUES ('20000000007','81991110007');
INSERT INTO Telefone_pessoa VALUES ('20000000008','81991110008');
INSERT INTO Telefone_pessoa VALUES ('20000000009','81991110009');
INSERT INTO Telefone_pessoa VALUES ('20000000010','81991110010');
INSERT INTO Telefone_pessoa VALUES ('20000000011','81991110011');

-- Departamento
INSERT INTO Departamento VALUES ('CIN','Centro de Informática','Campus Recife - Prédio do CIn','8130000001');
INSERT INTO Departamento VALUES ('DMAT','Departamento de Matemática','Campus Recife - CCEN','8130000002');
INSERT INTO Departamento VALUES ('DFIS','Departamento de Física','Campus Recife - CCEN','8130000003');

-- Aluno e Professor (especialização de Pessoa)
INSERT INTO Aluno VALUES ('20000000001','202501001');
INSERT INTO Aluno VALUES ('20000000002','202501002');
INSERT INTO Aluno VALUES ('20000000003','202501003');
INSERT INTO Aluno VALUES ('20000000004','202501004');
INSERT INTO Aluno VALUES ('20000000005','202501005');
INSERT INTO Aluno VALUES ('20000000006','202501006');
INSERT INTO Aluno VALUES ('20000000007','202501007');
INSERT INTO Aluno VALUES ('20000000008','202501008');
INSERT INTO Aluno VALUES ('20000000009','202501009');
INSERT INTO Aluno VALUES ('20000000010','202301010');
INSERT INTO Aluno VALUES ('20000000011','202301011');

INSERT INTO Professor VALUES ('10000000001','1001001','DOUTORADO');
INSERT INTO Professor VALUES ('10000000002','1001002','POS-DOUTORADO');
INSERT INTO Professor VALUES ('10000000003','1001003','DOUTORADO');
INSERT INTO Professor VALUES ('10000000004','1001004','DOUTORADO');
INSERT INTO Professor VALUES ('10000000005','1001005','MESTRADO');
INSERT INTO Professor VALUES ('10000000006','1001006','DOUTORADO');
INSERT INTO Professor VALUES ('10000000007','1001007','MESTRADO');

-- curso  (usa SEQUENCE: ids gerados 1=CC, 2=EC, 3=SI, 4=MAT)
INSERT INTO Curso (codigo_id,nome,ch_total,modalidade,turno,num_vagas,grau_academico,cpf_coordenador,sigla_departamento)
VALUES (seq_curso.NEXTVAL,'Ciência da Computação',3200,'PRESENCIAL','I',120,'BACHARELADO','10000000001','CIN');
INSERT INTO Curso (codigo_id,nome,ch_total,modalidade,turno,num_vagas,grau_academico,cpf_coordenador,sigla_departamento)
VALUES (seq_curso.NEXTVAL,'Engenharia da Computação',3600,'PRESENCIAL','I',80,'BACHARELADO','10000000002','CIN');
INSERT INTO Curso (codigo_id,nome,ch_total,modalidade,turno,num_vagas,grau_academico,cpf_coordenador,sigla_departamento)
VALUES (seq_curso.NEXTVAL,'Sistemas de Informação',3000,'PRESENCIAL','N',60,'BACHARELADO','10000000007','CIN');
INSERT INTO Curso (codigo_id,nome,ch_total,modalidade,turno,num_vagas,grau_academico,cpf_coordenador,sigla_departamento)
VALUES (seq_curso.NEXTVAL,'Matemática',2800,'PRESENCIAL','N',50,'LICENCIATURA','10000000004','DMAT');

-- DISCIPLINA (créditos definidos a priori; aqui seguem 1 crédito = 15h)
INSERT INTO Disciplina VALUES ('IF101','Introdução à Programação','Lógica de programação, variáveis, estruturas de controle, funções e listas.',30,60,6);
INSERT INTO Disciplina VALUES ('IF102','Algoritmos e Estruturas de Dados','Complexidade, pilhas, filas, listas encadeadas, árvores e ordenação.',30,60,6);
INSERT INTO Disciplina VALUES ('IF103','Programação Orientada a Objetos','Classes, herança, polimorfismo, encapsulamento e padrões básicos.',30,30,4);
INSERT INTO Disciplina VALUES ('IF104','Infraestrutura de Software','Processos, threads, sincronização, memória e sistemas de arquivos.',30,30,4);
INSERT INTO Disciplina VALUES ('IF105','Gerenciamento de Dados e Informação','Modelagem ER, modelo relacional, SQL, normalização e transações.',30,30,4);
INSERT INTO Disciplina VALUES ('IF106','Engenharia de Software','Processos de desenvolvimento, requisitos, projeto, testes e manutenção.',60,0,4);
INSERT INTO Disciplina VALUES ('IF201','Tópicos Avançados em Banco de Dados','Otimização de consultas, indexação, NoSQL e bancos distribuídos.',60,0,4);
INSERT INTO Disciplina VALUES ('MA101','Cálculo 1','Limites, derivadas e integrais de funções de uma variável.',60,0,4);
INSERT INTO Disciplina VALUES ('MA102','Cálculo 2','Técnicas de integração, séries e funções de várias variáveis.',60,0,4);
INSERT INTO Disciplina VALUES ('MA103','Álgebra Linear','Sistemas lineares, espaços vetoriais, transformações e autovalores.',60,0,4);
INSERT INTO Disciplina VALUES ('MA104','Matemática Discreta','Lógica, conjuntos, relações, contagem e grafos.',60,0,4);
INSERT INTO Disciplina VALUES ('FI101','Física Geral 1','Cinemática, dinâmica, trabalho, energia e leis de conservação.',60,30,6);

-- BIBLIOGRAFIA_DISCIPLINA (multivalorado)
INSERT INTO Bibliografia_disciplina VALUES ('IF101','DOWNEY, Allen. Pense em Python.');
INSERT INTO Bibliografia_disciplina VALUES ('IF101','MATTHES, Eric. Curso Intensivo de Python.');
INSERT INTO Bibliografia_disciplina VALUES ('IF102','CORMEN, Thomas H. et al. Algoritmos: Teoria e Prática.');
INSERT INTO Bibliografia_disciplina VALUES ('IF102','SZWARCFITER, Jayme; MARKENZON, Lilian. Estruturas de Dados e Seus Algoritmos.');
INSERT INTO Bibliografia_disciplina VALUES ('IF103','DEITEL, Paul; DEITEL, Harvey. Java: Como Programar.');
INSERT INTO Bibliografia_disciplina VALUES ('IF104','TANENBAUM, Andrew S. Sistemas Operacionais Modernos.');
INSERT INTO Bibliografia_disciplina VALUES ('IF104','SILBERSCHATZ, Abraham et al. Fundamentos de Sistemas Operacionais.');
INSERT INTO Bibliografia_disciplina VALUES ('IF105','SILBERSCHATZ, Abraham; KORTH, Henry; SUDARSHAN, S. Sistema de Banco de Dados.');
INSERT INTO Bibliografia_disciplina VALUES ('IF105','ELMASRI, Ramez; NAVATHE, Shamkant. Sistemas de Banco de Dados.');
INSERT INTO Bibliografia_disciplina VALUES ('IF106','SOMMERVILLE, Ian. Engenharia de Software.');
INSERT INTO Bibliografia_disciplina VALUES ('IF201','DATE, C. J. Introdução a Sistemas de Bancos de Dados.');
INSERT INTO Bibliografia_disciplina VALUES ('MA101','STEWART, James. Cálculo, Volume 1.');
INSERT INTO Bibliografia_disciplina VALUES ('MA101','GUIDORIZZI, Hamilton Luiz. Um Curso de Cálculo, Volume 1.');
INSERT INTO Bibliografia_disciplina VALUES ('MA102','STEWART, James. Cálculo, Volume 2.');
INSERT INTO Bibliografia_disciplina VALUES ('MA103','BOLDRINI, José Luiz et al. Álgebra Linear.');
INSERT INTO Bibliografia_disciplina VALUES ('MA104','GERSTING, Judith L. Fundamentos Matemáticos para a Ciência da Computação.');
INSERT INTO Bibliografia_disciplina VALUES ('FI101','HALLIDAY, David; RESNICK, Robert; WALKER, Jearl. Fundamentos de Física, Volume 1.');

-- PRE_REQUISITO (1º código EXIGE o 2º)
INSERT INTO Pre_requisito VALUES ('IF102','IF101');
INSERT INTO Pre_requisito VALUES ('IF103','IF101');
INSERT INTO Pre_requisito VALUES ('IF104','IF102');
INSERT INTO Pre_requisito VALUES ('IF105','IF102');
INSERT INTO Pre_requisito VALUES ('IF106','IF103');
INSERT INTO Pre_requisito VALUES ('IF201','IF105');
INSERT INTO Pre_requisito VALUES ('MA102','MA101');
INSERT INTO Pre_requisito VALUES ('MA103','MA101');

-- COMPOE_A_GRADE_CURRICULAR_DE  (codigo_disciplina, codigo_id, tipo, periodo_sugerido)
-- Curso 1 = Ciência da Computação
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF101',1,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA101',1,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA104',1,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF102',1,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA102',1,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF103',1,'OBRIGATORIA',3);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA103',1,'OBRIGATORIA',3);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF104',1,'OBRIGATORIA',4);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF105',1,'OBRIGATORIA',4);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF106',1,'OBRIGATORIA',5);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF201',1,'ELETIVA',NULL);
-- Curso 2 = Engenharia da Computação
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF101',2,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA101',2,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('FI101',2,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF102',2,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA102',2,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF103',2,'OBRIGATORIA',3);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA103',2,'OBRIGATORIA',3);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF104',2,'OBRIGATORIA',4);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF105',2,'ELETIVA',NULL);
-- Curso 3 = Sistemas de Informação
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF101',3,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA104',3,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF102',3,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF103',3,'OBRIGATORIA',3);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF105',3,'OBRIGATORIA',4);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF106',3,'OBRIGATORIA',5);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF104',3,'ELETIVA',NULL);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF201',3,'ELETIVA',NULL);
-- Curso 4 = Matemática (Licenciatura)
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA101',4,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA104',4,'OBRIGATORIA',1);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA102',4,'OBRIGATORIA',2);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('MA103',4,'OBRIGATORIA',3);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('FI101',4,'ELETIVA',NULL);
INSERT INTO Compoe_a_grade_curricular_de VALUES ('IF101',4,'ELETIVA',NULL);

-- SALA (usa SEQUENCE: ids 1 a 5)
INSERT INTO Sala VALUES (seq_sala.NEXTVAL,45,'CIn','A',1);
INSERT INTO Sala VALUES (seq_sala.NEXTVAL,60,'CIn','A',2);
INSERT INTO Sala VALUES (seq_sala.NEXTVAL,30,'CIn','B',1);   -- laboratório
INSERT INTO Sala VALUES (seq_sala.NEXTVAL,60,'CCEN','B',2);
INSERT INTO Sala VALUES (seq_sala.NEXTVAL,50,'CCEN','C',1);

-- TURMA (usa SEQUENCE: ids 1 a 10)
--   2025.2: T1 IF101 | T2 MA101 | T3 MA104
--   2026.1: T4 IF102 | T5 MA102 | T6 FI101
--   2026.2: T7 IF103 | T8 IF105 | T9 MA103 | T10 IF201
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2025.2','M',40,'IF101');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2025.2','M',50,'MA101');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2025.2','M',50,'MA104');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.1','M',40,'IF102');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.1','M',50,'MA102');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.1','T',40,'FI101');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.2','M',40,'IF103');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.2','M',40,'IF105');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.2','M',40,'MA103');
INSERT INTO Turma VALUES (seq_turma.NEXTVAL,'2026.2','N',30,'IF201');

-- HORARIO_TURMA
INSERT INTO Horario_turma VALUES (1,'24M12');
INSERT INTO Horario_turma VALUES (1,'6M12');
INSERT INTO Horario_turma VALUES (2,'35M12');
INSERT INTO Horario_turma VALUES (3,'35M34');
INSERT INTO Horario_turma VALUES (4,'24M12');
INSERT INTO Horario_turma VALUES (4,'6M12');
INSERT INTO Horario_turma VALUES (5,'35M12');
INSERT INTO Horario_turma VALUES (6,'24T12');
INSERT INTO Horario_turma VALUES (6,'6T12');
INSERT INTO Horario_turma VALUES (7,'24M34');
INSERT INTO Horario_turma VALUES (8,'35M12');
INSERT INTO Horario_turma VALUES (9,'35M34');
INSERT INTO Horario_turma VALUES (10,'35N12');

-- AVALIACAO (cod_turma, num_avaliacao, tipo, peso, data_aplicacao)
-- pesos de cada turma somam 1,00; a FINAL tem peso 0
INSERT INTO Avaliacao VALUES (1,1,'PROVA',0.30,DATE '2025-09-22');
INSERT INTO Avaliacao VALUES (1,2,'PROVA',0.30,DATE '2025-10-27');
INSERT INTO Avaliacao VALUES (1,3,'PROJETO',0.40,DATE '2025-11-24');
INSERT INTO Avaliacao VALUES (1,4,'FINAL',0.00,DATE '2025-12-08');
INSERT INTO Avaliacao VALUES (2,1,'PROVA',0.50,DATE '2025-09-25');
INSERT INTO Avaliacao VALUES (2,2,'PROVA',0.50,DATE '2025-11-06');
INSERT INTO Avaliacao VALUES (2,3,'FINAL',0.00,DATE '2025-12-09');
INSERT INTO Avaliacao VALUES (3,1,'PROVA',0.40,DATE '2025-10-02');
INSERT INTO Avaliacao VALUES (3,2,'PROJETO',0.60,DATE '2025-11-27');
INSERT INTO Avaliacao VALUES (4,1,'PROVA',0.50,DATE '2026-04-13');
INSERT INTO Avaliacao VALUES (4,2,'PROJETO',0.50,DATE '2026-06-08');
INSERT INTO Avaliacao VALUES (4,3,'FINAL',0.00,DATE '2026-07-06');
INSERT INTO Avaliacao VALUES (5,1,'PROVA',0.50,DATE '2026-04-16');
INSERT INTO Avaliacao VALUES (5,2,'PROVA',0.50,DATE '2026-06-11');
INSERT INTO Avaliacao VALUES (6,1,'PROVA',0.40,DATE '2026-04-14');
INSERT INTO Avaliacao VALUES (6,2,'PROJETO',0.60,DATE '2026-06-09');
-- 2026.2 em andamento: avaliação 1 já aplicada; avaliação 2 ainda agendada (sem notas)
INSERT INTO Avaliacao VALUES (7,1,'PROVA',0.50,DATE '2026-09-16');
INSERT INTO Avaliacao VALUES (7,2,'PROJETO',0.50,DATE '2026-11-25');
INSERT INTO Avaliacao VALUES (8,1,'PROVA',0.40,DATE '2026-09-17');
INSERT INTO Avaliacao VALUES (8,2,'PROJETO',0.60,DATE '2026-11-26');
INSERT INTO Avaliacao VALUES (9,1,'PROVA',0.50,DATE '2026-09-22');
INSERT INTO Avaliacao VALUES (9,2,'PROVA',0.50,DATE '2026-11-24');
INSERT INTO Avaliacao VALUES (10,1,'PROVA',0.50,DATE '2026-09-23');
INSERT INTO Avaliacao VALUES (10,2,'PROJETO',0.50,DATE '2026-11-25');

-- MATRICULA (cpf_aluno, cod_turma, frequencia, situacao)
-- T1 IF101 (2025.2)  - Joana reprova (média 4,25 + final 5,0 = 9,25 < 10)
INSERT INTO Matricula VALUES ('20000000001',1,96,'APROVADO');
INSERT INTO Matricula VALUES ('20000000002',1,90,'APROVADO');
INSERT INTO Matricula VALUES ('20000000003',1,88,'APROVADO');   -- passou na final
INSERT INTO Matricula VALUES ('20000000004',1,100,'APROVADO');
INSERT INTO Matricula VALUES ('20000000005',1,92,'APROVADO');
INSERT INTO Matricula VALUES ('20000000006',1,85,'APROVADO');
INSERT INTO Matricula VALUES ('20000000007',1,83,'APROVADO');
INSERT INTO Matricula VALUES ('20000000008',1,80,'REPROVADO');
-- T2 MA101 (2025.2)
INSERT INTO Matricula VALUES ('20000000001',2,94,'APROVADO');
INSERT INTO Matricula VALUES ('20000000002',2,86,'APROVADO');   -- passou na final
INSERT INTO Matricula VALUES ('20000000003',2,90,'APROVADO');
INSERT INTO Matricula VALUES ('20000000004',2,100,'APROVADO');
INSERT INTO Matricula VALUES ('20000000005',2,91,'APROVADO');
INSERT INTO Matricula VALUES ('20000000008',2,89,'APROVADO');
INSERT INTO Matricula VALUES ('20000000009',2,97,'APROVADO');
-- T3 MA104 (2025.2)  - Igor reprova por falta (notas boas, frequência 60%)
INSERT INTO Matricula VALUES ('20000000001',3,98,'APROVADO');
INSERT INTO Matricula VALUES ('20000000002',3,90,'APROVADO');
INSERT INTO Matricula VALUES ('20000000003',3,87,'APROVADO');
INSERT INTO Matricula VALUES ('20000000004',3,100,'APROVADO');
INSERT INTO Matricula VALUES ('20000000006',3,84,'APROVADO');
INSERT INTO Matricula VALUES ('20000000007',3,60,'REPROVADO');
INSERT INTO Matricula VALUES ('20000000009',3,95,'APROVADO');
-- T4 IF102 (2026.1)  - Igor tranca a disciplina
INSERT INTO Matricula VALUES ('20000000001',4,97,'APROVADO');
INSERT INTO Matricula VALUES ('20000000002',4,91,'APROVADO');
INSERT INTO Matricula VALUES ('20000000003',4,89,'APROVADO');
INSERT INTO Matricula VALUES ('20000000004',4,100,'APROVADO');
INSERT INTO Matricula VALUES ('20000000005',4,88,'APROVADO');   -- passou na final
INSERT INTO Matricula VALUES ('20000000006',4,92,'APROVADO');
INSERT INTO Matricula VALUES ('20000000007',4,25,'TRANCADO');
-- T5 MA102 (2026.1)  - Kauã reprova (média 2,5 < 3: sem direito à final)
INSERT INTO Matricula VALUES ('20000000001',5,95,'APROVADO');
INSERT INTO Matricula VALUES ('20000000002',5,90,'APROVADO');
INSERT INTO Matricula VALUES ('20000000003',5,93,'APROVADO');
INSERT INTO Matricula VALUES ('20000000004',5,100,'APROVADO');
INSERT INTO Matricula VALUES ('20000000005',5,88,'APROVADO');
INSERT INTO Matricula VALUES ('20000000008',5,96,'APROVADO');
INSERT INTO Matricula VALUES ('20000000009',5,78,'REPROVADO');
-- T6 FI101 (2026.1)
INSERT INTO Matricula VALUES ('20000000005',6,94,'APROVADO');
INSERT INTO Matricula VALUES ('20000000008',6,90,'APROVADO');
INSERT INTO Matricula VALUES ('20000000009',6,86,'APROVADO');
-- 2026.2 (em andamento -> CURSANDO; frequência parcial)
INSERT INTO Matricula VALUES ('20000000001',7,100,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000002',7,92,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000003',7,96,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000004',7,100,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000005',7,88,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000006',7,94,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000001',8,100,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000002',8,85,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000003',8,96,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000004',8,100,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000006',8,92,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000001',9,98,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000002',9,90,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000005',9,80,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000008',9,100,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000009',9,76,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000010',10,100,'CURSANDO');
INSERT INTO Matricula VALUES ('20000000011',10,95,'CURSANDO');

-- MONITORA (veteranos que já passaram pela disciplina)
INSERT INTO Monitora VALUES ('20000000011',1);   -- Marina monitora IF101 (2025.2)
INSERT INTO Monitora VALUES ('20000000010',4);   -- Lucas monitora IF102 (2026.1)
INSERT INTO Monitora VALUES ('20000000010',8);   -- Lucas monitora IF105 (2026.2)

-- MINISTRA (T1 tem dois professores)
INSERT INTO Ministra VALUES ('10000000001',1);
INSERT INTO Ministra VALUES ('10000000007',1);
INSERT INTO Ministra VALUES ('10000000005',2);
INSERT INTO Ministra VALUES ('10000000004',3);
INSERT INTO Ministra VALUES ('10000000003',4);
INSERT INTO Ministra VALUES ('10000000005',5);
INSERT INTO Ministra VALUES ('10000000006',6);
INSERT INTO Ministra VALUES ('10000000002',7);
INSERT INTO Ministra VALUES ('10000000003',8);
INSERT INTO Ministra VALUES ('10000000004',9);
INSERT INTO Ministra VALUES ('10000000003',10);

-- DESEMPENHO_EM (cod_turma, cpf_aluno, num_avaliacao, nota)
-- T1 IF101: pesos 0,3/0,3/0,4 | avaliação 4 = FINAL
INSERT INTO Desempenho_em VALUES (1,'20000000001',1,9.0);
INSERT INTO Desempenho_em VALUES (1,'20000000001',2,8.5);
INSERT INTO Desempenho_em VALUES (1,'20000000001',3,9.5);
INSERT INTO Desempenho_em VALUES (1,'20000000002',1,7.5);
INSERT INTO Desempenho_em VALUES (1,'20000000002',2,8.0);
INSERT INTO Desempenho_em VALUES (1,'20000000002',3,8.5);
INSERT INTO Desempenho_em VALUES (1,'20000000003',1,6.0);
INSERT INTO Desempenho_em VALUES (1,'20000000003',2,5.0);
INSERT INTO Desempenho_em VALUES (1,'20000000003',3,7.0);
INSERT INTO Desempenho_em VALUES (1,'20000000003',4,4.5);    -- média 6,10 + final 4,5 = 10,6 -> aprovada
INSERT INTO Desempenho_em VALUES (1,'20000000004',1,9.5);
INSERT INTO Desempenho_em VALUES (1,'20000000004',2,9.0);
INSERT INTO Desempenho_em VALUES (1,'20000000004',3,10.0);
INSERT INTO Desempenho_em VALUES (1,'20000000005',1,8.0);
INSERT INTO Desempenho_em VALUES (1,'20000000005',2,7.0);
INSERT INTO Desempenho_em VALUES (1,'20000000005',3,8.0);
INSERT INTO Desempenho_em VALUES (1,'20000000006',1,7.0);
INSERT INTO Desempenho_em VALUES (1,'20000000006',2,7.5);
INSERT INTO Desempenho_em VALUES (1,'20000000006',3,7.0);
INSERT INTO Desempenho_em VALUES (1,'20000000007',1,6.5);
INSERT INTO Desempenho_em VALUES (1,'20000000007',2,7.0);
INSERT INTO Desempenho_em VALUES (1,'20000000007',3,7.5);
INSERT INTO Desempenho_em VALUES (1,'20000000008',1,4.0);
INSERT INTO Desempenho_em VALUES (1,'20000000008',2,3.5);
INSERT INTO Desempenho_em VALUES (1,'20000000008',3,5.0);
INSERT INTO Desempenho_em VALUES (1,'20000000008',4,5.0);    -- média 4,25 + final 5,0 = 9,25 -> reprovada
-- T2 MA101: pesos 0,5/0,5 | avaliação 3 = FINAL
INSERT INTO Desempenho_em VALUES (2,'20000000001',1,8.0);
INSERT INTO Desempenho_em VALUES (2,'20000000001',2,9.0);
INSERT INTO Desempenho_em VALUES (2,'20000000002',1,6.0);
INSERT INTO Desempenho_em VALUES (2,'20000000002',2,7.0);
INSERT INTO Desempenho_em VALUES (2,'20000000002',3,4.0);    -- média 6,5 + final 4,0 = 10,5 -> aprovado
INSERT INTO Desempenho_em VALUES (2,'20000000003',1,7.5);
INSERT INTO Desempenho_em VALUES (2,'20000000003',2,8.0);
INSERT INTO Desempenho_em VALUES (2,'20000000004',1,10.0);
INSERT INTO Desempenho_em VALUES (2,'20000000004',2,9.5);
INSERT INTO Desempenho_em VALUES (2,'20000000005',1,8.5);
INSERT INTO Desempenho_em VALUES (2,'20000000005',2,7.5);
INSERT INTO Desempenho_em VALUES (2,'20000000008',1,7.0);
INSERT INTO Desempenho_em VALUES (2,'20000000008',2,8.0);
INSERT INTO Desempenho_em VALUES (2,'20000000009',1,9.0);
INSERT INTO Desempenho_em VALUES (2,'20000000009',2,8.0);
-- T3 MA104: pesos 0,4/0,6
INSERT INTO Desempenho_em VALUES (3,'20000000001',1,9.0);
INSERT INTO Desempenho_em VALUES (3,'20000000001',2,9.5);
INSERT INTO Desempenho_em VALUES (3,'20000000002',1,8.0);
INSERT INTO Desempenho_em VALUES (3,'20000000002',2,7.5);
INSERT INTO Desempenho_em VALUES (3,'20000000003',1,7.0);
INSERT INTO Desempenho_em VALUES (3,'20000000003',2,8.0);
INSERT INTO Desempenho_em VALUES (3,'20000000004',1,9.5);
INSERT INTO Desempenho_em VALUES (3,'20000000004',2,10.0);
INSERT INTO Desempenho_em VALUES (3,'20000000006',1,6.0);
INSERT INTO Desempenho_em VALUES (3,'20000000006',2,8.0);
INSERT INTO Desempenho_em VALUES (3,'20000000007',1,7.0);
INSERT INTO Desempenho_em VALUES (3,'20000000007',2,8.0);
INSERT INTO Desempenho_em VALUES (3,'20000000009',1,8.5);
INSERT INTO Desempenho_em VALUES (3,'20000000009',2,9.0);
-- T4 IF102: pesos 0,5/0,5 | avaliação 3 = FINAL
INSERT INTO Desempenho_em VALUES (4,'20000000001',1,9.0);
INSERT INTO Desempenho_em VALUES (4,'20000000001',2,9.5);
INSERT INTO Desempenho_em VALUES (4,'20000000002',1,7.0);
INSERT INTO Desempenho_em VALUES (4,'20000000002',2,8.0);
INSERT INTO Desempenho_em VALUES (4,'20000000003',1,7.5);
INSERT INTO Desempenho_em VALUES (4,'20000000003',2,8.0);
INSERT INTO Desempenho_em VALUES (4,'20000000004',1,10.0);
INSERT INTO Desempenho_em VALUES (4,'20000000004',2,9.0);
INSERT INTO Desempenho_em VALUES (4,'20000000005',1,6.0);
INSERT INTO Desempenho_em VALUES (4,'20000000005',2,7.5);
INSERT INTO Desempenho_em VALUES (4,'20000000005',3,3.5);    -- média 6,75 + final 3,5 = 10,25 -> aprovada
INSERT INTO Desempenho_em VALUES (4,'20000000006',1,8.0);
INSERT INTO Desempenho_em VALUES (4,'20000000006',2,7.0);
INSERT INTO Desempenho_em VALUES (4,'20000000007',1,4.0);    -- trancou depois da 1ª prova
-- T5 MA102: pesos 0,5/0,5
INSERT INTO Desempenho_em VALUES (5,'20000000001',1,8.0);
INSERT INTO Desempenho_em VALUES (5,'20000000001',2,8.5);
INSERT INTO Desempenho_em VALUES (5,'20000000002',1,7.5);
INSERT INTO Desempenho_em VALUES (5,'20000000002',2,7.0);
INSERT INTO Desempenho_em VALUES (5,'20000000003',1,9.0);
INSERT INTO Desempenho_em VALUES (5,'20000000003',2,8.0);
INSERT INTO Desempenho_em VALUES (5,'20000000004',1,9.5);
INSERT INTO Desempenho_em VALUES (5,'20000000004',2,10.0);
INSERT INTO Desempenho_em VALUES (5,'20000000005',1,7.0);
INSERT INTO Desempenho_em VALUES (5,'20000000005',2,7.0);
INSERT INTO Desempenho_em VALUES (5,'20000000008',1,8.0);
INSERT INTO Desempenho_em VALUES (5,'20000000008',2,9.0);
INSERT INTO Desempenho_em VALUES (5,'20000000009',1,2.0);
INSERT INTO Desempenho_em VALUES (5,'20000000009',2,3.0);
-- T6 FI101: pesos 0,4/0,6
INSERT INTO Desempenho_em VALUES (6,'20000000005',1,8.0);
INSERT INTO Desempenho_em VALUES (6,'20000000005',2,9.0);
INSERT INTO Desempenho_em VALUES (6,'20000000008',1,7.0);
INSERT INTO Desempenho_em VALUES (6,'20000000008',2,8.0);
INSERT INTO Desempenho_em VALUES (6,'20000000009',1,8.0);
INSERT INTO Desempenho_em VALUES (6,'20000000009',2,7.5);
-- 2026.2 (em andamento): só a avaliação 1 tem nota
INSERT INTO Desempenho_em VALUES (7,'20000000001',1,9.0);
INSERT INTO Desempenho_em VALUES (7,'20000000002',1,7.0);
INSERT INTO Desempenho_em VALUES (7,'20000000003',1,8.0);
INSERT INTO Desempenho_em VALUES (7,'20000000004',1,9.5);
INSERT INTO Desempenho_em VALUES (7,'20000000005',1,6.5);
INSERT INTO Desempenho_em VALUES (7,'20000000006',1,7.5);
INSERT INTO Desempenho_em VALUES (8,'20000000001',1,9.5);
INSERT INTO Desempenho_em VALUES (8,'20000000002',1,6.0);
INSERT INTO Desempenho_em VALUES (8,'20000000003',1,7.0);
INSERT INTO Desempenho_em VALUES (8,'20000000004',1,10.0);
INSERT INTO Desempenho_em VALUES (8,'20000000006',1,8.0);
INSERT INTO Desempenho_em VALUES (9,'20000000001',1,8.5);
INSERT INTO Desempenho_em VALUES (9,'20000000002',1,7.5);
INSERT INTO Desempenho_em VALUES (9,'20000000005',1,5.5);
INSERT INTO Desempenho_em VALUES (9,'20000000008',1,9.0);
INSERT INTO Desempenho_em VALUES (9,'20000000009',1,4.5);
INSERT INTO Desempenho_em VALUES (10,'20000000010',1,9.0);
INSERT INTO Desempenho_em VALUES (10,'20000000011',1,8.5);

-- VINCULA_SE_A 
-- CR = média simples das médias das disciplinas já encerradas (simplificação)
INSERT INTO Vincula_se_a VALUES ('20000000001',1,DATE '2025-08-11','ATIVO',8.87,'SISU',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000002',1,DATE '2025-08-11','ATIVO',7.40,'TRANSFERENCIA EXTERNA',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000003',1,DATE '2025-08-11','ATIVO',7.54,'SISU',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000004',1,DATE '2025-08-11','ATIVO',9.67,'PORTADOR DE DIPLOMA',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000005',2,DATE '2025-08-11','ATIVO',7.61,'SISU',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000006',3,DATE '2025-08-11','ATIVO',7.28,'SISU',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000007',3,DATE '2025-08-11','TRANCADO',7.33,'SISU',NULL);
-- Joana: saiu de Ciência da Computação e foi para Matemática (vínculo temporal: 2 linhas)
INSERT INTO Vincula_se_a VALUES ('20000000008',1,DATE '2025-08-11','TRANSFERIDO',5.88,'SISU',DATE '2026-02-27');
INSERT INTO Vincula_se_a VALUES ('20000000008',4,DATE '2026-03-02','ATIVO',8.05,'TRANSFERENCIA INTERNA',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000009',4,DATE '2025-08-11','ATIVO',6.88,'SISU',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000010',1,DATE '2023-03-06','ATIVO',8.31,'SISU',NULL);
INSERT INTO Vincula_se_a VALUES ('20000000011',3,DATE '2023-08-14','ATIVO',8.74,'SISU',NULL);

-- LOTACAO (Roberto foi realocado de DMAT para CIN: 2 linhas)
INSERT INTO Lotacao VALUES ('10000000001','CIN',DATE '2008-02-04','DE',NULL);
INSERT INTO Lotacao VALUES ('10000000002','CIN',DATE '2012-08-06','DE',NULL);
INSERT INTO Lotacao VALUES ('10000000003','DMAT',DATE '2005-03-01','DE',DATE '2018-02-28');
INSERT INTO Lotacao VALUES ('10000000003','CIN',DATE '2018-03-01','DE',NULL);
INSERT INTO Lotacao VALUES ('10000000004','DMAT',DATE '2014-03-10','DE',NULL);
INSERT INTO Lotacao VALUES ('10000000005','DMAT',DATE '2016-09-05','40H',NULL);
INSERT INTO Lotacao VALUES ('10000000006','DFIS',DATE '2019-02-11','DE',NULL);
INSERT INTO Lotacao VALUES ('10000000007','CIN',DATE '2010-05-03','20H',NULL);

-- RESERVA
-- Salas 1-5 (capacidade): 1=45 | 2=60 | 3=30 | 4=60 | 5=50  (todas comportam as vagas da turma)
INSERT INTO Reserva VALUES ('10000000001',1,1);
INSERT INTO Reserva VALUES ('10000000005',4,2);
INSERT INTO Reserva VALUES ('10000000004',4,3);   -- mesma sala da T2, em horário distinto
INSERT INTO Reserva VALUES ('10000000003',1,4);
INSERT INTO Reserva VALUES ('10000000005',4,5);
INSERT INTO Reserva VALUES ('10000000006',5,6);
INSERT INTO Reserva VALUES ('10000000002',2,7);
INSERT INTO Reserva VALUES ('10000000003',1,8);
INSERT INTO Reserva VALUES ('10000000004',4,9);
INSERT INTO Reserva VALUES ('10000000003',3,10);

COMMIT;