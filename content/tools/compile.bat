@echo off
REM tools/compile.bat - Windows compilation script

echo Compiling Constitution of India LaTeX document...
echo Using Source of India LaTeX Class v1.0

REM Clean previous compilation files
del /q *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz >nul 2>&1

REM First compilation pass
echo First pass...
pdflatex -interaction=nonstopmode main.tex

REM Second compilation pass for cross-references and TOC
echo Second pass...
pdflatex -interaction=nonstopmode main.tex

REM Check if PDF was generated successfully
if exist "main.pdf" (
    echo Compilation successful! Generated main.pdf
    for %%A in (main.pdf) do echo File size: %%~zA bytes
    
    REM Optional: Open PDF with default viewer
    echo Opening PDF with default viewer...
    start "" main.pdf
    
    echo Compilation complete!
) else (
    echo Compilation failed! Check the log files for errors.
    pause
    exit /b 1
)