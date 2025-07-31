@echo off
REM Source of India LaTeX Project Setup Script
REM Windows Batch Version
REM Run from project root directory

setlocal enabledelayedexpansion

echo Source of India LaTeX Project Setup
echo ===================================
echo.

REM Check if running from correct directory
if not exist "soi.cls" (
    echo ERROR: soi.cls not found in current directory
    echo Please run this script from the project root directory
    pause
    exit /b 1
)

echo [1/7] Validating LaTeX installation...

REM Check for LaTeX engines
set LATEX_FOUND=0
set XELATEX_FOUND=0
set LUALATEX_FOUND=0
set PDFLATEX_FOUND=0

where pdflatex >nul 2>&1
if !errorlevel! equ 0 (
    set PDFLATEX_FOUND=1
    set LATEX_FOUND=1
    echo   - pdfLaTeX: Found
) else (
    echo   - pdfLaTeX: Not found
)

where xelatex >nul 2>&1
if !errorlevel! equ 0 (
    set XELATEX_FOUND=1
    set LATEX_FOUND=1
    echo   - XeLaTeX: Found
) else (
    echo   - XeLaTeX: Not found
)

where lualatex >nul 2>&1
if !errorlevel! equ 0 (
    set LUALATEX_FOUND=1
    set LATEX_FOUND=1
    echo   - LuaLaTeX: Found
) else (
    echo   - LuaLaTeX: Not found
)

if !LATEX_FOUND! equ 0 (
    echo ERROR: No LaTeX engine found. Please install TeX Live, MiKTeX, or MacTeX
    pause
    exit /b 1
)

echo.

echo [2/7] Creating directory structure...

REM Create main directories
if not exist "includes" mkdir includes
if not exist "includes\articles" mkdir includes\articles
if not exist "includes\parts" mkdir includes\parts
if not exist "includes\schedules" mkdir includes\schedules
if not exist "includes\helpers" mkdir includes\helpers
if not exist "amendments" mkdir amendments
if not exist "scripts" mkdir scripts
if not exist "tests" mkdir tests
if not exist "tests\unit" mkdir tests\unit
if not exist "tests\integration" mkdir tests\integration
if not exist "tests\visual" mkdir tests\visual
if not exist "docs" mkdir docs
if not exist "examples" mkdir examples
if not exist "examples\basic" mkdir examples\basic
if not exist "examples\advanced" mkdir examples\advanced
if not exist "examples\template" mkdir examples\template
if not exist "output" mkdir output

echo   - Directory structure created

echo.

echo [3/7] Checking required files...

REM Check for essential files and create if missing
if not exist "config.yaml" (
    echo   - Creating config.yaml...
    echo # Source of India LaTeX Configuration > config.yaml
    echo # Build settings >> config.yaml
    echo compiler: xelatex >> config.yaml
    echo font: libertinus >> config.yaml
    echo page_size: a4 >> config.yaml
    echo font_size: 12 >> config.yaml
    echo. >> config.yaml
    echo # Feature flags >> config.yaml
    echo show_amendment_footnotes: true >> config.yaml
    echo validate_article_numbers: true >> config.yaml
    echo auto_cross_reference: true >> config.yaml
    echo. >> config.yaml
    echo # Output options >> config.yaml
    echo pdf_bookmarks: true >> config.yaml
    echo hyperlinks: true >> config.yaml
)

if not exist "main.tex" (
    echo   - Creating main.tex...
    echo %% Source of India LaTeX Document > main.tex
    echo %% Main document file >> main.tex
    echo. >> main.tex
    echo \documentclass[a4paper,12pt]{soi} >> main.tex
    echo. >> main.tex
    echo %% Load configuration >> main.tex
    echo \input{config} >> main.tex
    echo. >> main.tex
    echo \begin{document} >> main.tex
    echo. >> main.tex
    echo %% Front matter >> main.tex
    echo \input{includes/cover} >> main.tex
    echo \input{includes/preamble} >> main.tex
    echo \input{includes/toc} >> main.tex
    echo. >> main.tex
    echo %% Parts and Articles >> main.tex
    echo %% Part I - The Union and its Territory >> main.tex
    echo \input{includes/parts/part-1} >> main.tex
    echo. >> main.tex
    echo %% Add remaining parts here >> main.tex
    echo. >> main.tex
    echo %% Schedules >> main.tex
    echo \input{includes/schedules/schedule-1} >> main.tex
    echo %% Add remaining schedules here >> main.tex
    echo. >> main.tex
    echo \end{document} >> main.tex
)

