-- AV4 (SQL)

-- [Arthur] DDL e DML

-- [CHECKLIST SQL: 1. ALTER TABLE, 2. CREATE INDEX, 26. GRANT/REVOKE]
-- Coloque aqui os comandos de alteração de tabela e permissões
ALTER table sala
ADD (recursos_disponiveis varchar2(200));
--breve descrição dos materias disponiveis na sala, como computador, projetor etc...

CREATE index conferir_vagas
ON turma(num_vagas);
--index feito para acessar o numero de vagas da turma de maneira mais facil

-- [CHECKLIST SQL: 26. GRANT / REVOKE]
-- GRANT: concede permissões a um usuário.
-- exemplo: GRANT SELECT ON sala TO usuario_teste;
-- REVOKE: retira permissões concedidas anteriormente.
-- exemplo: REVOKE SELECT ON sala FROM usuario_teste;

-- [CHECKLIST SQL: 3. INSERT INTO, 4. UPDATE, 5. DELETE]
INSERT INTO sala
(cod_sala, capacidade, predio, bloco, andar, recursos_disponiveis)
VALUES ('LAB05', 50, 'Centro de Informática', 'B', 0, 'Projetores, Ar-condicionado e Computadores');
--uma nova sala foi inserida, junto com as informaçoes de recursos que foi criada anteriormente)

INSERT INTO sala 
(cod_sala, capacidade, predio, bloco, andar)
VALUES ('CIN103', 60, 'Centro de Informática', 'A', 1);
--n coloquei recursos nessa já que n é obrigatoria

UPDATE sala
SET capacidade = 45
WHERE cod_sala = 'LAB05';
--diminuindo a capacidade, como se alguns computadores tivessem quebrado

DELETE FROM sala
WHERE cod_sala = 'CIN103';

-- [MARCELA] Consultas Básicas/Intermediárias
-- SQL 6—15

-- SQL 6. SELECT—FROM—WHERE

-- Consulta alunos com vínculo ativo ordenados por data de ingresso decrescente
SELECT cpf_aluno, codigo_curso, data_ingresso, situacao
FROM vincula_se_a
WHERE situacao = 'Ativo'
ORDER BY data_ingresso DESC;

-- SQL 7. BETWEEN

-- Consulta alunos cuja nota tenha sido entre 7 e 10, dentre todas as avaliações da turma T25106, em ordem decrescente
SELECT cpf_aluno, cod_turma, num_avaliacao, nota
FROM desempenho_em
WHERE nota BETWEEN 7 AND 10 AND cod_turma = 'T25106'
ORDER BY nota DESC;

-- SQL 8. IN

-- Consulta pessoas cuja identidade de gênero seja Não-binário ou Outro e ordena-as em ordem alfabética do nome
SELECT cpf, nome_completo, email, usuario
FROM pessoa
WHERE identidade_genero IN ('Não-binário', 'Outro')
ORDER BY nome_completo;

-- SQL 9. LIKE

-- Consulta reprovações, por nota ou por falta, na turma T25101 e ordena-as por CPF crescente
SELECT cpf_aluno, cod_turma, situacao
FROM matricula
WHERE situacao LIKE 'Reprovado%' AND cod_turma = 'T25101'
ORDER BY cpf_aluno;

-- SQL 10. IS NULL

-- Consulta professores com lotação vigente em ordem decrescente da data de admissão
SELECT cpf_professor, sigla_dept, data_admissao 
FROM lotacao
WHERE data_encerramento IS NULL
ORDER BY data_admissao DESC;

-- SQL 11. INNER JOIN

-- Consulta monitores da disciplina Engenharia de Software e ordena-os por nome completo e pelo código da turma
SELECT p.nome_completo, p.cpf, d.codigo AS cod_disciplina, d.nome AS nome_disciplina, t.cod_turma, t.periodo
FROM pessoa p
INNER JOIN aluno a ON p.cpf = a.cpf_pessoa
INNER JOIN monitora m ON m.cpf_aluno = a.cpf_pessoa
INNER JOIN turma t ON t.cod_turma = m.cod_turma
INNER JOIN disciplina d ON d.codigo = t.codigo_disciplina
WHERE d.nome = 'Engenharia de Software'
ORDER BY p.nome_completo, t.cod_turma;

-- SQL 12. MAX

-- Consulta o total de frequências e a frequência máxima dentre todas as matrículas
SELECT COUNT(frequencia) AS total_frequencias, MAX(frequencia) AS max_frequencia
FROM matricula;

