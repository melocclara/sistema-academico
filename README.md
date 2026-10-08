# Sistema Acadêmico — Projeto de Banco de Dados

Implementação em Oracle SQL do **esquema relacional normalizado** do nosso sistema acadêmico (entrega AV2): scripts de **criação** e **povoamento** das tabelas.

**Equipe:** Arthur Araújo, Gabriela Benevides, Marcela Lins, Maria Clara Melo, Matheus Reis, Miguel Santos.
**Disciplina:** Banco de Dados — CIn/UFPE

---

## Sumário

1. [Visão geral](#1-visão-geral)
2. [Estrutura do repositório](#2-estrutura-do-repositório)
3. [Como executar](#3-como-executar)
4. [Tabelas](#4-tabelas)
5. [Decisões de projeto](#5-decisões-de-projeto)
6. [Regras de integridade por tabela](#6-regras-de-integridade-por-tabela)
7. [Povoamento](#7-povoamento)
8. [Ajustes em relação à AV2](#8-ajustes-em-relação-à-av2)
9. [Checklist da entrega](#9-checklist-da-entrega)

---

## 1. Visão geral

O banco representa a rotina acadêmica de uma instituição de ensino: cadastro de pessoas (alunos e professores), cursos, departamentos e disciplinas; oferta de turmas com horários e salas; matrículas; avaliações e notas; e o histórico de vínculos de alunos com cursos e de professores com departamentos.

O script de criação traduz cada relação do esquema normalizado em uma tabela, e usa o próprio banco para garantir as regras do minimundo por meio de chaves, restrições `UNIQUE`, `CHECK` e índices únicos. O script de povoamento insere dados fictícios com volume e variedade suficientes para exercitar todas as tabelas e relacionamentos.

## 2. Estrutura do repositório

```
/
├── README.md
├── sql/
│   ├── criacao.sql        # CREATE SEQUENCE, CREATE TABLE, CONSTRAINTs e CHECKs
│   └── povoamento.sql     # INSERT INTO de todas as tabelas
└── docs/
    └── (arquivos da AV2: minimundo, modelo ER e esquema relacional)
```

## 3. Como executar

Os scripts foram escritos para Oracle SQL e podem ser executados no Oracle Live SQL (FreeSQL). A ordem importa, por causa das chaves estrangeiras: **primeiro a criação, depois o povoamento.**

1. Abra [freesql.com](https://freesql.com/) e entre no Worksheet.
2. Cole o conteúdo de `criacao.sql` e execute com **Run Script**.
3. Limpe o editor, cole `povoamento.sql` e execute com **Run Script**.

Para conferir o resultado:

```sql
SELECT 'pessoa' tabela, COUNT(*) total FROM pessoa
UNION ALL SELECT 'aluno', COUNT(*) FROM aluno
UNION ALL SELECT 'professor', COUNT(*) FROM professor
UNION ALL SELECT 'turma', COUNT(*) FROM turma
UNION ALL SELECT 'matricula', COUNT(*) FROM matricula
UNION ALL SELECT 'desempenho_em', COUNT(*) FROM desempenho_em;
```

Resultado esperado: 48 pessoas, 32 alunos, 16 professores, 24 turmas, 80 matrículas e 100 notas.

## 4. Tabelas

O banco tem **21 tabelas** e **1 sequence** (`curso_seq`).

| Grupo | Tabelas |
|---|---|
| Pessoas | `pessoa`, `telefone_pessoa`, `aluno`, `professor` |
| Estrutura acadêmica | `departamento`, `curso`, `disciplina`, `bibliografia_disciplina`, `pre_requisito`, `compoe_a_grade_curricular_de` |
| Oferta de turmas | `turma`, `horario_turma`, `sala`, `reserva`, `ministra`, `monitora` |
| Avaliação | `avaliacao`, `matricula`, `desempenho_em` |
| Histórico temporal | `vincula_se_a` (aluno × curso), `lotacao` (professor × departamento) |

## 5. Decisões de projeto

### Organização e nomenclatura

- O script de criação é dividido em três blocos comentados — *pessoa e especializações*, *entidades principais* e *tabelas de relacionamento* — e cada tabela é criada depois das que ela referencia, de modo que o script roda de uma vez, sem erros de dependência.
- Toda restrição tem nome explícito, com sufixo que indica o tipo (`_pk`, `_fk`, `_uk`, `_ck`), como em `pessoa_email_uk` e `curso_cpf_fk`. Assim, qualquer mensagem de erro do Oracle aponta diretamente para a regra violada.
- Campos de tamanho fixo (CPF, número de matrícula) usam `CHAR`; textos variáveis usam `VARCHAR2`; pesos usam `NUMBER(3,2)` e notas usam `NUMBER(3,1)`.

### Chaves

- **Chaves naturais** onde o mundo real já fornece o identificador: CPF (`pessoa`), sigla (`departamento`), código da disciplina (por exemplo, `IF101`), código da turma e código da sala.
- **Chave gerada por sequence** apenas onde o identificador é puramente técnico: `curso.codigo_id`, alimentado por `curso_seq`.
- **Especialização por chave compartilhada:** `aluno` e `professor` usam como PK o próprio `cpf_pessoa`, que também é FK para `pessoa`. Assim, cada aluno ou professor corresponde a exatamente uma pessoa.
- **Entidade fraca:** `avaliacao` tem PK composta `(num_avaliacao, cod_turma)`: o número da avaliação é discriminador e só identifica a avaliação dentro da turma.
- **Tabelas associativas** têm PK composta pelas chaves das entidades que ligam (`matricula`, `ministra`, `monitora`, `pre_requisito`, `compoe_a_grade_curricular_de` e `desempenho_em`).

### Atributos multivalorados, compostos e derivados

- **Multivalorados** viraram tabelas próprias: telefones de uma pessoa (`telefone_pessoa`), bibliografia de uma disciplina (`bibliografia_disciplina`) e horários de uma turma (`horario_turma`). Isso mantém todas as colunas atômicas (1FN).
- **Compostos** foram divididos em colunas simples: carga horária em `ch_teorica` e `ch_pratica`; localização da sala em `predio`, `bloco` e `andar`; dados institucionais em `usuario` e `senha`.
- **Derivado:** a nota final da matrícula não é armazenada, para não haver risco de inconsistência com as notas lançadas. Ela é calculada pelas avaliações e seus pesos:

```sql
SELECT d.cpf_aluno, d.cod_turma,
       ROUND(SUM(d.nota * a.peso), 2) AS media_ponderada
FROM   desempenho_em d
JOIN   avaliacao a
       ON a.cod_turma = d.cod_turma AND a.num_avaliacao = d.num_avaliacao
GROUP  BY d.cpf_aluno, d.cod_turma;
```

### Relacionamentos

- **Oferece (1:N):** `curso.sigla_departamento` é `NOT NULL`, pois todo curso pertence a um departamento.
- **Coordena (1:1):** `curso.cpf_coordenador` é `NOT NULL` e `UNIQUE`. Todo curso tem um coordenador, e um professor coordena no máximo um curso.
- **Compõe a oferta de (N:1):** `turma.codigo_disciplina` referencia a disciplina ofertada.
- **Relacionamentos N:N** (ministra, monitora, pré-requisito, grade curricular) viraram tabelas associativas. Em `pre_requisito`, um `CHECK` impede que uma disciplina seja pré-requisito de si mesma, e uma disciplina pode ter vários pré-requisitos.
- **Desempenho em:** `desempenho_em` tem **duas chaves estrangeiras compostas** que compartilham `cod_turma`: uma para `matricula (cpf_aluno, cod_turma)` e outra para `avaliacao (num_avaliacao, cod_turma)`. Com isso, o banco só aceita a nota de um aluno que esteja matriculado na turma, e em uma avaliação daquela mesma turma.
- **Reserva:** associa professor, sala e turma, com chaves estrangeiras para as três tabelas.

### Relacionamentos temporais

`vincula_se_a` (aluno × curso) e `lotacao` (professor × departamento) guardam o histórico completo. Por isso `data_ingresso` e `data_admissao` fazem parte das chaves primárias, o que permite que a mesma pessoa tenha vários períodos de vínculo com o mesmo curso ou departamento.

Duas regras do minimundo são garantidas por **índices únicos funcionais**:

- `vinculo_ativo_uk`: cada aluno tem no máximo **um vínculo em aberto** (sem data de saída), isto é, um curso por vez.
- `lotacao_vigente_uk`: cada professor tem no máximo **uma lotação vigente** (sem data de encerramento), isto é, um departamento por vez.

O índice usa uma expressão `CASE` que devolve o CPF apenas quando o registro está em aberto. Como o Oracle não indexa valores nulos, registros encerrados ficam livres para se repetir.

## 6. Regras de integridade por tabela

| Tabela | Regras garantidas pelo banco |
|---|---|
| `pessoa` | CPF com 11 dígitos; e-mail em formato válido; e-mail e usuário únicos; usuário sem espaços; senha com no mínimo 8 caracteres e sem espaços; identidade de gênero opcional e, quando informada, dentro de uma lista padronizada (Mulher cis, Mulher trans, Homem cis, Homem trans, Não-binário, Outro) |
| `telefone_pessoa` | telefone com 10 ou 11 dígitos |
| `aluno` / `professor` | número de matrícula único; titulação restrita a Doutorado, Mestrado, Especialização ou Graduação |
| `departamento` | nome e telefone únicos; telefone com 10 ou 11 dígitos |
| `curso` | carga horária e vagas positivas; modalidade (Presencial, EAD, Híbrido), turno (Matutino, Vespertino, Noturno, Integral) e grau (Bacharelado, Licenciatura, Tecnólogo) dentro dos domínios; combinação nome + modalidade + turno + grau única; coordenador único |
| `disciplina` | cargas teórica e prática não negativas, com soma positiva; créditos positivos |
| `turma` | período no formato `AAAA.S` (semestre 1 ou 2); turno dentro do domínio; vagas positivas |
| `horario_turma` | horário na notação do SIGAA: dias (2 a 7), turno (M, T ou N) e aulas (1 a 6) |
| `sala` | capacidade positiva; andar maior ou igual a zero |
| `avaliacao` | tipo (Prova, Trabalho, Seminário, Apresentação, Lista); peso maior que 0 e no máximo 1 |
| `matricula` | frequência de 0 a 100; situação (Aprovado, Reprovado, Trancado, Matriculado) |
| `compoe_a_grade_curricular_de` | tipo (Obrigatória, Eletiva); período sugerido entre 1 e 12; disciplina obrigatória exige período sugerido |
| `desempenho_em` | nota entre 0 e 10 |
| `vincula_se_a` | situação (Ativo, Trancado, Formado, Desligado); coeficiente de rendimento entre 0 e 10; forma de ingresso (Vestibular, SISU, Transferência, Outro); vínculo ativo ou trancado não tem data de saída, vínculo encerrado tem; saída nunca anterior ao ingresso |
| `lotacao` | regime (40 horas, 20 horas, Dedicação exclusiva); encerramento nunca anterior à admissão |

## 7. Povoamento

O script de povoamento insere os dados na ordem das dependências entre as tabelas e termina com `COMMIT`.

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

### Cenário simulado

Todos os dados são fictícios: nomes, CPFs, telefones, matrículas e e-mails (em um domínio de exemplo). Eles descrevem uma universidade com **8 departamentos, 12 cursos e 30 disciplinas**, e **24 turmas distribuídas em três períodos letivos** (2025.2, 2026.1 e 2026.2).

Para o banco não ficar "simples demais", o povoamento cobre situações variadas:

- **Cursos diversos:** bacharelados e licenciaturas, em modalidades presencial, híbrida e EAD, e nos quatro turnos.
- **Grade curricular:** cada curso tem disciplinas obrigatórias com período sugerido e disciplinas eletivas, com cadeias de pré-requisitos (por exemplo, IF101 → IF102 → IF103 → IF104) e uma disciplina com dois pré-requisitos (Econometria).
- **Turmas:** com um ou mais horários semanais, em turnos e salas variados (salas de aula e laboratórios, em prédios diferentes), e diversas turmas com mais de um professor. Os horários foram distribuídos para evitar sobreposição.
- **Avaliações:** os cinco tipos (prova, trabalho, seminário, apresentação e lista), com pesos que somam 1 em cada turma e turmas com duas ou três avaliações.
- **Matrículas:** aprovações, reprovações, trancamentos e matrículas em andamento. Nas turmas do período corrente há notas lançadas parcialmente.
- **Histórico de alunos:** vínculos ativos, trancados, formados e desligados, incluindo alunos que concluíram ou deixaram um curso e ingressaram em outro. Os ingressantes mais recentes ainda não têm coeficiente de rendimento.
- **Histórico de professores:** docentes que mudaram de departamento ao longo do tempo, com lotação encerrada e nova lotação vigente, nos três regimes de trabalho.
- **Pessoas:** identidades de gênero, titulações e formas de ingresso diversas; telefones múltiplos para parte das pessoas.
- **Monitoria:** alunos monitorando turmas em que não estão matriculados.

## 8. Ajustes em relação à AV2

Ao implementar o esquema relacional da AV2, fizemos pequenos ajustes de nomes e de restrições:

1. **`desempenho_em`:** a chave estrangeira para `avaliacao` é composta, `(num_avaliacao, cod_turma)`, de acordo com a chave primária composta da entidade fraca.
2. **`avaliacao`:** a coluna `data` passou a se chamar `data_avaliacao`.
3. **`vincula_se_a`:** a coluna `status` passou a se chamar `situacao`, e `data_ingresso` consta como parte da chave primária.
4. **`lotacao`:** `data_admissao` consta como parte da chave primária.
5. **`telefone_pessoa`:** a coluna que referencia a pessoa chama-se `cpf_pessoa`.
6. **`matricula`:** a situação "cursando" do minimundo é registrada como `Matriculado`.
7. **Domínios:** valores permitidos de colunas como `forma_ingresso` e `situacao` foram definidos por `CHECK` (seção 6).

Os arquivos da AV2 correspondentes estão atualizados na pasta `docs/`.

## 9. Checklist da entrega

- [x] `CREATE TABLE`: 21 tabelas
- [x] `INSERT INTO`: povoamento de todas as tabelas
- [x] Cláusula `CONSTRAINT` em `CREATE TABLE`: chaves primárias, estrangeiras e únicas, todas nomeadas
- [x] `CREATE SEQUENCE`: `curso_seq`, para a chave de `curso`
- [x] Cláusula `CHECK` em `CREATE TABLE`: domínios, formatos e regras de consistência (seção 6)
- [x] Arquivos da AV2 modificados: pasta `docs/`