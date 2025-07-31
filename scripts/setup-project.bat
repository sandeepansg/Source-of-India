@echo off
setlocal enabledelayedexpansion

REM Source of India LaTeX Project Setup Script
REM Improved version with text-based UI and comprehensive article creation
REM Version 2.0 - 2025

title Source of India LaTeX Project Setup

:main_menu
cls
echo.
echo ================================================================================
echo                    SOURCE OF INDIA LATEX PROJECT SETUP
echo ================================================================================
echo.
echo Version 2.0 - Comprehensive Constitutional Document LaTeX Class Setup
echo.
echo Main Menu:
echo.
echo [1] Full Setup         - Complete project setup (recommended for new projects)
echo [2] Partial Setup      - Choose specific components to set up
echo [3] Validation         - Check existing setup and validate files
echo [4] Repair/Update      - Fix missing files or update existing setup
echo [5] Clean Project      - Remove generated files (keep source)
echo [6] Help               - Show detailed information about this script
echo [7] Exit               - Quit the setup script
echo.
echo ================================================================================
echo.

set /p choice="Please select an option (1-7): "

if "%choice%"=="1" goto full_setup
if "%choice%"=="2" goto partial_setup
if "%choice%"=="3" goto validation
if "%choice%"=="4" goto repair_update
if "%choice%"=="5" goto clean_project
if "%choice%"=="6" goto show_help
if "%choice%"=="7" goto exit_script

echo.
echo Invalid choice. Please select a number between 1 and 7.
pause
goto main_menu

:full_setup
cls
echo.
echo ================================================================================
echo                           FULL PROJECT SETUP
echo ================================================================================
echo.
echo This will create a complete Source of India LaTeX project with:
echo - All 470+ Constitutional articles (including amendments)
echo - Complete directory structure
echo - Sample documents and examples
echo - Build scripts and configuration
echo.
echo WARNING: This may overwrite existing files!
echo.
set /p confirm="Continue with full setup? (Y/N): "
if /i not "%confirm%"=="Y" goto main_menu

echo.
echo Starting full project setup...
echo.

call :check_prerequisites
if errorlevel 1 goto main_menu

call :create_directories
call :create_config_files
call :generate_all_articles
call :create_parts_files
call :create_schedules
call :create_examples
call :create_build_scripts
call :test_compilation

echo.
echo ================================================================================
echo                        FULL SETUP COMPLETED SUCCESSFULLY!
echo ================================================================================
echo.
call :show_summary
echo.
echo Press any key to return to main menu...
pause >nul
goto main_menu

:partial_setup
cls
echo.
echo ================================================================================
echo                          PARTIAL SETUP OPTIONS
echo ================================================================================
echo.
echo Select components to set up:
echo.
echo [1] Directory Structure    - Create project folders
echo [2] Configuration Files    - Create config.yaml, main.tex, etc.
echo [3] Article Files          - Generate all constitutional articles
echo [4] Part Files             - Create part organization files
echo [5] Schedule Files         - Create schedule templates
echo [6] Example Documents      - Create sample LaTeX documents
echo [7] Build Scripts          - Create compilation and build scripts
echo [8] Back to Main Menu
echo.

set /p partial_choice="Select component (1-8): "

if "%partial_choice%"=="1" call :create_directories
if "%partial_choice%"=="2" call :create_config_files
if "%partial_choice%"=="3" call :generate_all_articles
if "%partial_choice%"=="4" call :create_parts_files
if "%partial_choice%"=="5" call :create_schedules
if "%partial_choice%"=="6" call :create_examples
if "%partial_choice%"=="7" call :create_build_scripts
if "%partial_choice%"=="8" goto main_menu

if "%partial_choice%" geq "1" if "%partial_choice%" leq "7" (
    echo.
    echo Component setup completed!
    echo.
    echo Press any key to return to partial setup menu...
    pause >nul
    goto partial_setup
)

echo Invalid choice. Please try again.
pause
goto partial_setup

:validation
cls
echo.
echo ================================================================================
echo                           PROJECT VALIDATION
echo ================================================================================
echo.

call :check_prerequisites
call :validate_structure
call :validate_articles
call :validate_examples

echo.
echo Validation completed!
echo.
echo Press any key to return to main menu...
pause >nul
goto main_menu

:repair_update
cls
echo.
echo ================================================================================
echo                           REPAIR/UPDATE PROJECT
echo ================================================================================
echo.
echo This will check for missing files and create them if needed.
echo Existing files will NOT be overwritten.
echo.

