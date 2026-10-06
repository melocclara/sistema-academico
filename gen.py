import argparse
import random

# =========================
# CONFIGURACAO
# =========================

N_ALUNOS = 50
N_PROFESSORES = 6
N_TURMAS = 12
N_AVALIACOES = 2
MATRICULAS_POR_ALUNO = 4
SEED = 42
SAIDA = "02_povoamento.sql"

parser = argparse.ArgumentParser()
parser.add_argument("--alunos", type=int, default=N_ALUNOS)
parser.add_argument("--professores", type=int, default=N_PROFESSORES)
parser.add_argument("--turmas", type=int, default=N_TURMAS)
parser.add_argument("--avaliacoes", type=int, default=N_AVALIACOES)
parser.add_argument("--matriculas", type=int, default=MATRICULAS_POR_ALUNO)
parser.add_argument("--seed", type=int, default=SEED)
parser.add_argument("--saida", default=SAIDA)
cfg = parser.parse_args()

if cfg.professores < 2:
    raise ValueError("Use pelo menos 2 professores.")

if cfg.matriculas > cfg.turmas:
    raise ValueError("Matriculas por aluno nao pode superar o numero de turmas.")

random.seed(cfg.seed)
out = []


class SQL(str):
    pass

def fmt(x):
    if x is None:
        return "NULL"
    if isinstance(x, SQL):
        return x
    if isinstance(x, (int, float)):
        return str(x)
    return "'" + str(x).replace("'", "''") + "'"


def insert(tabela, colunas, valores):
    cols = ", ".join(colunas)
    vals = ", ".join(fmt(x) for x in valores)
    out.append(f"INSERT INTO {tabela} ({cols}) VALUES ({vals});")

def secao(nome):
    out.append(f"\n-- {nome}")

departamentos = [
    ("CIN", "Centro de Informática", "CIn", "8130000001"),
    ("DMAT", "Departamento de Matemática", "Área II", "8130000002"),
]

disciplinas = [
    ("Programação", "Fundamentos de programação", 45, 15, 4),
    ("Estruturas de Dados", "Estruturas de dados", 45, 15, 4),
    ("Banco de Dados", "Modelagem de bancos de dados", 45, 15, 4),
    ("Algoritmos", "Projeto e análise de algoritmos", 60, 0, 4),
    ("Cálculo I", "Limites, derivadas e integrais", 60, 0, 4),
    ("Álgebra Linear", "Matrizes e espaços vetoriais", 60, 0, 4),
]

secao("DEPARTAMENTOS")
for d in departamentos:
    insert(
        "Departamento",
        ["sigla", "nome", "localizacao", "telefone"],
        d
    )

secao("PROFESSORES")
professores = []

for i in range(1, cfg.professores + 1):
    cpf = f"{10000000000 + i}"
    professores.append(cpf)

    insert(
        "Pessoa",
        ["cpf", "nome_completo", "data_nasc", "identidade_genero",
         "email", "usuario", "senha"],
        [cpf, f"Professor {i}", SQL("DATE '1980-01-01'"), None,
         f"prof{i}@ufpe.br", f"prof{i}", "senha123"]
    )

    insert(
        "Professor",
        ["cpf_pessoa", "num_matricula_func", "titulacao"],
        [cpf, f"P{i:04}", random.choice(["Mestrado", "Doutorado"])]
    )
secao("ALUNOS")
alunos = []
for i in range(1, cfg.alunos + 1):
    cpf = f"{50000000000 + i}"
    alunos.append(cpf)

    insert(
        "Pessoa",
        ["cpf", "nome_completo", "data_nasc", "identidade_genero",
         "email", "usuario", "senha"],
        [cpf, f"Aluno {i}", SQL("DATE '2004-01-01'"), None,
         f"aluno{i}@ufpe.br", f"aluno{i}", "senha123"]
    )

    insert(
        "Aluno",
        ["cpf_pessoa", "num_matricula"],
        [cpf, f"2026{i:05}"]
    )

secao("DISCIPLINAS")
for d in disciplinas:
    insert(
        "Disciplina",
        ["codigo", "nome", "ementa", "ch_teorica",
         "ch_pratica", "num_creditos"],
        [SQL("seq_disciplina.NEXTVAL"), *d]
    )


secao("SALAS")
for capacidade, predio, bloco, andar in [
    (40, "CIn", "A", 1),
    (60, "CIn", "B", 2),
    (50, "Área II", "C", 1),
]:
    insert(
        "Sala",
        ["cod_sala", "capacidade", "predio", "bloco", "andar"],
        [SQL("seq_sala.NEXTVAL"), capacidade, predio, bloco, andar]
    )

secao("CURSOS")
cursos = [
    ("Ciência da Computação", 3200, "Integral", professores[0], "CIN"),
    ("Matemática", 3000, "Manhã", professores[1], "DMAT"),
]

