#!/bin/bash
# Source of India LaTeX Compilation Helper
# Usage: ./compile.sh [filename]

set -e

# Default file to compile
FILE="main.tex"

# If argument provided, use that file
if [ "$1" != "" ]; then
    FILE="$1"
fi

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE not found!"
    exit 1
fi

# Get filename without extension
BASENAME=$(basename "$FILE" .tex)

echo "Compiling $FILE..."

# First compilation
pdflatex -interaction=nonstopmode "$FILE"

# Check if we need bibliography
if grep -q "\\bibliography" "$FILE" || grep -q "\\bibdata" "${BASENAME}.aux" 2>/dev/null; then
    echo "Running bibtex..."
    bibtex "$BASENAME"
fi

# Second compilation for cross-references
echo "Second compilation for cross-references..."
pdflatex -interaction=nonstopmode "$FILE"

# Third compilation if needed for complex cross-references
if grep -q "Rerun to get cross-references right" "${BASENAME}.log" 2>/dev/null; then
    echo "Third compilation for complex cross-references..."
    pdflatex -interaction=nonstopmode "$FILE"
fi

echo "Compilation complete: ${BASENAME}.pdf"

# Clean up auxiliary files (optional)
if [ "$2" = "clean" ]; then
    echo "Cleaning auxiliary files..."
    rm -f "${BASENAME}.aux" "${BASENAME}.log" "${BASENAME}.toc" "${BASENAME}.out" "${BASENAME}.fls" "${BASENAME}.fdb_latexmk"
fi