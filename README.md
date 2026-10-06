# Sistema Acadêmico — Projeto de Banco de Dados

Scripts de criação e povoamento (Oracle SQL) de um banco de dados acadêmico, gerados a partir do **esquema relacional normalizado** entregue na AV2.

**Equipe:** Arthur Araújo <aan5>, Gabriela Benevides <gtb>, Marcela Parahym <mpxl>, Maria Clara Melo <mcom>, Matheus Reis <mrrs>, Miguel Santos <msnc>.
**Disciplina:** Banco de Dados — CIn/UFPE
**SGBD:** Oracle (testado no Oracle FreeSQL)

---

## Sumário

1. [Estrutura do repositório](#1-estrutura-do-repositório)
2. [Como executar](#2-como-executar)
3. [O que o banco modela](#3-o-que-o-banco-modela)
4. [Decisões de projeto](#4-decisões-de-projeto)
5. [Regras garantidas pelo banco](#5-regras-garantidas-pelo-banco)
6. [Regras que ficam fora do banco](#6-regras-que-ficam-fora-do-banco)
7. [O povoamento](#7-o-povoamento)
8. [Checklist da entrega](#8-checklist-da-entrega)

---

## 1. Estrutura do repositório

```
/
├── README.md
├── criacao.sql        # sequences, tabelas, constraints e CHECKs
└── povoamento.sql     # INSERT INTO de todas as tabelas
└── docs/
    └── (arquivos da AV2: minimundo, modelo ER e esquema relacional)
```

## 2. Como executar

A ordem importa, por causa das chaves estrangeiras: **primeiro `criacao.sql`, depois o `povoamento.sql`.**

### No Oracle FreeSQL (freesql.com)

1. Entre em [freesql.com](https://freesql.com/) com uma conta Oracle gratuita.
2. No Worksheet, cole o conteúdo de `01_criacao.sql` e clique em **Run Script**.
   Use *Run Script*, e não *Run Statement*, que executa só um comando por vez.
3. Confira no Navigator se as 21 tabelas foram criadas.
4. Limpe o editor, cole `02_povoamento.sql` e clique em **Run Script**.

### Conferência rápida

```sql
SELECT 'Turma' tabela, COUNT(*) total FROM Turma
UNION ALL SELECT 'Matricula', COUNT(*) FROM Matricula
UNION ALL SELECT 'Desempenho_em', COUNT(*) FROM Desempenho_em;
```

Resultado esperado: **10 turmas, 57 matrículas e 107 notas.**

### Observações

- O `01_criacao.sql` começa apagando as tabelas e sequences do projeto, então pode ser executado várias vezes.
  Se rodá-lo de novo, rode o `02_povoamento.sql` em seguida.
- O `02_povoamento.sql` conta com as sequences recém-criadas (cursos 1 a 4, salas 1 a 5, turmas 1 a 10).
  Por isso ele deve rodar logo depois do `01`, e do início ao fim.
- Salve os arquivos em **UTF-8**, pois os dados têm acentos.

## 3. O que o banco modela

O banco cobre cadastro de pessoas, cursos e disciplinas, oferta de turmas, matrículas, avaliações e notas, vínculos temporais de alunos e professores, e reserva de salas.

| Grupo | Tabelas |
|---|---|
| Pessoas | `Pessoa`, `Aluno`, `Professor`, `Telefone_pessoa` |
| Estrutura acadêmica | `Departamento`, `Curso`, `Disciplina`, `Bibliografia_disciplina`, `Pre_requisito`, `Compoe_a_grade_curricular_de` |
| Oferta | `Turma`, `Horario_turma`, `Sala`, `Reserva`, `Ministra`, `Monitora` |
| Avaliação | `Avaliacao`, `Matricula`, `Desempenho_em` |
| Histórico temporal | `Vincula_se_a` (aluno × curso), `Lotacao` (professor × departamento) |

Total: **21 tabelas** e **3 sequences** (`seq_curso`, `seq_turma`, `seq_sala`).

## 4. Decisões de projeto

**Ordem de criação.** Tabelas sem dependências vêm primeiro (`Pessoa`, `Departamento`, `Sala`, `Disciplina`), e as que referenciam outras vêm depois.

**Sequences.** Só para chaves técnicas, sem significado no mundo real: curso, turma e sala.
`Avaliacao.num_avaliacao` não usa sequence, porque é o discriminador de uma entidade fraca e reinicia em 1 a cada turma.

**Tipos de dados.**
- CPF é `CHAR(11)`, por ter tamanho fixo.
- Notas são `NUMBER(4,2)`, para aceitar 10.00.
- Pesos são `NUMBER(3,2)`, entre 0 e 1.
- Horários são `VARCHAR2`, porque usam a notação do SIGAA (`24M12` = segunda e quarta, manhã, aulas 1 e 2).

**Nomes de constraints.** Todas têm nome, no padrão `pk_`, `fk_`, `uq_` e `ck_`. As mensagens de erro do Oracle dizem qual regra foi violada.

**Exclusão em cascata.** Só nas tabelas que dependem totalmente de outra: telefone, bibliografia, horário e avaliação. Nas demais a exclusão é bloqueada, para não apagar histórico escolar sem querer.

**Identidade de gênero.** A coluna não tem `CHECK` de propósito: é autodeclarada, e restringir a uma lista seria excludente.

**Senhas.** A coluna guarda o *hash*. Os valores do povoamento são hashes fictícios.

**Créditos da disciplina.** Não são calculados a partir das horas, porque o minimundo diz que são decididos a priori.

## 5. Regras garantidas pelo banco

| Regra do minimundo | Como o banco garante |
|---|---|
| Todo curso pertence a um departamento | `sigla_departamento NOT NULL` + FK |
| Um professor coordena no máximo um curso (1:1) | `UNIQUE (cpf_coordenador)` |
| Aluno vinculado a um curso por vez | Índice único funcional sobre vínculos sem `data_saida` |
| Professor lotado em um departamento por vez | Índice único funcional sobre lotações sem `data_encerramento` |
| Vínculo em aberto não tem data de saída; vínculo encerrado tem | `CHECK ck_vinc_saida` |
| Disciplina obrigatória tem período sugerido | `CHECK ck_grade_obrig` |
| Avaliação final não entra na média | `CHECK ck_aval_final` (tipo `FINAL` exige peso 0) |
| Cada turma tem uma sala, reservada por um professor da turma | `PK (cod_turma)` em `Reserva` + FK composta para `Ministra` |
| Nota só existe para aluno matriculado, em avaliação da mesma turma | Duas FKs compostas em `Desempenho_em` |
| Horário no formato do SIGAA | `CHECK` com expressão regular |
| Disciplina não é pré-requisito dela mesma | `CHECK ck_prereq_distintas` |

Há ainda `CHECK`s de domínio: situação da matrícula, tipo de avaliação, titulação, modalidade, turno, regime de trabalho, formato de CPF e e-mail, notas de 0 a 10, entre outros.

## 6. Regras que ficam fora do banco

Estas regras exigem *trigger* ou lógica de aplicação, e não foram implementadas nos scripts:

- A soma dos pesos das avaliações de uma turma ser 1.
- Sobreposição de horários na grade do aluno e na ocupação das salas.
- Verificação de pré-requisitos no momento da matrícula.
- Cálculo automático da situação (aprovado/reprovado) e do coeficiente de rendimento.
- A capacidade da sala comportar as vagas da turma.

## 7. O povoamento

O cenário simula três períodos letivos. Hoje é o período **2026.2**, que está em andamento.

| Período | Situação | Turmas |
|---|---|---|
| 2025.2 | 1º semestre, encerrado | T1 a T3 |
| 2026.1 | 2º semestre, encerrado | T4 a T6 |
| 2026.2 | 3º semestre, em andamento | T7 a T10 |

**Volume:** 18 pessoas (7 professores e 11 alunos), 4 cursos, 12 disciplinas, 10 turmas, 57 matrículas e 107 notas.

**Regra de aprovação usada nas notas:**
- média ponderada ≥ 7: aprovado;
- média entre 3 e 7: faz a prova final, e aprova se média + final ≥ 10;
- média ≤ 3: reprovado;
- frequência abaixo de 75%: reprovado (suposição, veja a seção 9).

**Casos cobertos, para o banco não ficar "simples demais":**
- aprovação direta;
- aprovação pela prova final;
- reprovação na final;
- reprovação com média menor que 3;
- reprovação por falta, com notas boas;
- trancamento de disciplina e de curso;
- transferência interna (aluna com dois vínculos);
- professor realocado de departamento (duas lotações);
- turma com dois professores;
- mesma sala usada por turmas em horários distintos;
- departamento sem curso;
- semestre em andamento, com só a primeira avaliação lançada;
- cursos com turnos e graus diferentes, e disciplinas obrigatórias e eletivas;
- pré-requisitos encadeados;
- monitoria.

As notas, situações, horários e salas foram conferidos manualmente: quem cursa uma disciplina já foi aprovado nos pré-requisitos, e não há choque de horário.

**Dados fictícios.** CPFs sem dígito verificador, telefones e senhas inventados. O histórico anterior a 2025.2 dos alunos veteranos não foi povoado.

## 8. Checklist da entrega

- [x] `CREATE TABLE`
- [x] `INSERT INTO`
- [x] Cláusula `CONSTRAINT` em `CREATE TABLE`
- [x] `CREATE SEQUENCE`
- [x] Cláusula `CHECK` em `CREATE TABLE`
- [ ] Arquivos da AV2 modificados (em `/docs`)