for nome, ch, turno, coordenador, departamento in cursos:
    insert(
        "Curso",
        ["codigo_id", "nome", "ch_total", "modalidade", "turno",
         "num_vagas", "grau_academico", "cpf_coordenador",
         "sigla_departamento"],
        [SQL("seq_curso.NEXTVAL"), nome, ch, "Presencial", turno,
         60, "Bacharelado", coordenador, departamento]
    )

secao("LOTACAO")
for i, cpf in enumerate(professores):
    insert(
        "Lotacao",
        ["cpf_professor", "sigla_dept", "data_admissao",
         "regime_trabalho", "data_encerramento"],
        [cpf, "CIN" if i % 2 == 0 else "DMAT",
         SQL("DATE '2020-01-01'"), "40h", None]
    )

secao("VINCULOS")
for i, cpf in enumerate(alunos):
    curso = i % 2 + 1

    insert(
        "Vincula_se_a",
        ["cpf_aluno", "codigo_curso", "data_ingresso", "status",
         "coeficiente_rendimento", "forma_ingresso", "data_saida"],
        [cpf, curso, SQL("DATE '2026-03-01'"), "Ativo",
         round(random.uniform(5, 10), 2), "SISU", None]
    )

secao("GRADE CURRICULAR")
for curso in (1, 2):
    for disciplina in range(1, len(disciplinas) + 1):
        insert(
            "Compoe_a_grade_curricular_de",
            ["codigo_disciplina", "codigo_id", "tipo", "periodo_sugerido"],
            [disciplina, curso, "Obrigatória", (disciplina + 1) // 2]
        )

secao("PRE-REQUISITOS")
for disciplina, requisito in [(2, 1), (3, 1), (4, 2)]:
    insert(
        "Pre_requisito",
        ["codigo_disciplina", "codigo_requisito"],
        [disciplina, requisito]
    )



secao("TURMAS")
for turma in range(1, cfg.turmas + 1):
    disciplina = (turma - 1) % len(disciplinas) + 1

    insert(
        "Turma",
        ["cod_turma", "periodo", "turno", "num_vagas",
         "codigo_disciplina"],
        [SQL("seq_turma.NEXTVAL"), "2026.2",
         random.choice(["Manhã", "Tarde", "Noite"]),
         50, disciplina]
    )

    insert(
        "Horario_turma",
        ["cod_turma", "horario"],
        [turma, f"{2 + turma % 5}M12"]
    )

secao("MINISTRA E RESERVA")
for turma in range(1, cfg.turmas + 1):
    professor = professores[(turma - 1) % len(professores)]

    insert(
        "Ministra",
        ["cpf_professor", "cod_turma"],
        [professor, turma]
    )

    insert(
        "Reserva",
        ["cpf_pessoa", "cod_sala", "cod_turma"],
        [professor, (turma - 1) % 3 + 1, turma]
    )

secao("AVALIACOES")
for turma in range(1, cfg.turmas + 1):
    for n in range(1, cfg.avaliacoes + 1):
        insert(
            "Avaliacao",
            ["num_avaliacao", "cod_turma", "tipo",
             "peso", "data_avaliacao"],
            [n, turma, "Prova", round(1 / cfg.avaliacoes, 2),
             SQL(f"DATE '2026-{min(8 + n, 12):02}-15'")]
        )

secao("MATRICULAS E NOTAS")
alunos_turma = {i: [] for i in range(1, cfg.turmas + 1)}

for aluno in alunos:
    turmas = random.sample(
        range(1, cfg.turmas + 1),
        cfg.matriculas
    )

    for turma in turmas:
        alunos_turma[turma].append(aluno)

        insert(
            "Matricula",
            ["cpf_aluno", "cod_turma", "frequencia", "situacao"],
            [aluno, turma, random.randint(70, 100), "Cursando"]
        )

        for n in range(1, cfg.avaliacoes + 1):
            insert(
                "Desempenho_em",
                ["cod_turma", "cpf_aluno", "num_avaliacao", "nota"],
                [turma, aluno, n, round(random.uniform(4, 10), 2)]
            )

secao("MONITORIA")
for turma, matriculados in alunos_turma.items():
    if matriculados:
        insert(
            "Monitora",
            ["cpf_aluno", "cod_turma"],
            [matriculados[0], turma]
        )

secao("TELEFONES")
for i, cpf in enumerate(professores + alunos, 1):
    insert(
        "Telefone_pessoa",
        ["cpf_pessoa", "telefone"],
        [cpf, f"819{90000000 + i}"]
    )

secao("BIBLIOGRAFIAS")
for i, disciplina in enumerate(disciplinas, 1):
    insert(
        "Bibliografia_disciplina",
        ["codigo_disciplina", "referencia"],
        [i, f"Livro de {disciplina[0]}"]
    )

out.append("\nCOMMIT;")
with open(cfg.saida, "w", encoding="utf-8") as f:
    f.write("\n".join(out))

print(f"{cfg.saida} gerado com {len(out)} comandos.")