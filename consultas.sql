-- AV4 (SQL e PL/SQL)

SET SERVEROUTPUT ON;

-- [PESSOA 1] DDL, DML e Bloco Anônimo

-- [CHECKLIST SQL: 1. ALTER TABLE, 2. CREATE INDEX, 26. GRANT/REVOKE]
-- Coloque aqui os comandos de alteração de tabela e permissões
ALTER table sala
ADD (recursos_disponiveis varchar2(200))
--breve descrição dos materias disponiveis na sala, como computador, projetor etc...

CREATE index conferir_vagas
ON turma(num_vagas)
--index feito para acessar o numero de vagas da turma de maneira mais facil

-- [CHECKLIST SQL: 3. INSERT INTO, 4. UPDATE, 5. DELETE]
-- Coloque aqui o povoamento inicial e alterações em massa
INSERT INTO sala
(cod_sala, capacidade, predio, bloco, andar, recursos)
VALUES ('LAB05', 50, 'Centro de Informática', 'B', 0, 'Projetores, Ar-condicionado e Computadores');
--uma nova sala foi inserida, junto com as informaçoes de recursos que foi criada anteriormente)

INSERT INTO sala 
(cod_sala, capacidade, predio, bloco, andar)
VALUES ('CIN103', 60, 'Centro de Informática', 'A', 1);

UPDATE sala
SET capacidade = 45
WHERE cod_sala = LAB05;
--diminuindo a capacidade, como se alguns computadores tivessem quebrado

-- [CHECKLIST PL: 3. BLOCO ANÔNIMO, 6. %TYPE, 7. %ROWTYPE, 13. SELECT ... INTO]
DECLARE
    -- declarações com %TYPE e %ROWTYPE
BEGIN
    -- SELECT INTO e execução do bloco
    NULL;
END;
/


-- [MARCELA] Consultas Básicas/Intermediárias e Função PL/SQL (SQL 6—15 | PL 5, 15)

-- [CHECKLIST SQL: 6. SELECT-FROM-WHERE, 7. BETWEEN, 8. IN, 9. LIKE, 10. IS NULL/NOT NULL]
-- Escreva as consultas

-- 6. SELECT—FROM—WHERE
SELECT cpf_aluno, codigo_curso, data_ingresso, situacao
FROM vincula_se_a
WHERE situacao = 'Ativo'
ORDER BY data_ingresso;

-- 7. BETWEEN
SELECT cpf_aluno, cod_turma, num_avaliacao, nota
FROM desempenho_em
WHERE nota BETWEEN 7 AND 10
ORDER BY nota;

-- 8. IN
SELECT cpf, nome_completo, email, usuario
FROM pessoa
WHERE identidade_genero IN ('Não-binário', 'Outro')
ORDER BY nome_completo;

-- 9. LIKE
SELECT cpf_aluno, cod_turma, situacao
FROM matricula
WHERE situacao LIKE 'Reprovado%'
ORDER BY cpf_aluno;

-- 10. IS NULL
SELECT cpf_professor, sigla_dept, data_admissao
FROM lotacao
WHERE data_encerramento IS NULL
ORDER BY data_admissao;

-- [CHECKLIST SQL: 11. INNER JOIN, 12. MAX, 13. MIN, 14. AVG, 15. COUNT]
-- Consulta agregada com INNER JOIN

-- [CHECKLIST PL: 5. CREATE FUNCTION, 15. EXCEPTION WHEN]
CREATE OR REPLACE FUNCTION func_exemplo (
    p_id IN NUMBER
) RETURN VARCHAR2 IS
BEGIN
    RETURN 'OK';
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
/


-- [CLARA] Junções Avançadas, Agrupamentos e Stored Procedure

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
ORDER BY num_creditos DESC, nome ASC, codigo ASC;

-- conta quantos alunos estão matriculados em cada turma (agrupando pelo código da turma)
SELECT cod_turma,
       COUNT(*) AS qtd_alunos
