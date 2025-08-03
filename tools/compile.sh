#!/bin/bash
# tools/compile.sh - Unix/Linux/macOS compilation script

echo "Compiling Constitution of India LaTeX document..."
echo "Using Source of India LaTeX Class v1.0"

# Clean previous compilation files
rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz 2>/dev/null

# First compilation pass
echo "First pass..."
pdflatex -interaction=nonstopmode main.tex

# Second compilation pass for cross-references and TOC
echo "Second pass..."
pdflatex -interaction=nonstopmode main.tex

# Check if PDF was generated successfully
if [ -f "main.pdf" ]; then
    echo "Compilation successful! Generated main.pdf"
    echo "Document statistics:"
    echo "- Pages: $(pdfinfo main.pdf 2>/dev/null | grep Pages | awk '{print $2}')"
    echo "- File size: $(ls -lh main.pdf | awk '{print $5}')"
else
    echo "Compilation failed! Check the log files for errors."
    exit 1
fi

# Optional: Open PDF if viewer is available
if command -v xdg-open >/dev/null 2>&1; then
    echo "Opening PDF with default viewer..."
    xdg-open main.pdf
elif command -v open >/dev/null 2>&1; then
    echo "Opening PDF with default viewer..."
    open main.pdf
fi

echo "Compilation complete!"