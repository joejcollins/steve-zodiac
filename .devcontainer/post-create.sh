#!/bin/sh

# Install the styles not in TeXlive
mkdir -p ~/texmf/tex/latex/conditionals
cp conditionals.sty ~/texmf/tex/latex/conditionals/
mkdir -p ~/texmf/tex/latex/gchords
cp gchords.sty ~/texmf/tex/latex/gchords/
mkdir -p ~/texmf/tex/latex/songbook
cp songbook.sty ~/texmf/tex/latex/songbook/
mktexlsr ~/texmf
