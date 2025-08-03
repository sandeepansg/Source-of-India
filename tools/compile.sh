#!/bin/bash
# tools/compile_fixed.sh - Enhanced compilation script for fixed SOI class

echo "Compiling Constitution of India LaTeX document..."
echo "Using Source of India LaTeX Class v1.1 (Fixed Version)"
echo "Features: Two-sided layout, corrected amendments, enhanced typography"

# Clean previous compilation files
echo "Cleaning previous compilation files..."
rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz 2>/dev/null

# Check if main document exists
if [ ! -f "main.tex" ]; then
    echo "Warning: main.tex not found, checking for sample.tex..."
    if [ ! -f "sample.tex" ]; then
        echo "Error: Neither main.tex nor sample.tex found!"
        echo "Please ensure you have a LaTeX document to compile."
        exit 1
    fi
    MAIN_FILE="sample.tex"
else
    MAIN_FILE="main.tex"
fi

echo "Compiling document: $MAIN_FILE"

# First compilation pass
echo "First pass (generating structure)..."
pdflatex -interaction=nonstopmode "$MAIN_FILE" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "First pass failed! Check compilation errors:"
    pdflatex -interaction=nonstopmode "$MAIN_FILE" | tail -20
    exit 1
fi

# Second compilation pass for cross-references and TOC
echo "Second pass (resolving references)..."
pdflatex -interaction=nonstopmode "$MAIN_FILE" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Second pass failed! Check compilation errors:"
    pdflatex -interaction=nonstopmode "$MAIN_FILE" | tail -20
    exit 1
fi

# Third pass to ensure all references are resolved (for complex documents)
echo "Third pass (finalizing)..."
pdflatex -interaction=nonstopmode "$MAIN_FILE" > /dev/null 2>&1

# Determine output PDF name
OUTPUT_PDF="${MAIN_FILE%.tex}.pdf"

# Check if PDF was generated successfully
if [ -f "$OUTPUT_PDF" ]; then
    echo "✓ Compilation successful! Generated $OUTPUT_PDF"
    
    # Get document statistics
    if command -v pdfinfo >/dev/null 2>&1; then
        PAGES=$(pdfinfo "$OUTPUT_PDF" 2>/dev/null | grep Pages | awk '{print $2}')
        echo "Document statistics:"
        echo "- Pages: ${PAGES:-Unknown}"
        echo "- File size: $(ls -lh "$OUTPUT_PDF" | awk '{print $5}')"
        echo "- Layout: Two-sided with binding offset"
        echo "- Amendment system: Corrected (text in main, citations in footnotes)"
    fi
    
    # Count compilation artifacts for cleanup reference
    ARTIFACTS=$(ls *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz 2>/dev/null | wc -l)
    if [ $ARTIFACTS -gt 0 ]; then
        echo "- Auxiliary files created: $ARTIFACTS (run tools/cleanup.sh to remove)"
    fi
    
else
    echo "✗ Compilation failed! PDF was not generated."
    echo "Check the following common issues:"
    echo "1. Missing article files in content/articles/"
    echo "2. Missing part files in content/parts/"
    echo "3. Incorrect amendment syntax in article files"
    echo "4. LaTeX compilation errors in .log file"
    exit 1
fi

# Optional: Open PDF if viewer is available
if [ "$1" = "--open" ]; then
    if command -v xdg-open >/dev/null 2>&1; then
        echo "Opening PDF with default viewer..."
        xdg-open "$OUTPUT_PDF"
    elif command -v open >/dev/null 2>&1; then
        echo "Opening PDF with default viewer..."
        open "$OUTPUT_PDF"
    else
        echo "No PDF viewer found. Please open $OUTPUT_PDF manually."
    fi
fi

echo "Compilation complete!"

# Show brief usage help
echo ""
echo "Usage: $0 [--open]"
echo "  --open    Open the generated PDF with default viewer"
echo ""
echo "Files processed:"
echo "- Main document: $MAIN_FILE"
echo "- Configuration: config.tex"
echo "- Class file: soi.cls (v1.1 with fixes)"
echo "- Content files: content/ directory (modular structure)"