if not exist "includes\cover.tex" (
    echo %% Cover page > includes\cover.tex
    echo \begin{titlepage} >> includes\cover.tex
    echo \centering >> includes\cover.tex
    echo \vspace*{2cm} >> includes\cover.tex
    echo {\Huge\bfseries The Constitution of India} >> includes\cover.tex
    echo \vfill >> includes\cover.tex
    echo \end{titlepage} >> includes\cover.tex
)

if not exist "includes\preamble.tex" (
    echo %% Constitutional Preamble > includes\preamble.tex
    echo \section*{PREAMBLE} >> includes\preamble.tex
    echo \addcontentsline{toc}{section}{Preamble} >> includes\preamble.tex
    echo. >> includes\preamble.tex
    echo WE, THE PEOPLE OF INDIA, having solemnly resolved to constitute >> includes\preamble.tex
    echo India into a SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC >> includes\preamble.tex
    echo and to secure to all its citizens... >> includes\preamble.tex
)

if not exist "includes\toc.tex" (
    echo %% Table of Contents > includes\toc.tex
    echo \tableofcontents >> includes\toc.tex
    echo \newpage >> includes\toc.tex
)

echo   - Essential files verified/created

echo.

echo [4/8] Creating sample article files...

REM Create sample article files with actual content
if not exist "includes\articles\article-1.tex" (
    echo \Article{1}{Name and territory of the Union}{ > includes\articles\article-1.tex
    echo     India, that is Bharat, shall be a Union of States. >> includes\articles\article-1.tex
    echo } >> includes\articles\article-1.tex
)

if not exist "includes\articles\article-2.tex" (
    echo \Article{2}{Admission or establishment of new States}{ > includes\articles\article-2.tex
    echo     Parliament may by law admit into the Union, or establish, new States >> includes\articles\article-2.tex
    echo     on such terms and conditions as it thinks fit. >> includes\articles\article-2.tex
    echo } >> includes\articles\article-2.tex
)

if not exist "includes\articles\article-21.tex" (
    echo \Article{21}{Protection of life and personal liberty}{ > includes\articles\article-21.tex
    echo     No person shall be deprived of his life or personal liberty >> includes\articles\article-21.tex
    echo     except according to procedure established by law. >> includes\articles\article-21.tex
    echo } >> includes\articles\article-21.tex
)

if not exist "includes\articles\article-21A.tex" (
    echo \Article{21A}{Right to education}{ > includes\articles\article-21A.tex
    echo     The State shall provide free and compulsory education to all children >> includes\articles\article-21A.tex
    echo     of the age of six to fourteen years in such manner as the State may, >> includes\articles\article-21A.tex
    echo     by law, determine. >> includes\articles\article-21A.tex
    echo } >> includes\articles\article-21A.tex
)

if not exist "includes\articles\article-239AA.tex" (
    echo \Article{239AA}{Special provisions with respect to Delhi}{ > includes\articles\article-239AA.tex
    echo     The National Capital Territory of Delhi shall be administered by >> includes\articles\article-239AA.tex
    echo     the Lieutenant Governor appointed by the President under Article 239. >> includes\articles\article-239AA.tex
    echo } >> includes\articles\article-239AA.tex
)

if not exist "includes\articles\article-243ZA.tex" (
    echo \Article{243ZA}{Part IXA to apply to Union territories}{ > includes\articles\article-243ZA.tex
    echo     The provisions of this Part shall apply to the Union territories >> includes\articles\article-243ZA.tex
    echo     and shall, in their application to a Union territory, have effect >> includes\articles\article-243ZA.tex
    echo     as if the references to the Governor of a State were references >> includes\articles\article-243ZA.tex
    echo     to the Administrator of the Union territory. >> includes\articles\article-243ZA.tex
    echo } >> includes\articles\article-243ZA.tex
)

echo   - Sample article files with content created

echo.

echo [5/7] Generating all Constitutional articles...

REM Create all basic articles (1-395)
echo   - Creating basic articles 1-395...
for /L %%i in (1,1,395) do (
    if not exist "includes\articles\article-%%i.tex" (
        echo %% Article %%i - Generated placeholder > includes\articles\article-%%i.tex
        echo \Article{%%i}{[Article Title - To be filled]}{ >> includes\articles\article-%%i.tex
        echo     [Article content - To be filled] >> includes\articles\article-%%i.tex
        echo } >> includes\articles\article-%%i.tex
    )
)