-- Consulta professor(es) com tempo total máximo de serviço, consideradas todas as lotações
SELECT l.cpf_professor, p.nome_completo, COUNT(*) AS total_lotacoes, ROUND(SUM(MONTHS_BETWEEN(NVL(l.data_encerramento, SYSDATE), l.data_admissao)) / 12, 1) AS tempo_lotacao_anos
FROM lotacao l
INNER JOIN pessoa p ON p.cpf = l.cpf_professor
GROUP BY l.cpf_professor, p.nome_completo
HAVING SUM(MONTHS_BETWEEN(NVL(l.data_encerramento, SYSDATE), l.data_admissao)) = (
    SELECT MAX(SUM(MONTHS_BETWEEN(NVL(l2.data_encerramento, SYSDATE), l2.data_admissao)))
    FROM lotacao l2
    GROUP BY l2.cpf_professor
)
ORDER BY p.nome_completo;

-- SQL 13. MIN

-- Consulta o coeficiente de rendimento mínimo dentre vínculos ativos
SELECT COUNT(*) AS total_vinculos, COUNT(coeficiente_rendimento) AS total_coeficientes, MIN(coeficiente_rendimento) AS min_coeficiente
FROM vincula_se_a v WHERE v.situacao = 'Ativo';

-- Consulta a menor idade dentre professores com lotação não encerrada
SELECT COUNT(*) AS total_professores, TRUNC(MIN(MONTHS_BETWEEN(SYSDATE, p.data_nasc) / 12)) AS min_idade
FROM pessoa p
WHERE p.cpf IN (SELECT cpf_professor FROM lotacao WHERE data_encerramento IS NULL);

-- SQL 14. AVG

-- Consulta a idade média de alunos cujo vínculo esteja ativo
SELECT TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, p.data_nasc) / 12)) AS idade_media
FROM pessoa p
INNER JOIN vincula_se_a v ON v.cpf_aluno = p.cpf
WHERE v.situacao = 'Ativo';

-- SQL 15. COUNT

-- Consulta o total de alunas mulheres cis com vínculo ativo
SELECT COUNT(DISTINCT a.cpf_pessoa) AS alunas_cis_ativas
FROM pessoa p
INNER JOIN aluno a ON a.cpf_pessoa = p.cpf
INNER JOIN vincula_se_a v ON v.cpf_aluno = a.cpf_pessoa
WHERE p.identidade_genero = 'Mulher cis' AND v.situacao = 'Ativo';

-- [CLARA] Junções Avançadas e Agrupamentos

-- [CHECKLIST SQL: 16. LEFT/RIGHT/FULL OUTER JOIN]
-- lista todas as turmas com seus monitores (incluindo aquelas sem monitores)
SELECT t.cod_turma,
       p.nome_completo AS monitor
FROM turma t
LEFT JOIN monitora m
    ON t.cod_turma = m.cod_turma
LEFT JOIN pessoa p
    ON m.cpf_aluno = p.cpf;

-- lista todas as disciplinas com suas turmas (incluindo aquelas sem turmas)
SELECT d.codigo,
       d.nome,
       t.cod_turma
FROM turma t
RIGHT JOIN disciplina d
    ON t.codigo_disciplina = d.codigo;

-- [CHECKLIST SQL: 21. ORDER BY, 22. GROUP BY, 23. HAVING]
-- ordena as disciplinas por créditos (decrescente) e desempata por nome e código (crescente)
SELECT codigo,
       nome,
       num_creditos
FROM disciplina
ORDER BY num_creditos DESC,
         nome ASC,
         codigo ASC;

-- conta quantos alunos estão matriculados em cada turma (agrupando pelo código da turma)
SELECT cod_turma,
       COUNT(*) AS qtd_alunos
FROM matricula
GROUP BY cod_turma;

-- filtra as turmas com média acima de 7 (agrupando pelo código da turma)
SELECT d.cod_turma,
       ROUND(SUM(d.nota * a.peso) / SUM(a.peso), 2) AS media_turma
FROM desempenho_em d
JOIN avaliacao a
    ON a.num_avaliacao = d.num_avaliacao
    AND a.cod_turma = d.cod_turma
GROUP BY d.cod_turma
HAVING SUM(d.nota * a.peso) / SUM(a.peso) > 7;

-- [Miguel] Subconsultas, Conjuntos e Views

-- [CHECKLIST SQL: 17 a 20. SUBCONSULTAS (RELACIONAL, IN, ANY, ALL)]
-- Subconsultas aqui

-- 17: [X] disciplinas cuja media das notas é maior que a média geral 

SELECT d.codigo, 
       d.nome, 
       ROUND(SUM(de.nota * a.peso) / SUM(a.peso), 2) AS media_disciplina
FROM disciplina d
JOIN turma t
    ON t.codigo_disciplina = d.codigo
JOIN desempenho_em de
    ON de.cod_turma = t.cod_turma
JOIN avaliacao a
    ON a.num_avaliacao = de.num_avaliacao
    AND a.cod_turma = de.cod_turma
