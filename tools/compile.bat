@echo off
REM tools/compile_fixed.bat - Enhanced Windows compilation script for fixed SOI class

echo Compiling Constitution of India LaTeX document...
echo Using Source of India LaTeX Class v1.1 (Fixed Version)
echo Features: Two-sided layout, corrected amendments, enhanced typography

REM Clean previous compilation files
echo Cleaning previous compilation files...
del /q *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz >nul 2>&1

REM Check if main document exists
if exist "main.tex" (
    set MAIN_FILE=main.tex
    echo Found main.tex - using as primary document
) else if exist "sample.tex" (
    set MAIN_FILE=sample.tex
    echo Warning: main.tex not found, using sample.tex instead
) else (
    echo Error: Neither main.tex nor sample.tex found!
    echo Please ensure you have a LaTeX document to compile.
    pause
    exit /b 1
)

echo Compiling document: %MAIN_FILE%

REM First compilation pass
echo First pass (generating structure)...
pdflatex -interaction=nonstopmode "%MAIN_FILE%" >nul 2>&1
if errorlevel 1 (
    echo First pass failed! Check compilation errors:
    pdflatex -interaction=nonstopmode "%MAIN_FILE%"
    pause
    exit /b 1
)

REM Second compilation pass for cross-references and TOC
echo Second pass (resolving references)...
pdflatex -interaction=nonstopmode "%MAIN_FILE%" >nul 2>&1
if errorlevel 1 (
    echo Second pass failed! Check compilation errors:
    pdflatex -interaction=nonstopmode "%MAIN_FILE%"
    pause
    exit /b 1
)

REM Third pass to ensure all references are resolved (for complex documents)
echo Third pass (finalizing)...
pdflatex -interaction=nonstopmode "%MAIN_FILE%" >nul 2>&1

REM Determine output PDF name
for %%f in ("%MAIN_FILE%") do set OUTPUT_PDF=%%~nf.pdf

REM Check if PDF was generated successfully
if exist "%OUTPUT_PDF%" (
    echo ✓ Compilation successful! Generated %OUTPUT_PDF%
    
    REM Get file size
    for %%A in ("%OUTPUT_PDF%") do (
        echo Document statistics:
        echo - File size: %%~zA bytes
        echo - Layout: Two-sided with binding offset
        echo - Amendment system: Corrected (text in main, citations in footnotes)
    )
    
    REM Count compilation artifacts
    for /f %%i in ('dir /b *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz 2^>nul ^| find /c /v ""') do (
        if %%i gtr 0 (
            echo - Auxiliary files created: %%i (run tools\cleanup.bat to remove)
        )
    )
    
) else (
    echo ✗ Compilation failed! PDF was not generated.
    echo Check the following common issues:
    echo 1. Missing article files in content\articles\
    echo 2. Missing part files in content\parts\
    echo 3. Incorrect amendment syntax in article files
    echo 4. LaTeX compilation errors in .log file
    pause
    exit /b 1
)

REM Optional: Open PDF if requested
if "%1"=="--open" (
    echo Opening PDF with default viewer...
    start "" "%OUTPUT_PDF%"
)

echo Compilation complete!

REM Show brief usage help
echo.
echo Usage: %0 [--open]
echo   --open    Open the generated PDF with default viewer
echo.
echo Files processed:
echo - Main document: %MAIN_FILE%
echo - Configuration: config.tex
echo - Class file: soi.cls (v1.1 with fixes)
echo - Content files: content\ directory (modular structure)

if not "%1"=="--open" (
    echo.
    echo Press any key to exit...
    pause >nul
)