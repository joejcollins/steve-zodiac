"""Find the files that match a pattern down from a starting directory."""

DOCS, = glob_wildcards("tex/{doc}/00main.tex")