REM Create articles with 'A' suffix (inserted by amendments)
echo   - Creating 'A' suffixed articles...
for %%a in (21A 31A 31B 31C 35A 39A 43A 48A 51A 103A 124A 124B 124C 131A 134A 139A 217A 224A 230A 239A 239AA 239AB 239B 244A 246A 269A 279A 290A 300A 312A 323A 323B 329A 338A 338B 342A 350A 350B 371A 371B 371C 371D 371E 371F 371G 371H 371I 371J 378A 394A) do (
    if not exist "includes\articles\article-%%a.tex" (
        echo %% Article %%a - Generated placeholder > includes\articles\article-%%a.tex
        echo \Article{%%a}{[Article Title - To be filled]}{ >> includes\articles\article-%%a.tex
        echo     [Article content - To be filled] >> includes\articles\article-%%a.tex
        echo } >> includes\articles\article-%%a.tex
    )
)

REM Create Panchayat articles (243A to 243O)
echo   - Creating Panchayat articles 243A-243O...
for %%p in (243A 243B 243C 243D 243E 243F 243G 243H 243I 243J 243K 243L 243M 243N 243O) do (
    if not exist "includes\articles\article-%%p.tex" (
        echo %% Article %%p - Generated placeholder > includes\articles\article-%%p.tex
        echo \Article{%%p}{[Article Title - To be filled]}{ >> includes\articles\article-%%p.tex
        echo     [Article content - To be filled] >> includes\articles\article-%%p.tex
        echo } >> includes\articles\article-%%p.tex
    )
)

REM Create Municipality articles (243P to 243ZG)  
echo   - Creating Municipality articles 243P-243ZG...
for %%m in (243P 243Q 243R 243S 243T 243U 243V 243W 243X 243Y 243Z 243ZA 243ZB 243ZC 243ZD 243ZE 243ZF 243ZG) do (
    if not exist "includes\articles\article-%%m.tex" (
        echo %% Article %%m - Generated placeholder > includes\articles\article-%%m.tex
        echo \Article{%%m}{[Article Title - To be filled]}{ >> includes\articles\article-%%m.tex
        echo     [Article content - To be filled] >> includes\articles\article-%%m.tex
        echo } >> includes\articles\article-%%m.tex
    )
)

REM Create Co-operative Society articles (243ZH to 243ZT)
echo   - Creating Co-operative Society articles 243ZH-243ZT...
for %%c in (243ZH 243ZI 243ZJ 243ZK 243ZL 243ZM 243ZN 243ZO 243ZP 243ZQ 243ZR 243ZS 243ZT) do (
    if not exist "includes\articles\article-%%c.tex" (
        echo %% Article %%c - Generated placeholder > includes\articles\article-%%c.tex
        echo \Article{%%c}{[Article Title - To be filled]}{ >> includes\articles\article-%%c.tex
        echo     [Article content - To be filled] >> includes\articles\article-%%c.tex
        echo } >> includes\articles\article-%%c.tex
    )
)

echo   - Created placeholder files for all Constitutional articles

echo [6/7] Creating sample part files...

if not exist "includes\parts\part-1.tex" (
    echo \Part{I}{THE UNION AND ITS TERRITORY} > includes\parts\part-1.tex
    echo. >> includes\parts\part-1.tex
    echo \input{includes/articles/article-1} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-2} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-3} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-4} >> includes\parts\part-1.tex
)

if not exist "includes\parts\part-3.tex" (
    echo \Part{III}{FUNDAMENTAL RIGHTS} > includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex
    echo \Chapter{}{} >> includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex
    echo \input{includes/articles/article-12} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-13} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-14} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-15} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-16} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-17} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-18} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-19} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-20} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-21} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-21A} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-22} >> includes\parts\part-3.tex
)

if not exist "includes\parts\part-9.tex" (
    echo \Part{IX}{THE PANCHAYATS} > includes\parts\part-9.tex
    echo. >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243A} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243B} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243C} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243D} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243E} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243F} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243G} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243H} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243I} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243J} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243K} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243L} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243M} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243N} >> includes\parts\part-9.tex
    echo \input{includes/articles/article-243O} >> includes\parts\part-9.tex
)

if not exist "includes\parts\part-9A.tex" (
    echo \Part{IXA}{THE MUNICIPALITIES} > includes\parts\part-9A.tex
    echo. >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243P} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243Q} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243R} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243S} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243T} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243U} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243V} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243W} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243X} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243Y} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243Z} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZA} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZB} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZC} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZD} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZE} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZF} >> includes\parts\part-9A.tex
    echo \input{includes/articles/article-243ZG} >> includes\parts\part-9A.tex
)

