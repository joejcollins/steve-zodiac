# Snakemake DSL file - not valid Python syntax for type checkers

BUILD_DIR = "docs/songbooks"
(DOCS,) = glob_wildcards("tex/{doc}/00main.tex")

rule all:
    input:
        expand(f"{BUILD_DIR}/{{doc}}_chordbook.pdf", doc=DOCS),
        expand(f"{BUILD_DIR}/{{doc}}_wordbook.pdf", doc=DOCS),


rule build_chordbook:
    input:
        "tex/{doc}/00main.tex",
    output:
        chordbook=f"{BUILD_DIR}/{{doc}}_chordbook.pdf",
    params:
        build_dir=BUILD_DIR,
    shell:
        r"""
        export SOURCE_DATE_EPOCH=0
        latexmk \
            -cd -pdf -interaction=nonstopmode -halt-on-error \
            -jobname={wildcards.doc}_chordbook \
            -outdir={workflow.basedir}/docs/songbooks \
            tex/{wildcards.doc}/00main.tex
        latexmk \
            -cd -c -interaction=nonstopmode -halt-on-error \
            -jobname={wildcards.doc}_chordbook \
            -outdir={workflow.basedir}/docs/songbooks \
            tex/{wildcards.doc}/00main.tex
        """

rule build_wordbook:
    input:
        "tex/{doc}/00main.tex",
    output:
        wordbook=f"{BUILD_DIR}/{{doc}}_wordbook.pdf",
    params:
        build_dir=BUILD_DIR,
    shell:
        r"""
        export SOURCE_DATE_EPOCH=0
        latexmk \
            -cd -pdf -interaction=nonstopmode -halt-on-error \
            -pdflatex="pdflatex %O '\def\wordbook{{}}\input{{%S}}'" \
            -jobname={wildcards.doc}_wordbook \
            -outdir={workflow.basedir}/docs/songbooks \
            tex/{wildcards.doc}/00main.tex
        latexmk \
            -cd -c -interaction=nonstopmode -halt-on-error \
            -jobname={wildcards.doc}_wordbook \
            -outdir={workflow.basedir}/docs/songbooks \
            tex/{wildcards.doc}/00main.tex
        """
