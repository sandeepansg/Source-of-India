@echo off
REM tools/clean.bat - Windows cleanup script

echo Cleaning LaTeX compilation files...

REM Remove all LaTeX auxiliary files
del /q *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm *.vrb *.bbl *.blg *.idx *.ind *.ilg *.lof *.lot *.thm >nul 2>&1

REM Remove PDF output (optional - comment out if you want to keep PDFs)
REM del /q *.pdf >nul 2>&1

echo Cleanup complete!