call :repair_missing_files

echo.
echo Repair/Update completed!
echo.
echo Press any key to return to main menu...
pause >nul
goto main_menu

:clean_project
cls
echo.
echo ================================================================================
echo                           CLEAN PROJECT FILES
echo ================================================================================
echo.
echo This will remove generated files but keep source files:
echo - PDF outputs
echo - LaTeX auxiliary files (.aux, .log, .toc, etc.)
echo - Temporary compilation files
echo.
echo Source files (.tex, .cls, config files) will be preserved.
echo.
set /p clean_confirm="Continue with cleanup? (Y/N): "
if /i not "%clean_confirm%"=="Y" goto main_menu

call :clean_generated_files

echo.
echo Cleanup completed!
echo.
echo Press any key to return to main menu...
pause >nul
goto main_menu

:show_help
cls
echo.
echo ================================================================================
echo                               HELP INFORMATION
echo ================================================================================
echo.
echo Source of India LaTeX Project Setup Script v2.0
echo.
echo PURPOSE:
echo This script sets up a complete LaTeX project for typesetting the Constitution
echo of India using the specialized 'soi' LaTeX document class.
echo.
echo FEATURES:
echo - Creates all 470+ Constitutional articles (including amendments)
echo - Sets up proper project structure with modular files
echo - Generates sample documents and examples
echo - Creates build scripts for compilation
echo - Validates and repairs existing setups
echo.
echo REQUIREMENTS:
echo - LaTeX distribution (TeX Live 2020+ recommended)
echo - soi.cls file in project directory
echo - Windows command line environment
echo.
echo ARTICLE COVERAGE:
echo - Basic articles: 1-395
echo - Amendment articles: 21A, 31A-C, 35A, etc.
echo - Panchayat articles: 243A-243O
echo - Municipality articles: 243P-243ZG  
echo - Co-operative articles: 243ZH-243ZT
echo - Special provisions: 239AA, 239AB, 371A-J, etc.
echo.
echo COMPILATION:
echo After setup, compile your document with:
echo   xelatex main.tex    (recommended)
echo   pdflatex main.tex   (alternative)
echo   lualatex main.tex   (alternative)
echo.
echo Press any key to return to main menu...
pause >nul
goto main_menu

:exit_script
cls
echo.
echo ================================================================================
echo                              EXITING SETUP
echo ================================================================================
echo.
echo Thank you for using Source of India LaTeX Project Setup!
echo.
echo For documentation and support, see:
echo - docs/user-guide.md
echo - examples/ directory
echo - Project repository
echo.
echo Have a great day!
echo.
pause
exit /b 0

REM ================================================================================
REM                              FUNCTION DEFINITIONS
REM ================================================================================

:check_prerequisites
echo [STEP] Checking prerequisites...

REM Check if running from correct directory
if not exist "soi.cls" (
    echo.
    echo ERROR: soi.cls not found in current directory
    echo Please run this script from the project root directory where soi.cls is located.
    echo.
    pause
    exit /b 1
)
echo   ✓ soi.cls found

REM Check for LaTeX engines
set LATEX_FOUND=0
set XELATEX_FOUND=0
set LUALATEX_FOUND=0
set PDFLATEX_FOUND=0

where pdflatex >nul 2>&1
if !errorlevel! equ 0 (
    set PDFLATEX_FOUND=1
    set LATEX_FOUND=1
    echo   ✓ pdfLaTeX found
) else (
    echo   ✗ pdfLaTeX not found
)

where xelatex >nul 2>&1
if !errorlevel! equ 0 (
    set XELATEX_FOUND=1
    set LATEX_FOUND=1
    echo   ✓ XeLaTeX found
) else (
    echo   ✗ XeLaTeX not found
)

where lualatex >nul 2>&1
if !errorlevel! equ 0 (
    set LUALATEX_FOUND=1
    set LATEX_FOUND=1
    echo   ✓ LuaLaTeX found
) else (
    echo   ✗ LuaLaTeX not found
)

if !LATEX_FOUND! equ 0 (
    echo.
    echo ERROR: No LaTeX engine found!
    echo Please install TeX Live, MiKTeX, or MacTeX before continuing.
    echo.
    pause
    exit /b 1
)

