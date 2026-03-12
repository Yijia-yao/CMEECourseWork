#!/usr/bin/env bash
set -euo pipefail

# Project root = parent of Code/
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

REPORT_DIR="$ROOT_DIR/TheReport"
REPORT_TEX="$REPORT_DIR/report.tex"

# sanity checks
test -f "$REPORT_TEX"
test -f "$REPORT_DIR/references.bib"

# --- auto word count (Words in text only) ---
WC=$(texcount -inc -sum=1,1,0,0,0 "$REPORT_TEX" | awk '/Words in text:/ {print $4}')
echo "\\newcommand{\\WordCount}{$WC}" > "$REPORT_DIR/wordcount.tex"

cd "$REPORT_DIR"
rm -f report.aux report.bbl report.blg report.log report.out report.fls report.fdb_latexmk

pdflatex -interaction=nonstopmode -halt-on-error report.tex
bibtex report || true
pdflatex -interaction=nonstopmode -halt-on-error report.tex
pdflatex -interaction=nonstopmode -halt-on-error report.tex

echo "Built: $REPORT_DIR/report.pdf"
echo "Word count (Words in text): $WC"