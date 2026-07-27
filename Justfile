# Default recipe.
_default: help

# Remove the environment.
clean:
    rm -rf .venv
    rm -rf *.egg-info
    find . -name "*.pyc" -exec rm -f {} \;
    find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete

build_dir := "$(pwd)/docs/songbooks"
docs := "acoustic_knights arts_festival christmas old_time_music_hall songbook_00 songbook_01 songbook_02 songbook_03 acoustic_knights"

# Build one document
build doc:
    latexmk \
        -cd -pdf -interaction=nonstopmode -halt-on-error \
        -jobname={{ doc }}_chordbook \
        -outdir={{ build_dir }} \
        tex/{{ doc }}/00main.tex
    latexmk \
        -cd -pdf -interaction=nonstopmode -halt-on-error \
        -pdflatex="pdflatex %O '\def\wordbook{}\input{%S}'" \
        -jobname={{ doc }}_wordbook \
        -outdir={{ build_dir }} \
        tex/{{ doc }}/00main.tex

# Build all the documents
all:
    for doc in {{ docs }}; do just build $doc; done

# Show help for each of the recipes.
help:
    @just --list

# Create or update the requirements file.
lock:
    uv lock

# Publish the documentation to Github pages.
publish:
    .venv/bin/mkdocs gh-deploy --force --verbose

# Run the snakemake pipeline.
snake:
    .venv/bin/snakemake --cores 1

# Run the unit tests.
test:
    .venv/bin/pytest ./tests --verbose --color=yes

# Create the virtual environment.
venv:
    uv venv .venv --clear
    uv sync 