REM Determine best LaTeX engine
if !XELATEX_FOUND! equ 1 (
    set COMPILE_ENGINE=xelatex
    echo   → Preferred engine: XeLaTeX
) else if !LUALATEX_FOUND! equ 1 (
    set COMPILE_ENGINE=lualatex
    echo   → Preferred engine: LuaLaTeX
) else (
    set COMPILE_ENGINE=pdflatex
    echo   → Preferred engine: pdfLaTeX
)

echo   ✓ Prerequisites verified
exit /b 0

:create_directories
echo [STEP] Creating directory structure...

REM Main directories
if not exist "includes" mkdir includes
if not exist "includes\articles" mkdir includes\articles
if not exist "includes\parts" mkdir includes\parts
if not exist "includes\schedules" mkdir includes\schedules
if not exist "includes\helpers" mkdir includes\helpers
if not exist "includes\front-matter" mkdir includes\front-matter
if not exist "includes\back-matter" mkdir includes\back-matter

REM Amendment and reference directories
if not exist "amendments" mkdir amendments
if not exist "amendments\data" mkdir amendments\data
if not exist "amendments\footnotes" mkdir amendments\footnotes

REM Build and script directories  
if not exist "scripts" mkdir scripts
if not exist "scripts\build" mkdir scripts\build
if not exist "scripts\utils" mkdir scripts\utils

REM Test directories
if not exist "tests" mkdir tests
if not exist "tests\unit" mkdir tests\unit
if not exist "tests\integration" mkdir tests\integration
if not exist "tests\visual" mkdir tests\visual

REM Documentation and examples
if not exist "docs" mkdir docs
if not exist "examples" mkdir examples  
if not exist "examples\basic" mkdir examples\basic
if not exist "examples\advanced" mkdir examples\advanced
if not exist "examples\complete" mkdir examples\complete
if not exist "examples\templates" mkdir examples\templates

REM Output directories
if not exist "output" mkdir output
if not exist "output\pdf" mkdir output\pdf
if not exist "output\logs" mkdir output\logs
if not exist "temp" mkdir temp

echo   ✓ Directory structure created
exit /b 0

:create_config_files
echo [STEP] Creating configuration files...

REM Main LaTeX document
if not exist "main.tex" (
    echo %% Source of India LaTeX Document > main.tex
    echo %% Main document file - Constitution of India >> main.tex
    echo %% Generated by SoI LaTeX Project Setup Script >> main.tex
    echo. >> main.tex
    echo \documentclass[a4paper,12pt,showamendments]{soi} >> main.tex
    echo. >> main.tex
    echo %% Document configuration >> main.tex
    echo \usepackage{xcolor} >> main.tex
    echo \usepackage{hyperref} >> main.tex
    echo \hypersetup{ >> main.tex
    echo     colorlinks=true, >> main.tex
    echo     linkcolor=blue, >> main.tex
    echo     urlcolor=blue, >> main.tex
    echo     citecolor=red, >> main.tex
    echo     pdfauthor={Government of India}, >> main.tex
    echo     pdftitle={The Constitution of India}, >> main.tex
    echo     pdfsubject={Constitutional Law}, >> main.tex
    echo     pdfkeywords={Constitution, India, Law, Government} >> main.tex
    echo } >> main.tex
    echo. >> main.tex
    echo \begin{document} >> main.tex
    echo. >> main.tex
    echo %% Front matter >> main.tex
    echo \input{includes/front-matter/cover} >> main.tex
    echo \input{includes/front-matter/preamble} >> main.tex
    echo \input{includes/front-matter/toc} >> main.tex
    echo. >> main.tex
    echo %% Main content - Parts of the Constitution >> main.tex
    echo %% Uncomment the parts you want to include >> main.tex
    echo \input{includes/parts/part-1}  %% The Union and its Territory >> main.tex
    echo %% \input{includes/parts/part-2}  %% Citizenship >> main.tex
    echo %% \input{includes/parts/part-3}  %% Fundamental Rights >> main.tex
    echo %% \input{includes/parts/part-4}  %% Directive Principles >> main.tex
    echo %% Add more parts as needed >> main.tex
    echo. >> main.tex
    echo %% Schedules >> main.tex
    echo %% \input{includes/schedules/schedule-1} >> main.tex
    echo %% Add more schedules as needed >> main.tex
    echo. >> main.tex
    echo %% Back matter >> main.tex
    echo \input{includes/back-matter/appendices} >> main.tex
    echo. >> main.tex
    echo \end{document} >> main.tex
    echo   ✓ main.tex created
)

