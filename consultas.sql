-- AV4 (SQL e PL/SQL)

SET SERVEROUTPUT ON;

-- [Arthur] DDL, DML e Bloco Anônimo

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

-- [CHECKLIST PL: 3. BLOCO ANÔNIMO, 6. %TYPE, 7. %ROWTYPE, 13. SELECT ... INTO]

-- 3. BLOCO ANONIMO
BEGIN
    DBMS_OUTPUT.PUT_LINE('Teste da AV4');
END;
/

--%TYPE
--a variavel v_capacidade usa o mesmo tipo da coluna capacidade da tabela sala
DECLARE
    v_capacidade sala.capacidade%TYPE;
BEGIN
    v_capacidade := 30;

    DBMS_OUTPUT.PUT_LINE(v_capacidade);
END;
/

--%ROWTYPE
--a variavel v_sala representa uma linha inteira da tabela sala
DECLARE
    v_sala sala%ROWTYPE;
BEGIN
    SELECT *
    INTO v_sala
    FROM sala
    WHERE cod_sala = 'CIN101';

    DBMS_OUTPUT.PUT_LINE(v_sala.capacidade);
    --imprime o valor de capacidade da sala cujo cod_sala é CIN101
END;
/

--SELECT INTO
--consulta a capacidade da sala e guarda o resultado na variavel
DECLARE
    v_capacidade sala.capacidade%TYPE;
BEGIN
    SELECT capacidade
    INTO v_capacidade
    FROM sala
    WHERE cod_sala = 'CIN102';

    DBMS_OUTPUT.PUT_LINE(
        'Capacidade: ' || v_capacidade
    );
END;
/

-- [MARCELA] Consultas Básicas/Intermediárias e Função PL/SQL
-- SQL 6—15 | PL 5, 15

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

-- Consulta monitores da disciplina Estruturas de Dados e ordena-os por nome completo e pelo código da turma
SELECT p.nome_completo, p.cpf, d.codigo AS cod_disciplina, d.nome AS nome_disciplina, t.cod_turma, t.periodo
FROM pessoa p
INNER JOIN aluno a ON p.cpf = a.cpf_pessoa
INNER JOIN monitora m ON m.cpf_aluno = a.cpf_pessoa
INNER JOIN turma t ON t.cod_turma = m.cod_turma
INNER JOIN disciplina d ON d.codigo = t.codigo_disciplina
WHERE d.nome = 'Estruturas de Dados'
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

-- PL 5. CREATE FUNCTION

-- Contabiliza o total de monitores de uma disciplina em determinado período
CREATE OR REPLACE FUNCTION total_monitores_disciplina (
    f_nome_disciplina IN varchar2,
    f_periodo IN varchar2
) RETURN NUMBER

IS total_monitores NUMBER;

BEGIN

    SELECT COUNT(DISTINCT m.cpf_aluno)
    INTO total_monitores
    FROM monitora m
    INNER JOIN turma t ON t.cod_turma = m.cod_turma
    INNER JOIN disciplina d ON d.codigo = t.codigo_disciplina
    WHERE d.nome = f_nome_disciplina AND t.periodo = f_periodo;

    RETURN total_monitores;

END total_monitores_disciplina;
/

-- PL 15. EXCEPTION WHEN

-- Calcula a média ponderada das avaliações lançadas de um aluno em determinada turma, e lança exceção caso não haja notas do aluno cadastradas
CREATE OR REPLACE FUNCTION media_ponderada (
   f_cpf_aluno IN char,
   f_cod_turma IN varchar2
) RETURN NUMBER

IS media_p NUMBER; total_notas NUMBER; nota_ausente EXCEPTION;

BEGIN

    SELECT COUNT(*) INTO total_notas
    FROM desempenho_em
    WHERE cpf_aluno = f_cpf_aluno AND cod_turma = f_cod_turma;

    IF total_notas = 0 THEN RAISE nota_ausente;
    END IF;

    SELECT SUM(d.nota * a.peso) / SUM(a.peso)
    INTO media_p
    FROM desempenho_em d
    INNER JOIN avaliacao a ON a.num_avaliacao = d.num_avaliacao AND a.cod_turma = d.cod_turma
    WHERE d.cpf_aluno = f_cpf_aluno AND d.cod_turma = f_cod_turma;

    RETURN ROUND(media_p, 2);