GROUP BY d.codigo,
         d.nome
HAVING SUM(de.nota * a.peso) / SUM(a.peso) > (
    SELECT SUM(de2.nota * a2.peso) / SUM(a2.peso)
    FROM desempenho_em de2
    JOIN avaliacao a2
        ON a2.num_avaliacao = de2.num_avaliacao
        AND a2.cod_turma = de2.cod_turma
);

-- 18: [x] disciplinas que o aluno ainda não foi aprovado

SELECT 
    d.codigo, 
    d.nome
FROM disciplina d
WHERE d.codigo IN (
    -- pega todas as disciplinas da grade do curso do sujeito
    SELECT g.codigo_disciplina
    FROM compoe_a_grade_curricular_de g
    JOIN vincula_se_a v
        ON v.codigo_curso = g.codigo_id
    WHERE v.cpf_aluno = 'CPF_DO_ALUNO'
      AND v.data_saida IS NULL
)
AND d.codigo NOT IN (
    -- tira as que ele passou
    SELECT t.codigo_disciplina 
    FROM matricula m
    JOIN turma t
        ON t.cod_turma = m.cod_turma 
    WHERE m.cpf_aluno = 'CPF_DO_ALUNO'
        AND m.situacao IN ('Aprovado', 'Aprovado por nota')
);

-- 19: [x] turmas que não cabem em pelo menos uma sala cadastrada

SELECT
    t.cod_turma,
    d.nome AS disciplina,
    t.num_vagas
FROM turma t
JOIN disciplina d
    ON d.codigo = t.codigo_disciplina
WHERE t.num_vagas > ANY (
    SELECT s.capacidade
    FROM sala s
)
ORDER BY t.num_vagas DESC;

-- 20: [x] alunos com maior cr em cada curso (com empates)

WITH alunos_ativos AS (
    SELECT 
        cpf_aluno, 
        codigo_curso,
        coeficiente_rendimento
    FROM vincula_se_a
    WHERE data_saida IS NULL 
      AND coeficiente_rendimento IS NOT NULL
)

SELECT 
    p.nome_completo,
    c.nome as curso,
    v.coeficiente_rendimento
FROM vincula_se_a v
JOIN aluno a
    ON a.cpf_pessoa = v.cpf_aluno
JOIN pessoa p
    ON p.cpf = a.cpf_pessoa
JOIN curso c
    ON c.codigo_id = v.codigo_curso
WHERE v.data_saida IS NULL 
    AND v.coeficiente_rendimento IS NOT NULL 
    AND v.coeficiente_rendimento >= ALL (
        SELECT x.coeficiente_rendimento
        FROM alunos_ativos x
        WHERE x.codigo_curso = v.codigo_curso 
        AND x.cpf_aluno <> v.cpf_aluno
    );

-- [CHECKLIST SQL: 24. UNION/INTERSECT/MINUS, 25. CREATE VIEW]
-- Operadores de conjunto e criação da View

-- 24 MINUS [x] : cadeiras obrigatorias q faltam pra cada aluno

with faltantes AS (
    -- obrigatoras da grade
    SELECT 
        v.cpf_aluno,
        g.codigo_disciplina 
    FROM vincula_se_a v
    JOIN compoe_a_grade_curricular_de g
        ON g.codigo_id = v.codigo_curso
    WHERE v.data_saida IS NULL
        AND g.tipo = 'Obrigatória'
    
    MINUS
    
    -- as q ele passou
    SELECT 
        m.cpf_aluno,
        t.codigo_disciplina
    FROM matricula m
    JOIN turma t 
        ON t.cod_turma = m.cod_turma 
    WHERE m.situacao IN ('Aprovado', 'Aprovado por nota')
)
SELECT
    p.nome_completo,
    d.codigo AS codigo_disciplina,
    d.nome AS nome_disciplina
FROM faltantes f
JOIN pessoa p ON p.cpf = f.cpf_aluno 
JOIN disciplina d ON d.codigo = f.codigo_disciplina 
ORDER BY p.nome_completo, d.nome;

-- 25 CREATE VIEW [x] : historico academico dos alunos

CREATE OR REPLACE VIEW vw_historico_academico AS
SELECT
    p.cpf,
    p.nome_completo,
    a.num_matricula,
    d.codigo AS codigo_disciplina,
    d.nome,
    t.cod_turma,
    t.periodo,
    m.situacao,
    m.frequencia
FROM pessoa p
JOIN aluno a
    ON a.cpf_pessoa = p.cpf
JOIN matricula m
    ON m.cpf_aluno = a.cpf_pessoa
JOIN turma t
    ON t.cod_turma = m.cod_turma
JOIN disciplina d
    ON d.codigo = t.codigo_disciplina;