# Default recipe.
_default: help

build_dir := "$(pwd)/docs/songbooks"

# Show help for each of the recipes.
help:
    @just --list

# Build all the songbooks
build:
    cd tex/arts_festival && pdflatex -output-directory=../../docs/songbooks -jobname=ArtsFestChords 00ArtsFest.tex
    cd tex/arts_festival && pdflatex -output-directory=../../docs/songbooks -jobname=ArtsFestWords "\def\wordbook{}\input{00ArtsFest.tex}"

