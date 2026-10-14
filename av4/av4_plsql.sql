-- AV4 (PL/SQL)

SET SERVEROUTPUT ON;

-- [Arthur] Bloco Anônimo

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

-- [MARCELA] Função PL/SQL
-- PL 5, 15

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

-- [CLARA] Stored Procedure

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
    SELECT ROUND(SUM(d.nota * a.peso) / SUM(a.peso), 2) INTO p_media
    FROM desempenho_em d
    JOIN avaliacao a
        ON a.num_avaliacao = d.num_avaliacao
        AND a.cod_turma = d.cod_turma
    WHERE d.cpf_aluno = p_cpf_aluno
        AND d.cod_turma = p_cod_turma;

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

-- [Miguel] Loops e Cursores

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
            ROUND(SUM(de.nota * a.peso) / SUM(a.peso), 2) AS media
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
        LEFT JOIN avaliacao a
            ON a.num_avaliacao = de.num_avaliacao
            AND a.cod_turma = de.cod_turma
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
            OR SUM(de.nota * a.peso) / SUM(a.peso) < 7
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
        num_matricula aluno.num_matricula%TYPE,
        situacao matricula.situacao%TYPE
    );
    
    -- registro para linha de histórico/boletim
    TYPE r_linha_historico IS RECORD (
        cod_turma turma.cod_turma%TYPE,
        nome_disciplina disciplina.nome%TYPE,
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
            v_hist(v_idx).nome_disciplina := r.disciplina;
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
                    RPAD(v_hist(i).nome_disciplina, 25) || ' | Média: ' ||
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