echo   - Sample part files created

echo.

echo [7/8] Creating test compilation...

REM Determine best LaTeX engine
if !XELATEX_FOUND! equ 1 (
    set COMPILE_ENGINE=xelatex
    echo   - Using XeLaTeX for compilation
) else if !LUALATEX_FOUND! equ 1 (
    set COMPILE_ENGINE=lualatex
    echo   - Using LuaLaTeX for compilation
) else (
    set COMPILE_ENGINE=pdflatex
    echo   - Using pdfLaTeX for compilation
)

REM Create simple test document
echo \documentclass{soi} > test-compile.tex
echo \begin{document} >> test-compile.tex
echo \Article{1}{Test Article}{This is a test compilation to verify the soi class works correctly.} >> test-compile.tex
echo \end{document} >> test-compile.tex

echo   - Compiling test document...
!COMPILE_ENGINE! -interaction=batchmode test-compile.tex >nul 2>&1

if exist "test-compile.pdf" (
    echo   - Test compilation successful
    if exist "output" move test-compile.pdf output\ >nul 2>&1
) else (
    echo   - WARNING: Test compilation failed
    echo   - Check that all required LaTeX packages are installed
)

REM Clean up auxiliary files
if exist "test-compile.aux" del test-compile.aux
if exist "test-compile.log" del test-compile.log
if exist "test-compile.out" del test-compile.out
if exist "test-compile.toc" del test-compile.toc
if exist "test-compile.tex" del test-compile.tex

echo.

echo [8/8] Creating example documents...

if not exist "examples\basic\simple-article.tex" (
    echo \documentclass{soi} > examples\basic\simple-article.tex
    echo \begin{document} >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \Article{21}{Protection of life and personal liberty}{ >> examples\basic\simple-article.tex
    echo     No person shall be deprived of his life or personal liberty >> examples\basic\simple-article.tex
    echo     except according to procedure established by law. >> examples\basic\simple-article.tex
    echo } >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \end{document} >> examples\basic\simple-article.tex
)

if not exist "examples\basic\with-clauses.tex" (
    echo \documentclass{soi} > examples\basic\with-clauses.tex
    echo \begin{document} >> examples\basic\with-clauses.tex
    echo. >> examples\basic\with-clauses.tex
    echo \Article{19}{Protection of certain rights regarding freedom of speech, etc.}{ >> examples\basic\with-clauses.tex
    echo     All citizens shall have the right to: >> examples\basic\with-clauses.tex
    echo. >> examples\basic\with-clauses.tex
    echo     \Clause{freedom of speech and expression;} >> examples\basic\with-clauses.tex
    echo. >> examples\basic\with-clauses.tex
    echo     \Clause{to assemble peaceably and without arms;} >> examples\basic\with-clauses.tex
    echo. >> examples\basic\with-clauses.tex
    echo     \Clause{to form associations or unions or cooperative societies;} >> examples\basic\with-clauses.tex
    echo } >> examples\basic\with-clauses.tex
    echo. >> examples\basic\with-clauses.tex
    echo \end{document} >> examples\basic\with-clauses.tex
)

echo   - Example documents created

echo.
echo Setup completed successfully!
echo.
echo SUMMARY:
echo - Created directory structure for SoI LaTeX project
echo - Generated placeholder files for ALL 467+ Constitutional articles
echo - Includes basic articles 1-395 and all amendment articles
echo - Complex amendments: 21A, 31A-C, 35A, 239AA, 239AB, 243ZA-ZT, etc.
echo - Created sample part files including Panchayats and Municipalities  
echo - Generated example documents and test compilation
echo.
echo ARTICLE BREAKDOWN:
echo - Basic articles: 1-395 (395 files)
echo - Single letter amendments: A, B, C suffixes (40+ files) 
echo - Panchayat articles: 243A-243O (15 files)
echo - Municipality articles: 243P-243ZG (18 files)
echo - Co-operative articles: 243ZH-243ZT (13 files)
echo - Special articles: 239AA, 239AB, etc.
echo - Total: 467+ article placeholder files created
echo.
echo Next steps:
echo 1. Edit specific article files in includes\articles\ with actual content
echo 2. Update part files in includes\parts\ to include relevant articles
echo 3. Modify main.tex to include desired parts and schedules
echo 4. Compile with: !COMPILE_ENGINE! main.tex
echo.
echo For more information, see the documentation in docs\
echo.

pause