REM Configuration file
if not exist "config.yaml" (
    echo # Source of India LaTeX Configuration > config.yaml
    echo # Project configuration file >> config.yaml
    echo. >> config.yaml
    echo # Build settings >> config.yaml
    echo compiler: xelatex >> config.yaml
    echo font: libertinus >> config.yaml
    echo page_size: a4 >> config.yaml
    echo font_size: 12 >> config.yaml
    echo line_spacing: 1.15 >> config.yaml
    echo. >> config.yaml
    echo # Typography settings >> config.yaml
    echo margin_top: 2.5 >> config.yaml
    echo margin_bottom: 2.0 >> config.yaml
    echo margin_left: 2.5 >> config.yaml
    echo margin_right: 2.0 >> config.yaml
    echo. >> config.yaml
    echo # Feature flags >> config.yaml
    echo show_amendment_footnotes: true >> config.yaml
    echo show_inline_amendments: false >> config.yaml
    echo validate_article_numbers: true >> config.yaml
    echo auto_cross_reference: true >> config.yaml
    echo generate_bookmarks: true >> config.yaml
    echo. >> config.yaml
    echo # Amendment settings >> config.yaml
    echo amendment_style: footnote >> config.yaml
    echo amendment_numbering: true >> config.yaml
    echo show_repeal_info: true >> config.yaml
    echo. >> config.yaml
    echo # Output options >> config.yaml
    echo pdf_bookmarks: true >> config.yaml
    echo hyperlinks: true >> config.yaml
    echo draft_mode: false >> config.yaml
    echo include_metadata: true >> config.yaml
    echo. >> config.yaml
    echo # Build options >> config.yaml
    echo clean_build: false >> config.yaml
    echo verbose_output: false >> config.yaml
    echo parallel_build: false >> config.yaml
    echo output_dir: output/pdf >> config.yaml
    echo temp_dir: temp >> config.yaml
    echo   ✓ config.yaml created
)

REM Front matter files
if not exist "includes\front-matter\cover.tex" (
    echo %% Cover page for Constitution of India > includes\front-matter\cover.tex
    echo \begin{titlepage} >> includes\front-matter\cover.tex
    echo \centering >> includes\front-matter\cover.tex
    echo \vspace*{3cm} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo {\Huge\bfseries THE CONSTITUTION} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo \vspace{0.5cm} >> includes\front-matter\cover.tex
    echo {\Huge\bfseries OF} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo \vspace{0.5cm} >> includes\front-matter\cover.tex
    echo {\Huge\bfseries INDIA} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo \vspace{2cm} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo {\large As Adopted by the Constituent Assembly} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo \vspace{0.5cm} >> includes\front-matter\cover.tex
    echo {\large 26th November 1949} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo \vfill >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo {\large GOVERNMENT OF INDIA} >> includes\front-matter\cover.tex
    echo. >> includes\front-matter\cover.tex
    echo \end{titlepage} >> includes\front-matter\cover.tex
    echo \newpage >> includes\front-matter\cover.tex
)

if not exist "includes\front-matter\preamble.tex" (
    echo %% Constitutional Preamble > includes\front-matter\preamble.tex
    echo \section*{PREAMBLE} >> includes\front-matter\preamble.tex
    echo \addcontentsline{toc}{section}{Preamble} >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo \begin{center} >> includes\front-matter\preamble.tex
    echo \large >> includes\front-matter\preamble.tex
    echo WE, THE PEOPLE OF INDIA, having solemnly resolved to constitute >> includes\front-matter\preamble.tex
    echo India into a SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC >> includes\front-matter\preamble.tex
    echo and to secure to all its citizens: >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo JUSTICE, social, economic and political; >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo LIBERTY of thought, expression, belief, faith and worship; >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo EQUALITY of status and of opportunity; and to promote among them all >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo FRATERNITY assuring the dignity of the individual and the unity >> includes\front-matter\preamble.tex
    echo and integrity of the Nation; >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo IN OUR CONSTITUENT ASSEMBLY this twenty-sixth day of November, 1949, >> includes\front-matter\preamble.tex
    echo do HEREBY ADOPT, ENACT AND GIVE TO OURSELVES THIS CONSTITUTION. >> includes\front-matter\preamble.tex
    echo \end{center} >> includes\front-matter\preamble.tex
    echo. >> includes\front-matter\preamble.tex
    echo \newpage >> includes\front-matter\preamble.tex
)

