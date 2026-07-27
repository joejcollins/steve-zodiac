# Snakemake DSL file - not valid Python syntax for type checkers

BUILD_DIR = "docs/songbooks"
(DOCS,) = glob_wildcards("tex/{doc}/00main.tex")


print(f"Found {len(DOCS)} songbooks: {DOCS}")


rule all:
    input:
        expand(f"{BUILD_DIR}/{{doc}}_chordbook.pdf", doc=DOCS),
        expand(f"{BUILD_DIR}/{{doc}}_wordbook.pdf", doc=DOCS),


rule build_songbook:
    input:
        "tex/{doc}/00main.tex",
    output:
        chordbook=f"{BUILD_DIR}/{{doc}}_chordbook.pdf",
        wordbook=f"{BUILD_DIR}/{{doc}}_wordbook.pdf",
    params:
        build_dir=BUILD_DIR,
    shell:
        """
        latexmk \
            -cd -pdf -interaction=nonstopmode -halt-on-error \
            -jobname={wildcards.doc}_chordbook \
            -outdir={params.build_dir} \
            tex/{wildcards.doc}/00main.tex
        """
