# Sistema Acadêmico — Projeto de Banco de Dados

Implementação em Oracle SQL e PL/SQL de um sistema acadêmico: esquema relacional normalizado, povoamento (AV3) e consultas, procedimentos, pacote e gatilhos (AV4).

**Universidade Federal de Pernambuco — Centro de Informática — Ciência da Computação**
**Disciplina:** Banco de Dados — **Professora:** Valéria Cesário Times
**Equipe:** Arthur Araújo, Gabriela Benevides, Marcela Parahym, Maria Clara Melo, Matheus Reis e Miguel Santos

---

## Sumário

1. [Visão geral](#1-visão-geral)
2. [Estrutura do repositório](#2-estrutura-do-repositório)
3. [Como executar](#3-como-executar)
4. [Esquema relacional e decisões de projeto](#4-esquema-relacional-e-decisões-de-projeto)
5. [Povoamento](#5-povoamento)
6. [AV4 — Consultas SQL](#6-av4--consultas-sql)
7. [AV4 — PL/SQL](#7-av4--plsql)
8. [Mudanças no esquema relacional (AV4)](#8-mudanças-no-esquema-relacional-av4)
9. [Checklist da entrega](#9-checklist-da-entrega)

---

## 1. Visão geral

O banco representa a rotina acadêmica de uma instituição de ensino: cadastro de pessoas (alunos e professores), cursos, departamentos e disciplinas; oferta de turmas com horários e salas; matrículas; avaliações e notas; e o histórico de vínculos de alunos com cursos e de professores com departamentos.

O projeto foi construído em etapas:

- **AV0 — descrição do minimundo.** Mundo real, objetivos, entidades, relacionamentos, perguntas e relatórios.
- **AV1 — diagrama EER.** Modelo conceitual com entidades, atributos, relacionamentos e cardinalidades.
- **AV2 — esquema relacional normalizado.** Mapeamento para relações e notas de normalização (1FN a 4FN e FNBC).
- **AV3 — criação e povoamento.** Tabelas, restrições e dados fictícios, a partir do esquema relacional normalizado.
- **AV4 — consultas e PL/SQL.** Comandos DDL e DML, consultas SQL de básicas a avançadas, e blocos PL/SQL: funções, procedure, loops, cursor, pacote e gatilhos. O código foi dividido em dois arquivos: um de SQL e um de PL/SQL.

## 2. Estrutura do repositório

```
/
├── README.md
├── criacao.sql               # CREATE SEQUENCE, CREATE TABLE, CONSTRAINTs e CHECKs   (AV3)
├── povoamento.sql            # INSERT INTO de todas as tabelas                       (AV3)
├── av4/
│   ├── av4_sql.sql           # DDL/DML, consultas, subconsultas, conjuntos e view    (AV4)
│   └── av4_plsql.sql         # blocos anônimos, funções, procedure, cursor, package, triggers (AV4)
└── docs/
    └── (minimundo, modelo ER e esquema relacional normalizado atualizado)
```

## 3. Como executar

Os scripts foram escritos para Oracle SQL e podem ser executados no Oracle Live SQL (FreeSQL). **A ordem importa**, por causa das dependências entre os objetos:

| Ordem | Arquivo | O que faz |
|---|---|---|
| 1 | `criacao.sql` | cria sequence, tabelas e restrições |
| 2 | `povoamento.sql` | insere os dados |
| 3 | `av4_sql.sql` | altera a tabela `sala`, cria índice e view, executa as consultas |
| 4 | `av4_plsql.sql` | cria funções, procedure, pacote e gatilhos, e executa os blocos PL/SQL |

Em cada arquivo:

1. Abra [freesql.com](https://freesql.com/) e entre no Worksheet.
2. Cole o conteúdo do arquivo e execute com **Run Script**.
3. Para ver a grade de resultados de uma consulta isolada, selecione-a e execute com **Run Statement**.

O arquivo `av4_plsql.sql` começa com `SET SERVEROUTPUT ON;`, necessário para exibir as mensagens de `DBMS_OUTPUT.PUT_LINE`. Cada bloco PL/SQL termina com `/`.

Conferência do povoamento (AV3):

```sql
SELECT 'pessoa' tabela, COUNT(*) total FROM pessoa
UNION ALL SELECT 'aluno', COUNT(*) FROM aluno
UNION ALL SELECT 'professor', COUNT(*) FROM professor
UNION ALL SELECT 'turma', COUNT(*) FROM turma
UNION ALL SELECT 'matricula', COUNT(*) FROM matricula
UNION ALL SELECT 'desempenho_em', COUNT(*) FROM desempenho_em;
```

Resultado esperado: 48 pessoas, 32 alunos, 16 professores, 24 turmas, 80 matrículas e 100 notas.

## 4. Esquema relacional e decisões de projeto

O esquema relacional normalizado tem **22 relações** (ver [seção 8](#8-mudanças-no-esquema-relacional-av4)) e **1 sequence** (`curso_seq`).

| Grupo | Tabelas |
|---|---|
| Pessoas | `pessoa`, `telefone_pessoa`, `aluno`, `professor` |
| Estrutura acadêmica | `departamento`, `curso`, `disciplina`, `bibliografia_disciplina`, `pre_requisito`, `compoe_a_grade_curricular_de` |
| Oferta de turmas | `turma`, `horario_turma`, `sala`, `reserva`, `ministra`, `monitora` |
| Avaliação | `avaliacao`, `matricula`, `desempenho_em`, `auditoria_notas` |
| Histórico temporal | `vincula_se_a` (aluno × curso), `lotacao` (professor × departamento) |

### Organização e nomenclatura

- O script de criação é dividido em blocos comentados e cada tabela é criada depois das que ela referencia, de modo que roda de uma vez, sem erros de dependência.
- Toda restrição tem nome explícito, com sufixo que indica o tipo (`_pk`, `_fk`, `_uk`, `_ck`), como em `pessoa_email_uk` e `curso_cpf_fk`. Qualquer mensagem de erro do Oracle aponta diretamente para a regra violada.
- Campos de tamanho fixo (CPF, número de matrícula) usam `CHAR`; textos variáveis usam `VARCHAR2`; pesos usam `NUMBER(3,2)` e notas usam `NUMBER(3,1)`.

### Chaves

- **Chaves naturais** onde o mundo real já fornece o identificador: CPF (`pessoa`), sigla (`departamento`), código da disciplina (por exemplo, `IF101`), código da turma e código da sala.
- **Chave gerada por sequence** apenas onde o identificador é puramente técnico: `curso.codigo_id`, alimentado por `curso_seq`.
- **Especialização por chave compartilhada:** `aluno` e `professor` usam como PK o próprio `cpf_pessoa`, que também é FK para `pessoa`.
- **Entidade fraca:** `avaliacao` tem PK composta `(num_avaliacao, cod_turma)`: o número da avaliação é discriminador e só identifica a avaliação dentro da turma.
- **Tabelas associativas** têm PK composta pelas chaves das entidades que ligam.

### Atributos multivalorados, compostos e derivados

- **Multivalorados** viraram tabelas próprias: telefones (`telefone_pessoa`), bibliografia (`bibliografia_disciplina`) e horários de turma (`horario_turma`), mantendo as colunas atômicas (1FN).
- **Compostos** foram divididos em colunas simples: carga horária em `ch_teorica` e `ch_pratica`; localização da sala em `predio`, `bloco` e `andar`; dados institucionais em `usuario` e `senha`.
- **Derivado:** a nota final da matrícula não é armazenada, para não haver inconsistência com as notas lançadas. Ela é calculada pela média ponderada das avaliações, com os pesos definidos por cada turma (`avaliacao.peso`).

### Relacionamentos

- **Oferece (1:N):** `curso.sigla_departamento` é `NOT NULL`.
- **Coordena (1:1):** `curso.cpf_coordenador` é `NOT NULL` e `UNIQUE`.
- **Compõe a oferta de (N:1):** `turma.codigo_disciplina` referencia a disciplina ofertada.
- **N:N** (ministra, monitora, pré-requisito, grade curricular) viraram tabelas associativas. Em `pre_requisito`, um `CHECK` impede que uma disciplina seja pré-requisito de si mesma.
- **Desempenho em:** `desempenho_em` tem duas chaves estrangeiras compostas que compartilham `cod_turma`, uma para `matricula (cpf_aluno, cod_turma)` e outra para `avaliacao (num_avaliacao, cod_turma)`. O banco só aceita a nota de um aluno matriculado na turma, em uma avaliação daquela mesma turma.
- **Reserva:** a chave primária é `(cpf_pessoa, cod_turma)`, com chave estrangeira composta para `ministra (cpf_professor, cod_turma)` e outra para `sala`. Assim, quem reserva é sempre professor da turma, e cada turma tem uma única reserva.

### Relacionamentos temporais

`vincula_se_a` (aluno × curso) e `lotacao` (professor × departamento) guardam o histórico completo. A data de ingresso e a data de admissão fazem parte das chaves primárias, o que permite vários períodos de vínculo com o mesmo curso ou departamento.

Duas regras do minimundo são garantidas por **índices únicos funcionais**: cada aluno tem no máximo **um vínculo em aberto** (sem data de saída) e cada professor tem no máximo **uma lotação vigente** (sem data de encerramento). O índice usa uma expressão `CASE` que devolve o identificador apenas quando o registro está em aberto; como o Oracle não indexa valores nulos, registros encerrados ficam livres para se repetir.

### Regras de integridade por tabela

| Tabela | Regras garantidas pelo banco |
|---|---|
| `pessoa` | CPF com 11 dígitos; e-mail em formato válido; e-mail e usuário únicos; usuário sem espaços; senha com no mínimo 8 caracteres e sem espaços; identidade de gênero opcional e, quando informada, dentro de uma lista padronizada |
| `telefone_pessoa` | telefone com 10 ou 11 dígitos |
| `aluno` / `professor` | número de matrícula único; titulação restrita a Doutorado, Mestrado, Especialização ou Graduação |
| `departamento` | nome e telefone únicos; telefone com 10 ou 11 dígitos |
| `curso` | carga horária e vagas positivas; modalidade, turno e grau dentro dos domínios; combinação nome + modalidade + turno + grau única; coordenador único |
| `disciplina` | cargas teórica e prática não negativas, com soma positiva; créditos positivos |
| `turma` | período no formato `AAAA.S` (semestre 1 ou 2); turno dentro do domínio; vagas positivas |
| `horario_turma` | horário na notação do SIGAA: dias (2 a 7), turno (M, T ou N) e aulas (1 a 6) |
| `sala` | capacidade positiva; andar maior ou igual a zero |
| `avaliacao` | tipo (Prova, Trabalho, Seminário, Apresentação, Lista); peso maior que 0 e no máximo 1 |
| `matricula` | frequência de 0 a 100; situação (Aprovado, Reprovado, Trancado, Matriculado) |
| `compoe_a_grade_curricular_de` | tipo (Obrigatória, Eletiva); período sugerido entre 1 e 12; disciplina obrigatória exige período sugerido |
| `desempenho_em` | nota entre 0 e 10 |
| `vincula_se_a` | situação (Ativo, Trancado, Formado, Desligado); coeficiente de rendimento entre 0 e 10; forma de ingresso dentro do domínio; vínculo ativo ou trancado não tem data de saída, vínculo encerrado tem; saída nunca anterior ao ingresso |
| `lotacao` | regime (40 horas, 20 horas, Dedicação exclusiva); encerramento nunca anterior à admissão |

## 5. Povoamento

O script de povoamento insere os dados na ordem das dependências entre as tabelas e termina com `COMMIT`. Todos os dados são fictícios.

| Tabela | Registros | Tabela | Registros |
|---|---|---|---|
| `pessoa` | 48 | `sala` | 12 |
| `telefone_pessoa` | 52 | `avaliacao` | 50 |
| `aluno` | 32 | `matricula` | 80 |
| `professor` | 16 | `monitora` | 8 |
| `departamento` | 8 | `pre_requisito` | 18 |
| `curso` | 12 | `ministra` | 32 |
| `disciplina` | 30 | `compoe_a_grade_curricular_de` | 60 |
| `bibliografia_disciplina` | 36 | `desempenho_em` | 100 |
| `turma` | 24 | `vincula_se_a` | 36 |
| `horario_turma` | 34 | `lotacao` | 19 |
| | | `reserva` | 24 |

O cenário simula **8 departamentos, 12 cursos e 30 disciplinas**, com **24 turmas em três períodos letivos** (2025.2, 2026.1 e 2026.2). Para exercitar todos os relacionamentos, o povoamento cobre:

- cursos de graus, modalidades e turnos diversos, com disciplinas obrigatórias e eletivas e cadeias de pré-requisitos;
- turmas com um ou mais horários semanais, em salas e laboratórios de prédios diferentes, e turmas com mais de um professor;
- avaliações dos cinco tipos, com pesos que somam 1 em cada turma;
- matrículas aprovadas, reprovadas, trancadas e em andamento, estas com notas lançadas parcialmente;
- alunos com vínculos ativos, trancados, formados e desligados, incluindo quem concluiu ou deixou um curso e ingressou em outro;
- professores que mudaram de departamento, com lotação encerrada e nova lotação vigente;
- monitoria, telefones múltiplos e identidades de gênero e formas de ingresso diversas.

## 6. AV4 — Consultas SQL

Arquivo: `av4/av4_sql.sql`. A numeração segue o checklist de SQL da AV4.

| Item | Recurso | Consulta / comando | Responsável |
|---|---|---|---|
| 1 | `ALTER TABLE` | adiciona a coluna opcional `recursos_disponiveis` (`VARCHAR2(200)`) à tabela `sala` | Arthur |
| 2 | `CREATE INDEX` | índice `conferir_vagas` sobre `turma(num_vagas)`, para acelerar consultas e verificações de capacidade | Arthur |
| 26 | `GRANT` / `REVOKE` | exemplos comentados de concessão e revogação de permissão de consulta sobre `sala` | Arthur |
| 3 | `INSERT INTO` | insere as salas `LAB05` (com recursos) e `CIN103` (sem recursos, pois o campo é opcional) | Arthur |
| 4 | `UPDATE` | reduz a capacidade de `LAB05` para 45 | Arthur |
| 5 | `DELETE` | remove a sala `CIN103` | Arthur |
| 6 | `SELECT–FROM–WHERE` | alunos com vínculo ativo, do ingresso mais recente ao mais antigo | Marcela |
| 7 | `BETWEEN` | notas entre 7 e 10 na turma T25106 | Marcela |
| 8 | `IN` | pessoas com identidade de gênero Não-binário ou Outro | Marcela |
| 9 | `LIKE` | reprovações na turma T25101 | Marcela |
| 10 | `IS NULL` | professores com lotação vigente | Marcela |
| 11 | `INNER JOIN` | monitores da disciplina Engenharia de Software, com turma e período | Marcela |
| 12 | `MAX` | maior frequência entre as matrículas; professor(es) com maior tempo total de serviço, somando todas as lotações | Marcela |
| 13 | `MIN` | menor coeficiente de rendimento entre vínculos ativos; menor idade entre professores com lotação vigente | Marcela |
| 14 | `AVG` | idade média dos alunos com vínculo ativo | Marcela |
| 15 | `COUNT` | total de alunas mulheres cis com vínculo ativo | Marcela |
| 16 | `LEFT` / `RIGHT JOIN` | todas as turmas com seus monitores, mesmo sem monitor; todas as disciplinas com suas turmas, mesmo sem turma | Clara |
| 21 | `ORDER BY` | disciplinas por créditos (decrescente), nome e código | Clara |
| 22 | `GROUP BY` | quantidade de alunos matriculados em cada turma | Clara |
| 23 | `HAVING` | turmas com média ponderada acima de 7 | Clara |
| 17 | subconsulta relacional | disciplinas cuja média ponderada supera a média geral | Miguel |
| 18 | subconsulta com `IN` / `NOT IN` | disciplinas da grade do curso do aluno em que ele ainda não foi aprovado | Miguel |
| 19 | subconsulta com `ANY` | turmas cujas vagas superam a capacidade de ao menos uma sala | Miguel |
| 20 | subconsulta com `ALL` | alunos com maior coeficiente de rendimento em cada curso, com empates, usando `WITH` | Miguel |
| 24 | `MINUS` | disciplinas obrigatórias que faltam a cada aluno: obrigatórias da grade menos as já aprovadas | Miguel |
| 25 | `CREATE VIEW` | `vw_historico_academico`, com o histórico de matrículas de cada aluno (disciplina, turma, período, situação e frequência) | Miguel |

### Decisões das consultas

- **Média ponderada em todas as consultas.** Como cada turma define o peso de suas avaliações, as médias são calculadas como `SUM(nota × peso) / SUM(peso)`, nunca como média simples. O mesmo critério vale para as consultas, a procedure, a função e o pacote.
- **Vínculo em aberto.** As consultas de grade e de coeficiente consideram apenas vínculos com `data_saida IS NULL`, coerente com a regra de um vínculo em aberto por aluno.
- **Tempo de serviço.** No item 12, lotações sem data de encerramento são contadas até a data atual (`NVL(data_encerramento, SYSDATE)`).
- **Empates.** No item 20, o operador `>= ALL` mantém todos os alunos empatados com o maior coeficiente do curso.

## 7. AV4 — PL/SQL

Arquivo: `av4/av4_plsql.sql`. A numeração segue o checklist de PL da AV4.

| Itens | Recurso | O que implementa | Responsável |
|---|---|---|---|
| 3, 6, 7, 13 | bloco anônimo, `%TYPE`, `%ROWTYPE`, `SELECT ... INTO` | blocos que consultam a capacidade de salas, com variáveis ancoradas nos tipos das colunas e em uma linha inteira da tabela | Arthur |
| 5 | `CREATE FUNCTION` | `total_monitores_disciplina(nome, período)`: quantidade de monitores de uma disciplina em um período | Marcela |
| 15 | `EXCEPTION WHEN` | `media_ponderada(cpf, turma)`: média ponderada do aluno na turma, com exceção própria (`nota_ausente`) e `RAISE_APPLICATION_ERROR` quando não há notas | Marcela |
| 4, 8, 9, 16 | `CREATE PROCEDURE`, `IF/ELSIF`, `CASE WHEN`, parâmetros | `desempenho_aluno`: recebe CPF e turma e devolve, por parâmetros de saída, média ponderada, situação (`IF/ELSIF`), frequência e nível de frequência (`CASE`) | Clara |
| 10, 14 | `LOOP EXIT WHEN`, `CURSOR` | cursor explícito (`OPEN`, `FETCH`, `CLOSE`) que percorre o histórico acadêmico de um aluno | Miguel |
| 11 | `WHILE LOOP` | percorre a grade de um curso período por período e conta as disciplinas de cada um | Miguel |
| 12 | `FOR IN LOOP` | alertas de risco acadêmico: matrículas em andamento ou reprovadas com frequência abaixo de 75% ou média ponderada abaixo de 7 | Miguel |
| 1, 2, 17, 18 | `RECORD`, `TABLE`, `PACKAGE`, `PACKAGE BODY` | `pkg_gestao`, pacote de gestão de relatórios (detalhado abaixo) | Gabriela |
| 19 | trigger de comando | `trg_limite_vagas` | Matheus |
| 20 | trigger de linha | `trg_auditoria_notas` | Matheus |

### Pacote `pkg_gestao`

Reúne cálculos e relatórios acadêmicos em um único pacote, separando a especificação (interface pública) do corpo (implementação).

- **Constantes:** `c_media_aprovacao` (7) e `c_limite_frequencia` (75), que centralizam as regras de negócio do minimundo.
- **Records:** `r_aluno` (CPF, nome, matrícula e situação) e `r_linha_historico` (turma, disciplina, período, créditos, média, frequência e situação). Os campos usam `%TYPE`, de modo que acompanham as colunas das tabelas.
- **Tables (coleções):** `t_lista_alunos`, `t_historico` e `t_codigos`, todas `INDEX BY BINARY_INTEGER`, em que as duas primeiras guardam records.
- **Funções:**
  - `f_media_aluno_turma`: média ponderada do aluno em uma turma, ou `NULL` quando não há notas lançadas;
  - `f_cr_calculado`: coeficiente de rendimento, ponderado pelos créditos das disciplinas concluídas.
- **Procedures:**
  - `p_carregar_alunos_turma`: preenche uma coleção com os alunos de uma turma, em ordem alfabética, usando `BULK COLLECT`;
  - `p_rel_historico_escolar`: imprime o histórico de um aluno (período, disciplina, média e situação de cada matrícula) e o CR calculado;
  - `p_rel_pendencias_grade`: imprime as disciplinas obrigatórias do curso que o aluno ainda não concluiu com aprovação.

### Gatilhos

- **`trg_limite_vagas`** (gatilho de comando): dispara após `INSERT` em `matricula` e verifica se alguma turma passou a ter mais matrículas ativas (exceto trancadas e canceladas) do que vagas. Nesse caso, aborta a operação com `RAISE_APPLICATION_ERROR(-20013)` indicando a turma lotada.
- **`trg_auditoria_notas`** (gatilho de linha): dispara após `INSERT` ou `UPDATE` da coluna `nota` em `desempenho_em` e registra em `auditoria_notas` o aluno, a turma, a avaliação, a nota anterior e a nova, o tipo da operação, a data e hora e o usuário. Em atualizações, só registra quando o valor da nota realmente muda.

### Decisões do PL/SQL

- **Dois níveis de gatilho, duas responsabilidades:** o gatilho de comando valida uma regra do conjunto de dados (lotação da turma) e o gatilho de linha registra a história de cada nota, pois precisa dos valores `:OLD` e `:NEW`.
- **Auditoria separada do dado:** o histórico de alterações de nota fica em uma tabela própria, sem poluir `desempenho_em`.
- **`BULK COLLECT` no pacote:** carrega o resultado inteiro de uma consulta na coleção em uma única operação, em vez de um laço linha a linha.
- **Reaproveitamento dentro do pacote:** `f_cr_calculado` e `p_rel_historico_escolar` reutilizam `f_media_aluno_turma`, de modo que a regra da média existe em um único lugar do pacote.
- **Parâmetros de entrada e saída:** a procedure `desempenho_aluno` devolve vários resultados de uma só chamada por parâmetros `OUT`, em vez de depender de impressão na tela.

## 8. Mudanças no esquema relacional (AV4)

O esquema relacional normalizado, atualizado em `docs/`, teve as seguintes mudanças em relação à versão anterior:

1. **`Sala` — nova coluna `recursos_disponiveis`.** Descreve brevemente os recursos da sala (computadores, projetor etc.). É opcional, pois nem toda sala tem os recursos descritos. A coluna é criada pelo `ALTER TABLE` do arquivo `03_av4_sql.sql`.
2. **Nova relação `Auditoria_notas`** `(id_historico, cpf_aluno, cod_turma, num_avaliacao, nota_anterior, nota_nova, operacao, data_operacao, usuario)`. Guarda o histórico de alterações de nota, e é alimentada pelo gatilho `trg_auditoria_notas`. Com ela, o esquema passa de 21 para 22 relações.
3. **`Reserva` — nova chave primária e nova referência.** A chave primária passa a ser composta por `cpf_pessoa` e `cod_turma`, e `(cpf_pessoa, cod_turma)` referencia `Ministra(cpf_professor, cod_turma)`, enquanto `cod_sala` referencia `Sala`. Assim, só o professor que ministra a turma pode reservar sala para ela, e cada turma tem uma única reserva.
4. **`Vincula_se_a` e `Lotacao` — regras de vigência explicitadas.** O esquema registra que só pode existir um vínculo em aberto por aluno e uma lotação vigente por professor, regras garantidas por índices únicos no banco.

Além disso, ao implementar o esquema nas etapas anteriores, foram feitos pequenos ajustes de nomes: a coluna `data` de `Avaliacao` passou a se chamar `data_avaliacao`, e a coluna `status` de `Vincula_se_a` passou a se chamar `situacao`.

## 9. Checklist da entrega

**AV3 — criação e povoamento**

- [x] `CREATE TABLE`
- [x] `INSERT INTO`
- [x] Cláusula `CONSTRAINT` em `CREATE TABLE`
- [x] `CREATE SEQUENCE`
- [x] Cláusula `CHECK` em `CREATE TABLE`

**AV4 — consultas (SQL)**

- [x] 1. `ALTER TABLE` · 2. `CREATE INDEX` · 3. `INSERT INTO` · 4. `UPDATE` · 5. `DELETE`
- [x] 6. `SELECT–FROM–WHERE` · 7. `BETWEEN` · 8. `IN` · 9. `LIKE` · 10. `IS NULL`
- [x] 11. `INNER JOIN` · 12. `MAX` · 13. `MIN` · 14. `AVG` · 15. `COUNT`
- [x] 16. `LEFT/RIGHT OUTER JOIN`
- [x] 17 a 20. Subconsultas: relacional, `IN`, `ANY` e `ALL`
- [x] 21. `ORDER BY` · 22. `GROUP BY` · 23. `HAVING`
- [x] 24. `MINUS` · 25. `CREATE VIEW` · 26. `GRANT/REVOKE`

**AV4 — PL/SQL**

- [x] 1. `RECORD` · 2. `TABLE` · 3. Bloco anônimo · 4. `CREATE PROCEDURE` · 5. `CREATE FUNCTION`
- [x] 6. `%TYPE` · 7. `%ROWTYPE` · 8. `IF/ELSIF` · 9. `CASE WHEN`
- [x] 10. `LOOP EXIT WHEN` · 11. `WHILE LOOP` · 12. `FOR IN LOOP`
- [x] 13. `SELECT ... INTO` · 14. `CURSOR` · 15. `EXCEPTION WHEN` · 16. Uso de parâmetros
- [x] 17. `PACKAGE` · 18. `PACKAGE BODY`
- [x] 19. Trigger de comando · 20. Trigger de linha