EXCEPTION WHEN nota_ausente THEN RAISE_APPLICATION_ERROR(-20002, 'Notas do aluno não cadastradas.');

END media_ponderada;
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
ORDER BY num_creditos DESC,
         nome ASC,
         codigo ASC;

-- conta quantos alunos estão matriculados em cada turma (agrupando pelo código da turma)
SELECT cod_turma,
       COUNT(*) AS qtd_alunos
FROM matricula
GROUP BY cod_turma;

-- filtra as turmas com média acima de 7 (agrupando pelo código da turma)
SELECT cod_turma,
       AVG(nota) AS media_turma
FROM desempenho_em
GROUP BY cod_turma
HAVING AVG(nota) > 7;

-- [CHECKLIST PL: 4. CREATE PROCEDURE, 8. IF ELSIF, 9. CASE WHEN, 16. USO DE PARÂMETROS]
-- relatório de desempenho do aluno numa turma (média, situação, frequência e nível de frequência)
CREATE OR REPLACE PROCEDURE desempenho_aluno (
    p_cpf_aluno IN CHAR,
    p_cod_turma IN VARCHAR2,
    p_media OUT NUMBER,
    p_situacao OUT VARCHAR2,
    p_frequencia OUT NUMBER,
    p_nivel_frequencia OUT VARCHAR2
) IS
BEGIN
    -- busca a frequência do aluno na turma
    SELECT frequencia INTO p_frequencia
    FROM matricula
    WHERE cpf_aluno = p_cpf_aluno
        AND cod_turma = p_cod_turma;

    -- calcula a média das notas do aluno na turma (formato: 0,0)
    SELECT ROUND(AVG(nota), 1) INTO p_media
    FROM desempenho_em
    WHERE cpf_aluno = p_cpf_aluno
        AND cod_turma = p_cod_turma;

    -- define a situação com base na frequência e na média
    IF p_frequencia < 75 AND p_media < 3 THEN
        p_situacao := 'Reprovado por média e falta';
    ELSIF p_frequencia < 75 THEN
        p_situacao := 'Reprovado por falta';
    ELSIF p_media IS NULL THEN
        p_situacao := 'Matriculado';
    ELSIF p_media >= 7 THEN
        p_situacao := 'Aprovado';
    ELSIF p_media >= 3 THEN
        p_situacao := 'Matriculado';
    ELSE
        p_situacao := 'Reprovado';
    END IF;

    -- classifica o nível de frequência do aluno com base na porcentagem
    CASE 
        WHEN p_frequencia < 75 THEN
            p_nivel_frequencia := 'Baixa';
        WHEN p_frequencia BETWEEN 75 AND 85 THEN
            p_nivel_frequencia := 'Média';
        ELSE
            p_nivel_frequencia := 'Alta';
    END CASE;
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


-- [CHECKLIST PL: 10. LOOP EXIT WHEN, 11. WHILE LOOP, 12. FOR IN LOOP, 14. CURSOR]

-- 10 LOOP EXIT WHEN [x]
-- 14 CURSOR [x] : percorre o historico academico de um aluno

DECLARE
    v_cpf pessoa.cpf%TYPE := 'CPF_DO_ALUNO';

    CURSOR c_historico IS
        SELECT
            d.nome,
            t.periodo,
            m.situacao,
            m.frequencia
        FROM matricula m
        JOIN turma t
            ON t.cod_turma = m.cod_turma
        JOIN disciplina d
            ON d.codigo = t.codigo_disciplina
        WHERE m.cpf_aluno = v_cpf
        ORDER BY t.periodo, d.nome;

    v_disciplina disciplina.nome%TYPE;
    v_periodo turma.periodo%TYPE;
    v_situacao matricula.situacao%TYPE;
    v_frequencia matricula.frequencia%TYPE;