if not exist "includes\front-matter\toc.tex" (
    echo %% Table of Contents > includes\front-matter\toc.tex
    echo \tableofcontents >> includes\front-matter\toc.tex
    echo \newpage >> includes\front-matter\toc.tex
)

if not exist "includes\back-matter\appendices.tex" (
    echo %% Back matter and appendices > includes\back-matter\appendices.tex
    echo. >> includes\back-matter\appendices.tex
    echo %% Additional appendices can be added here >> includes\back-matter\appendices.tex
    echo %% Index, glossary, etc. >> includes\back-matter\appendices.tex
)

echo   ✓ Configuration files created
exit /b 0

:generate_all_articles
echo [STEP] Generating all Constitutional articles...

echo   → Creating basic articles (1-395)...
REM Create basic articles 1-395
for /L %%i in (1,1,395) do (
    if not exist "includes\articles\article-%%i.tex" (
        echo %% Article %%i - Constitution of India > includes\articles\article-%%i.tex
        echo %% Generated placeholder - Replace with actual content >> includes\articles\article-%%i.tex
        echo. >> includes\articles\article-%%i.tex
        echo \Article{%%i}{[Article Title - To be filled]}{ >> includes\articles\article-%%i.tex
        echo     [Article content for Article %%i - To be filled with actual constitutional text] >> includes\articles\article-%%i.tex
        echo } >> includes\articles\article-%%i.tex
    )
)

echo   → Creating amendment articles with A suffix...
REM Articles with A suffix (inserted by amendments)
for %%a in (21A 31A 31B 31C 35A 39A 43A 48A 51A 103A 124A 124B 124C 131A 134A 139A 217A 224A 230A 239A 239AA 239AB 239B 244A 246A 269A 279A 290A 300A 312A 323A 323B 329A 338A 338B 342A 350A 350B 371A 371B 371C 371D 371E 371F 371G 371H 371I 371J 378A 394A) do (
    if not exist "includes\articles\article-%%a.tex" (
        echo %% Article %%a - Constitution of India ^(Amendment^) > includes\articles\article-%%a.tex
        echo %% Amendment article - Replace with actual content >> includes\articles\article-%%a.tex
        echo. >> includes\articles\article-%%a.tex
        echo \Article{%%a}{[Article Title - To be filled]}{ >> includes\articles\article-%%a.tex
        echo     [Article content for Article %%a - To be filled with actual constitutional text] >> includes\articles\article-%%a.tex
        echo } >> includes\articles\article-%%a.tex
    )
)

echo   → Creating Panchayat articles (243A-243O)...
REM Panchayat articles (Part IX)
for %%p in (243A 243B 243C 243D 243E 243F 243G 243H 243I 243J 243K 243L 243M 243N 243O) do (
    if not exist "includes\articles\article-%%p.tex" (
        echo %% Article %%p - Panchayats ^(Part IX^) > includes\articles\article-%%p.tex
        echo %% Panchayat provision - Replace with actual content >> includes\articles\article-%%p.tex
        echo. >> includes\articles\article-%%p.tex
        echo \Article{%%p}{[Panchayat Article Title - To be filled]}{ >> includes\articles\article-%%p.tex
        echo     [Article content for Article %%p - To be filled with actual panchayat provisions] >> includes\articles\article-%%p.tex
        echo } >> includes\articles\article-%%p.tex
    )
)

echo   → Creating Municipality articles (243P-243ZG)...
REM Municipality articles (Part IXA)
for %%m in (243P 243Q 243R 243S 243T 243U 243V 243W 243X 243Y 243Z 243ZA 243ZB 243ZC 243ZD 243ZE 243ZF 243ZG) do (
    if not exist "includes\articles\article-%%m.tex" (
        echo %% Article %%m - Municipalities ^(Part IXA^) > includes\articles\article-%%m.tex
        echo %% Municipality provision - Replace with actual content >> includes\articles\article-%%m.tex
        echo. >> includes\articles\article-%%m.tex
        echo \Article{%%m}{[Municipality Article Title - To be filled]}{ >> includes\articles\article-%%m.tex
        echo     [Article content for Article %%m - To be filled with actual municipality provisions] >> includes\articles\article-%%m.tex
        echo } >> includes\articles\article-%%m.tex
    )
)

