#!/bin/bash
# tools/clean.sh - Unix/Linux/macOS cleanup script

echo "Cleaning LaTeX compilation files..."

# Remove all LaTeX auxiliary files
rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm *.vrb *.bbl *.blg *.idx *.ind *.ilg *.lof *.lot *.thm

# Remove PDF output (optional - comment out if you want to keep PDFs)
# rm -f *.pdf

echo "Cleanup complete!"

# Windows version (tools/clean.bat):
# @echo off
# echo Cleaning LaTeX compilation files...
# del /q *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm *.vrb *.bbl *.blg *.idx *.ind *.ilg *.lof *.lot *.thm >nul 2>&1
# REM del /q *.pdf >nul 2>&1
# echo Cleanup complete!