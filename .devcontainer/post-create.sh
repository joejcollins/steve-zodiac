#!/bin/sh

# Install the styles not in TeXlive
mkdir -p ~/texmf/tex/latex/conditionals
cp ./assets/styles/conditionals.sty ~/texmf/tex/latex/conditionals/
mkdir -p ~/texmf/tex/latex/gchords
cp ./assets/styles/gchords.sty ~/texmf/tex/latex/gchords/
mkdir -p ~/texmf/tex/latex/songbook
cp ./assets/styles/songbook.sty ~/texmf/tex/latex/songbook/
mktexlsr ~/texmf

# Create the virtual environment.
just venv