echo   → Creating Co-operative Society articles (243ZH-243ZT)...
REM Co-operative Society articles (Part IXB)
for %%c in (243ZH 243ZI 243ZJ 243ZK 243ZL 243ZM 243ZN 243ZO 243ZP 243ZQ 243ZR 243ZS 243ZT) do (
    if not exist "includes\articles\article-%%c.tex" (
        echo %% Article %%c - Co-operative Societies ^(Part IXB^) > includes\articles\article-%%c.tex
        echo %% Co-operative provision - Replace with actual content >> includes\articles\article-%%c.tex
        echo. >> includes\articles\article-%%c.tex
        echo \Article{%%c}{[Co-operative Article Title - To be filled]}{ >> includes\articles\article-%%c.tex
        echo     [Article content for Article %%c - To be filled with actual co-operative provisions] >> includes\articles\article-%%c.tex
        echo } >> includes\articles\article-%%c.tex
    )
)

echo   → Creating sample articles with actual content...
REM Create some sample articles with real content
if not exist "includes\articles\article-1.tex" (
    echo %% Article 1 - Name and territory of the Union > includes\articles\article-1.tex
    echo. >> includes\articles\article-1.tex
    echo \Article{1}{Name and territory of the Union}{ >> includes\articles\article-1.tex
    echo     \Clause{India, that is Bharat, shall be a Union of States.} >> includes\articles\article-1.tex
    echo. >> includes\articles\article-1.tex
    echo     \Clause{The States and the territories thereof shall be as specified in the First Schedule.} >> includes\articles\article-1.tex
    echo. >> includes\articles\article-1.tex  
    echo     \Clause{The territory of India shall comprise— >> includes\articles\article-1.tex
    echo         \SubClause{the territories of the States;} >> includes\articles\article-1.tex
    echo         \SubClause{the Union territories specified in the First Schedule; and} >> includes\articles\article-1.tex
    echo         \SubClause{such other territories as may be acquired.} >> includes\articles\article-1.tex
    echo     } >> includes\articles\article-1.tex
    echo } >> includes\articles\article-1.tex
) else (
    REM Update existing file with better content
    echo %% Article 1 - Name and territory of the Union > includes\articles\article-1.tex
    echo. >> includes\articles\article-1.tex
    echo \Article{1}{Name and territory of the Union}{ >> includes\articles\article-1.tex
    echo     \Clause{India, that is Bharat, shall be a Union of States.} >> includes\articles\article-1.tex
    echo. >> includes\articles\article-1.tex
    echo     \Clause{The States and the territories thereof shall be as specified in the First Schedule.} >> includes\articles\article-1.tex
    echo. >> includes\articles\article-1.tex  
    echo     \Clause{The territory of India shall comprise— >> includes\articles\article-1.tex
    echo         \SubClause{the territories of the States;} >> includes\articles\article-1.tex
    echo         \SubClause{the Union territories specified in the First Schedule; and} >> includes\articles\article-1.tex
    echo         \SubClause{such other territories as may be acquired.} >> includes\articles\article-1.tex
    echo     } >> includes\articles\article-1.tex
    echo } >> includes\articles\article-1.tex
)

REM Article 21 - Right to Life
echo %% Article 21 - Protection of life and personal liberty > includes\articles\article-21.tex
echo. >> includes\articles\article-21.tex
echo \Article{21}{Protection of life and personal liberty}{ >> includes\articles\article-21.tex
echo     No person shall be deprived of his life or personal liberty >> includes\articles\article-21.tex
echo     except according to procedure established by law. >> includes\articles\article-21.tex
echo } >> includes\articles\article-21.tex

REM Article 21A - Right to Education  
echo %% Article 21A - Right to education > includes\articles\article-21A.tex
echo. >> includes\articles\article-21A.tex
echo \Article{21A}{Right to education}{ >> includes\articles\article-21A.tex
echo     The State shall provide free and compulsory education to all children >> includes\articles\article-21A.tex
echo     of the age of six to fourteen years in such manner as the State may, >> includes\articles\article-21A.tex
echo     by law, determine. >> includes\articles\article-21A.tex
echo } >> includes\articles\article-21A.tex

REM Article 356 - President's Rule
echo %% Article 356 - Provisions in case of failure of constitutional machinery in States > includes\articles\article-356.tex
echo. >> includes\articles\article-356.tex
echo \Article{356}{Provisions in case of failure of constitutional machinery in States}{ >> includes\articles\article-356.tex
echo     If the President, on receipt of a report from the Governor of a State or otherwise, >> includes\articles\article-356.tex
echo     is satisfied that a situation has arisen in which the government of the >> includes\articles\article-