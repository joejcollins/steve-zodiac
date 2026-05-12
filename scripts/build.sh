#!/usr/bin/env bash
set -euo pipefail

TEXFILE="$1"
JOBNAME="$2"
MODE="${3:-chord}"

OUTDIR="../../docs/songbooks"

if [ "$MODE" = "word" ]; then
    TEXINPUT="\def\wordbook{}\input{$TEXFILE}"
else
    TEXINPUT="$TEXFILE"
fi

cd tex/arts_festival

pdflatex \
    -output-directory="$OUTDIR" \
    -jobname="$JOBNAME" \
    "$TEXINPUT"
