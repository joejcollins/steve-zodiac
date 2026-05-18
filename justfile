# Default recipe.
_default: help

build_dir := "$(pwd)/docs/songbooks"
docs := "arts_festival christmas old_time_music_hall songbook_00 songbook_01 songbook_02 songbook_03 acoustic"

# Build one document
build doc:
    latexmk \
        -cd -pdf -interaction=nonstopmode -halt-on-error \
        -jobname={{doc}}_chordbook \
        -outdir={{build_dir}} \
        tex/{{doc}}/00main.tex
    latexmk \
        -cd -pdf -interaction=nonstopmode -halt-on-error \
        -pdflatex="pdflatex %O '\def\wordbook{}\input{%S}'" \
        -jobname={{doc}}_wordbook \
        -outdir={{build_dir}} \
        tex/{{doc}}/00main.tex

# Build all the documents
all:
    for doc in {{docs}}; do just build $doc; done

# Show help for each of the recipes.
help:
    @just --list