BEGIN
    OPEN c_historico;

    LOOP
        FETCH c_historico
        INTO v_disciplina, v_periodo, v_situacao, v_frequencia;

        EXIT WHEN c_historico%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            v_periodo || ' | ' ||
            v_disciplina || ' | ' ||
            v_situacao || ' | frequencia: ' ||
            NVL(TO_CHAR(v_frequencia), 'N/A') || '%'
        );
    END LOOP;

    CLOSE c_historico;
END;
/

-- 11 WHILE LOOP [x] : percorre a grade de um curso periodo por periodo

DECLARE
    v_curso curso.codigo_id%TYPE := 1;
    v_periodo NUMBER := 1;
    v_max_periodo NUMBER;
    v_qtd NUMBER;

BEGIN
    SELECT MAX(periodo_sugerido)
    INTO v_max_periodo
    FROM compoe_a_grade_curricular_de
    WHERE codigo_id = v_curso;

    WHILE v_periodo <= v_max_periodo LOOP

        SELECT COUNT(*)
        INTO v_qtd
        FROM compoe_a_grade_curricular_de
        WHERE codigo_id = v_curso
          AND periodo_sugerido = v_periodo;

        DBMS_OUTPUT.PUT_LINE(
            'Periodo ' || v_periodo ||
            ': ' || v_qtd || ' disciplinas'
        );

        v_periodo := v_periodo + 1;
    END LOOP;
END;
/

-- 12 FOR IN LOOP [x] : mostra alunos com risco academico

BEGIN
    FOR r IN (
        SELECT
            p.nome_completo,
            d.nome,
            m.frequencia,
            ROUND(AVG(de.nota), 2) AS media
        FROM matricula m
        JOIN pessoa p
            ON p.cpf = m.cpf_aluno
        JOIN turma t
            ON t.cod_turma = m.cod_turma
        JOIN disciplina d
            ON d.codigo = t.codigo_disciplina
        LEFT JOIN desempenho_em de
            ON de.cpf_aluno = m.cpf_aluno
            AND de.cod_turma = m.cod_turma
        WHERE m.situacao NOT IN (
            'Aprovado',
            'Aprovado por nota',
            'Trancado'
        )
        GROUP BY
            p.nome_completo,
            d.nome,
            m.frequencia
        HAVING m.frequencia < 75
            OR AVG(de.nota) < 7
    )
    LOOP
        -- printa o alerta academico no console
        DBMS_OUTPUT.PUT_LINE(
            r.nome_completo ||
            ' | ' || r.nome ||
            ' | frequencia: ' || r.frequencia ||
            '% | media: ' ||
            NVL(TO_CHAR(r.media), 'sem notas')
        );
    END LOOP;
END;
/

-- [GABRIELA] Pacotes e Estruturas Complexas (RECORD e TABLE)

-- [CHECKLIST PL: 1. RECORD, 2. TABLE, 17. PACKAGE, 18. PACKAGE BODY]
-- pacote de gestão de relatórios

CREATE OR REPLACE PACKAGE pkg_gestao AS

    -- regras de negócio do minimundo
    c_media_aprovacao   CONSTANT NUMBER := 7;
    c_limite_frequencia CONSTANT NUMBER := 75;

    -- [CHECKLIST PL: 1. USO DE RECORD]
    -- registro simples de aluno
    TYPE r_aluno IS RECORD (
        cpf aluno.cpf_pessoa%TYPE,
        nome pessoa.nome_completo%TYPE,
        matricula aluno.num_matricula%TYPE,
        situacao matricula.situacao%TYPE
    );
    
    -- registro para linha de histórico/boletim
    TYPE r_linha_historico IS RECORD (
        cod_turma turma.cod_turma%TYPE,
        disciplina disciplina.nome%TYPE,
        periodo turma.periodo%TYPE,
        creditos disciplina.num_creditos%TYPE,
        media NUMBER(4, 2),
        frequencia matricula.frequencia%TYPE,
        situacao matricula.situacao%TYPE
    );

    -- [CHECKLIST PL: 2. ESTRUTURA DE DADOS DO TIPO TABLE]
    TYPE t_lista_alunos IS TABLE OF r_aluno INDEX BY BINARY_INTEGER;
    TYPE t_historico IS TABLE OF r_linha_historico INDEX BY BINARY_INTEGER;
    TYPE t_codigos IS TABLE OF disciplina.codigo%TYPE INDEX BY BINARY_INTEGER;

    -- [CHECKLIST PL: 17. CREATE OR REPLACE PACKAGE]
    -- funções públicas
    FUNCTION f_media_aluno_turma (p_cpf IN aluno.cpf_pessoa%TYPE, p_cod_turma IN turma.cod_turma%TYPE) RETURN NUMBER;
    FUNCTION f_cr_calculado (p_cpf IN aluno.cpf_pessoa%TYPE) RETURN NUMBER;

    -- procedimentos de negócio e relatórios
    PROCEDURE p_carregar_alunos_turma (p_cod_turma IN turma.cod_turma%TYPE, p_lista OUT t_lista_alunos);
    PROCEDURE p_rel_historico_escolar (p_cpf IN aluno.cpf_pessoa%TYPE);
    PROCEDURE p_rel_pendencias_grade (p_cpf IN aluno.cpf_pessoa%TYPE);