FROM matricula
GROUP BY cod_turma;

-- [CHECKLIST PL: 4. CREATE PROCEDURE, 8. IF ELSIF, 9. CASE WHEN, 16. USO DE PARÂMETROS]
CREATE OR REPLACE PROCEDURE proc_exemplo (
    p_entrada IN VARCHAR2,
    p_saida OUT NUMBER
) IS
BEGIN
    -- Lógica com IF ELSIF / CASE WHEN
    NULL;
END;
/

-- [Miguel] Subconsultas, Conjuntos, Views, Loops e Cursores

-- [CHECKLIST SQL: 17 a 20. SUBCONSULTAS (RELACIONAL, IN, ANY, ALL)]
-- Subconsultas aqui

-- 17: [X] disciplinas cuja media das notas é maior que a média geral 

SELECT d.codigo, 
       d.nome, 
       ROUND(AVG(de.nota), 2) AS media_disciplina
FROM disciplina d
JOIN turma t
    ON t.codigo_disciplina = d.codigo
JOIN desempenho_em de
    ON de.cod_turma = t.cod_turma
GROUP BY d.codigo, d.nome
HAVING AVG(de.nota) > (
    SELECT AVG(nota)
    FROM desempenho_em
    WHERE nota IS NOT NULL
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

-- 19 to-do

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

-- 24 MINUS [] : cadeiras obrigatorias q faltam pra cada aluno

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

-- exibir bonitinho 
SELECT
    p.nome_completo,
    d.codigo,
    d.nome
FROM faltantes f
JOIN pessoa p
    ON p.cpf = f.cpf_aluno 
JOIN disciplina d 
    ON d.codigo = f.codigo_disciplina 
ORDER BY p.nome_completo, d.nome;

-- [CHECKLIST PL: 10. LOOP EXIT WHEN, 11. WHILE LOOP, 12. FOR IN LOOP, 14. CURSOR]
DECLARE
    -- Declaração de cursor
BEGIN
    -- Loops usando o cursor (OPEN, FETCH, CLOSE / FOR LOOP)
    NULL;
END;
/


-- [GABRIELA] Pacotes e Estruturas Complexas (RECORD e TABLE)

-- [CHECKLIST PL: 1. RECORD, 2. TABLE, 17. PACKAGE, 18. PACKAGE BODY]
-- pacote de gestão de relatórios

CREATE OR REPLACE PACKAGE pkg_gestao AS

    -- regras de negocio do minimundo
    c_media_aprovacao CONSTANT NUMBER := 7; -- media >= 7: aprovado
    c_media_minima_final CONSTANT NUMBER := 3; -- entre 3 e 7: prova final
    c_limite_frequencia CONSTANT NUMBER := 75; -- frequencia minima de aluno p ser aprovado 

    -- records
    -- registro aluno
    TYPE r_aluno IS RECORD (
        cpf aluno.cpf_pessoa%TYPE,
        nome pessoa.nome_completo%TYPE,
        matricula aluno.num_matricula%TYPE,
        situacao matricula.situacao%TYPE
    );
    
    -- registro linha do boletim
    TYPE r_linha_boletim IS RECORD (
        cod_turma turma.cod_turma%TYPE,
        disciplina disciplina.nome%TYPE,
        periodo turma.periodo%TYPE,
        creditos disciplina.num_creditos%TYPE,
        media NUMBER(4, 2),
        frequencia matricula.frequencia%TYPE,
        situacao matricula.situacao%TYPE
    );

    -- resumo gerencial de uma turma
    TYPE r_resumo_turma IS RECORD (
        cod_turma turma.cod_turma%TYPE,
        disciplina disciplina.nome%TYPE,
        periodo turma.periodo%TYPE,
        vagas turma.num_vagas%TYPE,
        matriculados NUMBER,
        ocupacao_pct NUMBER(5, 1),
        media_turma NUMBER(4, 2),
        aprovados NUMBER,
        reprovados NUMBER,
        trancados NUMBER
    );

    -- tables
    TYPE t_lista_alunos IS TABLE OF r_aluno INDEX BY BINARY_INTEGER;
    TYPE t_boletim IS TABLE OF r_linha_boletim INDEX BY BINARY_INTEGER;
    TYPE t_resumo_turmas IS TABLE OF r_resumo_turma INDEX BY BINARY_INTEGER;
    TYPE t_codigos IS TABLE OF disciplina.codigo%TYPE INDEX BY BINARY_INTEGER;

    -- declarações de procedimentos/funções
    -- a. funcoes: calculos reutilizaveis
    FUNCTION f_media_aluno (p_cpf IN aluno.cpf_pessoa%TYPE, p_cod_turma IN turma.cod_turma%TYPE) RETURN NUMBER; -- media ponderada pelos pesos das avaliações ja lancadas (null se não há notas)
    FUNCTION f_media_turma (p_cod_turma IN tuma.cod_turma%TYPE) RETURN NUMBER; -- media das medias dos alunos
    FUNCTION f_classifca_media (p_media IN NUMBER) return varchar2;
    FUNCTION f_taxa_ocupacao (p_cod_turma IN turma.cod_turma%TYPE) RETURN NUMBER; -- percentual de vagas ocupadas (matriculas não trancadas/vagas)
    FUNCTION f_cr_calculado (p_cpf IN aluno.cpf_pessoa%TYPE) RETURN NUMBER; --media das disciplinas encerradas pesada pelos creditos
    
    -- b. procedimentos: 
    -- pra preencher coleções (dados)
    PROCEDURE p_carregar_alunos_turma (p_cod_turma IN  turma.cod_turma%TYPE, p_lista OUT t_lista_alunos);
    PROCEDURE p_gerar_boletim (p_cpf IN aluno.cpf_pessoa%TYPE, p_apenas_encerradas IN BOOLEAN, p_boletim OUT t_boletim);
    PROCEDURE p_resumo_periodo (p_periodo IN turma.periodo%TYPE, p_resumo OUT t_resumo_turmas);
    PROCEDURE p_alunos_em_risco (p_periodo IN turma.periodo%TYPE, p_limite_freq  IN  NUMBER, p_lista OUT t_lista_alunos);
    PROCEDURE p_disciplinas_pendentes (p_cpf IN aluno.cpf_pessoa%TYPE, p_pendentes OUT t_codigos);
    -- pra gerar relatório 
    PROCEDURE p_rel_lista_alunos_turma (p_cod_turma IN turma.cod_turma%TYPE);
    PROCEDURE p_rel_avaliacoes_aluno (p_cpf IN aluno.cpf_pessoa%TYPE, p_cod_turma IN turma.cod_turma%TYPE);
    PROCEDURE p_rel_historico_escolar (p_cpf IN aluno.cpf_pessoa%TYPE);
    PROCEDURE p_rel_atestado_matricula (p_cpf IN aluno.cpf_pessoa%TYPE, p_periodo IN turma.periodo%TYPE);
    PROCEDURE p_rel_pendencias_grade (p_cpf IN aluno.cpf_pessoa%TYPE);
    PROCEDURE p_rel_gestao_periodo (p_periodo IN turma.periodo%TYPE);
    
END pkg_gestao;
/

CREATE OR REPLACE PACKAGE BODY pkg_gestao AS
    -- Implementação do pacote
END pkg_gestao;
/

-- [MATHEUS] Triggers (Gatilhos)

-- [CHECKLIST PL: 19. TRIGGER DE COMANDO]
CREATE OR REPLACE TRIGGER trg_comando_exemplo
AFTER INSERT ON tabela_exemplo
BEGIN
    NULL;
END;
/

-- [CHECKLIST PL: 20. TRIGGER DE LINHA]
CREATE OR REPLACE TRIGGER trg_linha_exemplo
BEFORE UPDATE OR DELETE ON tabela_exemplo
FOR EACH ROW
BEGIN
    NULL;
END;
/