END pkg_gestao;
/

-- [CHECKLIST PL: 18. CREATE OR REPLACE PACKAGE BODY]
CREATE OR REPLACE PACKAGE BODY pkg_gestao AS

    -- função: calcula media ponderada das avaliações do aluno em uma turma
    FUNCTION f_media_aluno_turma (p_cpf IN aluno.cpf_pessoa%TYPE, p_cod_turma IN turma.cod_turma%TYPE) RETURN NUMBER IS 
        v_media NUMBER(4, 2);
    BEGIN
        SELECT ROUND(SUM(d.nota * a.peso) / SUM(a.peso), 2) INTO v_media -- calcula media ponderada e armazena em v_media
        FROM desempenho_em d JOIN avaliacao a -- cruza tabelas (notas do aluno + pesos das provas)
        ON a.cod_turma = d.cod_turma AND a.num_avaliacao = d.num_avaliacao -- garante que uma nota especifica se junte com o peso exato dessa mesma prova e turma
        WHERE d.cpf_aluno = p_cpf AND d.cod_turma = p_cod_turma; -- filtro p calcular apenas a nota do aluno especifico recebido no parametro dentro da turma desejada

        RETURN v_media;
    EXCEPTION
        WHEN OTHERS THEN -- pega qualquer caso que não esteja englobado no codigo 
            RETURN NULL;
    END f_media_aluno_turma;

    -- função: calcula o CR ponderado pelos crdditos das disciplinas concluidas
    FUNCTION f_cr_calculado (p_cpf IN aluno.cpf_pessoa%TYPE) RETURN NUMBER IS
        v_soma  NUMBER := 0;
        v_cred  NUMBER := 0;
        v_media NUMBER;
    BEGIN
        FOR r IN ( -- cria um registro r que contem o cod_turma e o num_creditos 
            SELECT m.cod_turma, d.num_creditos 
            FROM matricula m
            JOIN turma t ON t.cod_turma = m.cod_turma -- cruza todas as turmas com as turmas em que o aluno fez matricula
            JOIN disciplina d ON d.codigo = t.codigo_disciplina -- cruza todas as disciplinas que o aluno ja pagou (se matriculou em uma turma da disciplina)
            WHERE m.cpf_aluno = p_cpf AND m.situacao IN ('Aprovado', 'Aprovado por nota', 'Reprovado') -- faz isso em todas as turmas que o aluno já esteve matriculado e concluiu
        ) LOOP -- abaixo ele faz o calculo do cr iterativamente, passando por cada registro r encontrado
            v_media := f_media_aluno_turma(p_cpf, r.cod_turma);
            IF v_media IS NOT NULL THEN
                v_soma := v_soma + (v_media * r.num_creditos);
                v_cred := v_cred + r.num_creditos;
            END IF;
        END LOOP;

        IF v_cred = 0 THEN -- trava de segurança quando o aluno ainda nao concluiu nenhuma dsciplina, evita divisao por 0
            RETURN NULL;
        END IF;

        RETURN ROUND(v_soma / v_cred, 2);
    END f_cr_calculado;

    -- procedimento: popula a coleção TABLE usando BULK COLLECT
    PROCEDURE p_carregar_alunos_turma (
        p_cod_turma IN turma.cod_turma%TYPE, --parametro de entrada
        p_lista OUT t_lista_alunos --parametro de saida (table preenchida com a lista dos alunos encontrados)
    ) IS
    BEGIN
        SELECT a.cpf_pessoa, p.nome_completo, a.num_matricula, m.situacao
        BULK COLLECT INTO p_lista -- carrega todos os registros resultantes da consulta na coleção p_lista de uma vez ao inves de fazer iterativamente com um loop; mais eficiente
        FROM matricula m
        JOIN aluno a ON a.cpf_pessoa = m.cpf_aluno -- essas 3 linhas conectam as tabelas matricula, aluno e pessoa pra pegar nome completo e matricula com base no cpf
        JOIN pessoa p ON p.cpf = a.cpf_pessoa
        WHERE m.cod_turma = p_cod_turma -- filtra apenas os alunos matriculados
        ORDER BY p.nome_completo; --ordena em ordem alfabetica
    END p_carregar_alunos_turma;

    -- relatório: histórico escolar completo do aluno
    PROCEDURE p_rel_historico_escolar (
        p_cpf IN aluno.cpf_pessoa%TYPE
    ) IS
        v_hist t_historico;
        v_nome pessoa.nome_completo%TYPE;
        v_mat aluno.num_matricula%TYPE;
        v_idx NUMBER := 1;
        v_cr NUMBER;
    BEGIN
        SELECT p.nome_completo, a.num_matricula INTO v_nome, v_mat -- busca nome e matricula usando cpf como parametro
        FROM aluno a 
        JOIN pessoa p ON p.cpf = a.cpf_pessoa
        WHERE a.cpf_pessoa = p_cpf; 

        -- aloca os dados na TABLE de RECORDs
        FOR r IN ( -- busca todas as matriculas do aluno 
            SELECT t.cod_turma, d.nome AS disciplina, t.periodo, d.num_creditos, m.frequencia, m.situacao
            FROM matricula m
            JOIN turma t ON t.cod_turma = m.cod_turma
            JOIN disciplina d ON d.codigo = t.codigo_disciplina
            WHERE m.cpf_aluno = p_cpf
            ORDER BY t.periodo, d.nome 
        ) LOOP -- guarda todos os campos selecionados na linha v_idx da table v_hist
            v_hist(v_idx).cod_turma := r.cod_turma;
            v_hist(v_idx).disciplina := r.disciplina;
            v_hist(v_idx).periodo := r.periodo;
            v_hist(v_idx).creditos := r.num_creditos;
            v_hist(v_idx).media := f_media_aluno_turma(p_cpf, r.cod_turma);
            v_hist(v_idx).frequencia := r.frequencia;
            v_hist(v_idx).situacao := r.situacao;
            v_idx := v_idx + 1;
        END LOOP;

        -- impressão no console
        DBMS_OUTPUT.PUT_LINE('HISTÓRICO: ' || v_nome || ' (Matrícula: ' || v_mat || ')');

        IF v_hist.COUNT = 0 THEN --historico vazio
            DBMS_OUTPUT.PUT_LINE('Nenhuma matrícula encontrada.');
        ELSE
            FOR i IN 1 .. v_hist.COUNT LOOP -- loop que imprime desempenho disciplina por disciplina
                DBMS_OUTPUT.PUT_LINE(
                    v_hist(i).periodo || ' | ' ||
                    RPAD(v_hist(i).disciplina, 25) || ' | Média: ' ||
                    NVL(TO_CHAR(v_hist(i).media, 'FM90.00'), 'N/A') || ' | ' || -- se a a media for nula imprime N/A
                    v_hist(i).situacao
                );
            END LOOP;
        END IF;

        v_cr := f_cr_calculado(p_cpf);
        DBMS_OUTPUT.PUT_LINE('CR CALCULADO: ' || NVL(TO_CHAR(v_cr, 'FM90.00'), 'N/A')); -- encerra mostrando o cr 
    END p_rel_historico_escolar;

    -- relatório: disciplinas obrigatórias pendentes para integralização
    PROCEDURE p_rel_pendencias_grade (
        p_cpf IN aluno.cpf_pessoa%TYPE
    ) IS
        v_pendentes t_codigos;
        v_nome_disc disciplina.nome%TYPE;
    BEGIN
        -- consulta com BULK COLLECT para preencher a coleção de códigos
        SELECT g.codigo_disciplina
        BULK COLLECT INTO v_pendentes -- guarda todos os codigos de disciplinas encontradas de uma só vez na memoria
        FROM vincula_se_a v
        JOIN compoe_a_grade_curricular_de g ON g.codigo_id = v.codigo_curso
        WHERE v.cpf_aluno = p_cpf AND v.data_saida IS NULL AND g.tipo = 'Obrigatória' -- pega as disciplinas de vinculo ativo (v.data_saida is null) e que sejma obrigatórias 
        AND NOT EXISTS ( -- garante que a disciplina só entra se o aluno não tiver matrícula nela com situação de aprovação
              SELECT 1 
              FROM matricula m
              JOIN turma t ON t.cod_turma = m.cod_turma
              WHERE m.cpf_aluno = p_cpf
                AND t.codigo_disciplina = g.codigo_disciplina
                AND m.situacao IN ('Aprovado', 'Aprovado por nota')
          );

        DBMS_OUTPUT.PUT_LINE('--- DISCIPLINAS PENDENTES DA GRADE ---'); --exibição dos resultados
        IF v_pendentes.COUNT = 0 THEN --aluno não tem mais nenhuma disciplina obrigatoria 
            DBMS_OUTPUT.PUT_LINE('Nenhuma pendência encontrada.');
        ELSE
            FOR i IN 1 .. v_pendentes.COUNT LOOP -- loop que passa por todos os codigos de disciplina pendente encontrados; usa o indice i
                SELECT nome INTO v_nome_disc FROM disciplina WHERE codigo = v_pendentes(i); --pega o nome legivel da disciplina pra cada codigo pendente encontrado

                DBMS_OUTPUT.PUT_LINE(i || '. [' || v_pendentes(i) || '] ' || v_nome_disc);
            END LOOP;
        END IF;
    END p_rel_pendencias_grade;

END pkg_gestao;
/

-- [MATHEUS] Triggers (Gatilhos)

-- [CHECKLIST PL: 19. TRIGGER DE COMANDO] 
CREATE OR REPLACE TRIGGER trg_limite_vagas
AFTER INSERT ON matricula
DECLARE
    v_turma_lotada turma.cod_turma%TYPE;
BEGIN
    SELECT MIN(t.cod_turma)
    INTO v_turma_lotada
    FROM turma t
    WHERE (
        SELECT COUNT(*)
        FROM matricula m
        WHERE m.cod_turma = t.cod_turma
          AND m.situacao NOT IN ('Trancado', 'Cancelado')
    ) > t.num_vagas;

    IF v_turma_lotada IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(
            -20013,
            'Limite de vagas excedido na turma: '
            || v_turma_lotada
        );
    END IF;
END;
/

-- [CHECKLIST PL: 20. TRIGGER DE LINHA]
CREATE OR REPLACE TRIGGER trg_auditoria_notas
AFTER INSERT OR UPDATE OF nota ON desempenho_em
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_operacao := 'INSERT';
    ELSE
        v_operacao := 'UPDATE';
    END IF;

    IF INSERTING OR :OLD.nota <> :NEW.nota THEN
        INSERT INTO auditoria_notas (
            cpf_aluno,
            cod_turma,
            num_avaliacao,
            nota_anterior,
            nota_nova,
            operacao,
            data_operacao,
            usuario
        )
        VALUES (
            :NEW.cpf_aluno,
            :NEW.cod_turma,
            :NEW.num_avaliacao,
            :OLD.nota,
            :NEW.nota,
            v_operacao,
            SYSTIMESTAMP,
            USER
        );
    END IF;
END;
/
