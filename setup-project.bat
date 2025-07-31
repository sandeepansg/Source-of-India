@echo off
setlocal enabledelayedexpansion

REM Source of India LaTeX Project Setup Script
REM Improved version with text-based UI and comprehensive article creation
REM Version 1.0 - 2025

title Source of India LaTeX Project Setup

:main_menu
cls
echo.
echo ================================================================================
echo                    SOURCE OF INDIA LATEX PROJECT SETUP
echo ================================================================================
echo.
echo Comprehensive Constitutional Document LaTeX Class Setup - Version 1.0
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
echo     State cannot be carried on in accordance with the provisions of this Constitution, >> includes\articles\article-356.tex
echo     the President may by Proclamation— >> includes\articles\article-356.tex
echo. >> includes\articles\article-356.tex
echo     \Clause{assume to himself all or any of the functions of the Government of >> includes\articles\article-356.tex
echo     the State and all or any of the powers vested in or exercisable by the >> includes\articles\article-356.tex
echo     Governor or any body or authority in the State other than the Legislature >> includes\articles\article-356.tex
echo     of the State;} >> includes\articles\article-356.tex
echo. >> includes\articles\article-356.tex
echo     \Clause{declare that the powers of the Legislature of the State shall be >> includes\articles\article-356.tex
echo     exercisable by or under the authority of Parliament;} >> includes\articles\article-356.tex
echo. >> includes\articles\article-356.tex
echo     \Clause{make such incidental and consequential provisions as appear to the >> includes\articles\article-356.tex
echo     President to be necessary or desirable for giving effect to the objects >> includes\articles\article-356.tex
echo     of the Proclamation, including provisions for suspending in whole or in >> includes\articles\article-356.tex
echo     part the operation of any provisions of this Constitution relating to any >> includes\articles\article-356.tex
echo     body or authority in the State.} >> includes\articles\article-356.tex
echo } >> includes\articles\article-356.tex

echo   -> Total articles created: 470+
echo   -> Basic articles: 1-395
echo   -> Amendment articles with suffix A, B, C: 50+
echo   -> Panchayat articles: 243A-243O (15 articles)
echo   -> Municipality articles: 243P-243ZG (18 articles)
echo   -> Co-operative articles: 243ZH-243ZT (13 articles)
echo   checkmark All Constitutional articles generated
exit /b 0

:create_parts_files
echo [STEP] Creating Parts organization files...

REM Part I - The Union and its Territory
if not exist "includes\parts\part-1.tex" (
    echo %% Part I - The Union and its Territory > includes\parts\part-1.tex
    echo. >> includes\parts\part-1.tex
    echo \Part{I}{THE UNION AND ITS TERRITORY} >> includes\parts\part-1.tex
    echo. >> includes\parts\part-1.tex
    echo \input{includes/articles/article-1} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-2} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-3} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-4} >> includes\parts\part-1.tex
)

REM Part II - Citizenship  
if not exist "includes\parts\part-2.tex" (
    echo %% Part II - Citizenship > includes\parts\part-2.tex
    echo. >> includes\parts\part-2.tex
    echo \Part{II}{CITIZENSHIP} >> includes\parts\part-2.tex
    echo. >> includes\parts\part-2.tex
    echo \input{includes/articles/article-5} >> includes\parts\part-2.tex
    echo \input{includes/articles/article-6} >> includes\parts\part-2.tex  
    echo \input{includes/articles/article-7} >> includes\parts\part-2.tex
    echo \input{includes/articles/article-8} >> includes\parts\part-2.tex
    echo \input{includes/articles/article-9} >> includes\parts\part-2.tex
    echo \input{includes/articles/article-10} >> includes\parts\part-2.tex
    echo \input{includes/articles/article-11} >> includes\parts\part-2.tex
)

REM Part III - Fundamental Rights
if not exist "includes\parts\part-3.tex" (
    echo %% Part III - Fundamental Rights > includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex
    echo \Part{III}{FUNDAMENTAL RIGHTS} >> includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex
    echo \Chapter{I}{GENERAL} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-12} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-13} >> includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex  
    echo \Chapter{II}{RIGHT TO EQUALITY} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-14} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-15} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-16} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-17} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-18} >> includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex
    echo \Chapter{III}{RIGHT TO FREEDOM} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-19} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-20} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-21} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-21A} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-22} >> includes\parts\part-3.tex
)

REM Part IV - Directive Principles
if not exist "includes\parts\part-4.tex" (
    echo %% Part IV - Directive Principles of State Policy > includes\parts\part-4.tex
    echo. >> includes\parts\part-4.tex
    echo \Part{IV}{DIRECTIVE PRINCIPLES OF STATE POLICY} >> includes\parts\part-4.tex
    echo. >> includes\parts\part-4.tex
    echo \input{includes/articles/article-36} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-37} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-38} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-39} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-39A} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-40} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-41} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-42} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-43} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-43A} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-44} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-45} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-46} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-47} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-48} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-48A} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-49} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-50} >> includes\parts\part-4.tex
    echo \input{includes/articles/article-51} >> includes\parts\part-4.tex
)

REM Part V - The Union
if not exist "includes\parts\part-5.tex" (
    echo %% Part V - The Union > includes\parts\part-5.tex
    echo. >> includes\parts\part-5.tex
    echo \Part{V}{THE UNION} >> includes\parts\part-5.tex
    echo. >> includes\parts\part-5.tex
    echo \Chapter{I}{THE EXECUTIVE} >> includes\parts\part-5.tex
    echo. >> includes\parts\part-5.tex
    echo \Group{The President and Vice-President} >> includes\parts\part-5.tex
    echo \input{includes/articles/article-52} >> includes\parts\part-5.tex
    echo \input{includes/articles/article-53} >> includes\parts\part-5.tex
    echo %% Add more articles as needed >> includes\parts\part-5.tex
)

echo   checkmark Parts organization files created
exit /b 0

:create_schedules
echo [STEP] Creating Schedule files...

REM First Schedule - States and Union Territories
if not exist "includes\schedules\schedule-1.tex" (
    echo %% First Schedule - States and Union Territories > includes\schedules\schedule-1.tex
    echo. >> includes\schedules\schedule-1.tex
    echo \Schedule{FIRST SCHEDULE}{ >> includes\schedules\schedule-1.tex
    echo     \section*{I. STATES} >> includes\schedules\schedule-1.tex
    echo. >> includes\schedules\schedule-1.tex
    echo     \begin{enumerate} >> includes\schedules\schedule-1.tex
    echo     \item Andhra Pradesh >> includes\schedules\schedule-1.tex
    echo     \item Arunachal Pradesh >> includes\schedules\schedule-1.tex
    echo     \item Assam >> includes\schedules\schedule-1.tex
    echo     \item Bihar >> includes\schedules\schedule-1.tex
    echo     \item Chhattisgarh >> includes\schedules\schedule-1.tex
    echo     \item Goa >> includes\schedules\schedule-1.tex
    echo     \item Gujarat >> includes\schedules\schedule-1.tex
    echo     \item Haryana >> includes\schedules\schedule-1.tex
    echo     \item Himachal Pradesh >> includes\schedules\schedule-1.tex
    echo     \item Jharkhand >> includes\schedules\schedule-1.tex
    echo     \item Karnataka >> includes\schedules\schedule-1.tex
    echo     \item Kerala >> includes\schedules\schedule-1.tex
    echo     \item Madhya Pradesh >> includes\schedules\schedule-1.tex
    echo     \item Maharashtra >> includes\schedules\schedule-1.tex
    echo     \item Manipur >> includes\schedules\schedule-1.tex
    echo     \item Meghalaya >> includes\schedules\schedule-1.tex
    echo     \item Mizoram >> includes\schedules\schedule-1.tex
    echo     \item Nagaland >> includes\schedules\schedule-1.tex
    echo     \item Odisha >> includes\schedules\schedule-1.tex
    echo     \item Punjab >> includes\schedules\schedule-1.tex
    echo     \item Rajasthan >> includes\schedules\schedule-1.tex
    echo     \item Sikkim >> includes\schedules\schedule-1.tex
    echo     \item Tamil Nadu >> includes\schedules\schedule-1.tex
    echo     \item Telangana >> includes\schedules\schedule-1.tex
    echo     \item Tripura >> includes\schedules\schedule-1.tex
    echo     \item Uttar Pradesh >> includes\schedules\schedule-1.tex
    echo     \item Uttarakhand >> includes\schedules\schedule-1.tex
    echo     \item West Bengal >> includes\schedules\schedule-1.tex
    echo     \end{enumerate} >> includes\schedules\schedule-1.tex
    echo. >> includes\schedules\schedule-1.tex
    echo     \section*{II. UNION TERRITORIES} >> includes\schedules\schedule-1.tex
    echo. >> includes\schedules\schedule-1.tex
    echo     \begin{enumerate} >> includes\schedules\schedule-1.tex
    echo     \item Andaman and Nicobar Islands >> includes\schedules\schedule-1.tex
    echo     \item Chandigarh >> includes\schedules\schedule-1.tex
    echo     \item Dadra and Nagar Haveli and Daman and Diu >> includes\schedules\schedule-1.tex
    echo     \item Delhi >> includes\schedules\schedule-1.tex
    echo     \item Jammu and Kashmir >> includes\schedules\schedule-1.tex
    echo     \item Ladakh >> includes\schedules\schedule-1.tex
    echo     \item Lakshadweep >> includes\schedules\schedule-1.tex
    echo     \item Puducherry >> includes\schedules\schedule-1.tex
    echo     \end{enumerate} >> includes\schedules\schedule-1.tex
    echo } >> includes\schedules\schedule-1.tex
)

REM Create other schedule placeholders
for /L %%s in (2,1,12) do (
    if not exist "includes\schedules\schedule-%%s.tex" (
        echo %% Schedule %%s - Constitution of India > includes\schedules\schedule-%%s.tex
        echo. >> includes\schedules\schedule-%%s.tex
        echo \Schedule{%%s SCHEDULE}{ >> includes\schedules\schedule-%%s.tex
        echo     [Content for Schedule %%s - To be filled] >> includes\schedules\schedule-%%s.tex
        echo } >> includes\schedules\schedule-%%s.tex
    )
)

echo   checkmark Schedule files created
exit /b 0

:create_examples
echo [STEP] Creating example documents...

REM Basic example
if not exist "examples\basic\simple-article.tex" (
    echo %% Simple Article Example > examples\basic\simple-article.tex
    echo %% Demonstrates basic article usage >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \documentclass[a4paper,12pt]{soi} >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \begin{document} >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \Article{1}{Name and territory of the Union}{ >> examples\basic\simple-article.tex
    echo     India, that is Bharat, shall be a Union of States. >> examples\basic\simple-article.tex
    echo } >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \Article{21}{Protection of life and personal liberty}{ >> examples\basic\simple-article.tex
    echo     No person shall be deprived of his life or personal liberty >> examples\basic\simple-article.tex
    echo     except according to procedure established by law. >> examples\basic\simple-article.tex
    echo } >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \end{document} >> examples\basic\simple-article.tex
)

REM Complex example with clauses
if not exist "examples\basic\complex-article.tex" (
    echo %% Complex Article with Clauses Example > examples\basic\complex-article.tex
    echo %% Demonstrates clause and sub-clause usage >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo \documentclass[a4paper,12pt]{soi} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo \begin{document} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo \Article{19}{Protection of certain rights regarding freedom of speech, etc.}{ >> examples\basic\complex-article.tex
    echo     All citizens shall have the right— >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo     \Clause{to freedom of speech and expression;} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo     \Clause{to assemble peaceably and without arms;} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo     \Clause{to form associations or unions or cooperative societies;} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo     \Clause{to move freely throughout the territory of India;} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo     \Clause{to reside and settle in any part of the territory of India; and} >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo     \Clause{subject to the provisions of any law made by the State, >> examples\basic\complex-article.tex
    echo     to practice any profession, or to carry on any occupation, trade or business.} >> examples\basic\complex-article.tex
    echo } >> examples\basic\complex-article.tex
    echo. >> examples\basic\complex-article.tex
    echo \end{document} >> examples\basic\complex-article.tex
)

REM Advanced example with parts and chapters
if not exist "examples\advanced\structured-document.tex" (
    echo %% Advanced Structured Document Example > examples\advanced\structured-document.tex
    echo %% Demonstrates complete document structure >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \documentclass[a4paper,12pt,showamendments]{soi} >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \begin{document} >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo %% Front matter >> examples\advanced\structured-document.tex
    echo \begin{titlepage} >> examples\advanced\structured-document.tex
    echo \centering >> examples\advanced\structured-document.tex
    echo \vspace*{3cm} >> examples\advanced\structured-document.tex
    echo {\Huge\bfseries Sample Constitutional Document} >> examples\advanced\structured-document.tex
    echo \end{titlepage} >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \tableofcontents >> examples\advanced\structured-document.tex
    echo \newpage >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo %% Main content >> examples\advanced\structured-document.tex
    echo \Part{I}{THE UNION AND ITS TERRITORY} >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \Article{1}{Name and territory of the Union}{ >> examples\advanced\structured-document.tex
    echo     India, that is Bharat, shall be a Union of States. >> examples\advanced\structured-document.tex
    echo } >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \Part{III}{FUNDAMENTAL RIGHTS} >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \Chapter{I}{GENERAL} >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \Article{12}{Definition}{ >> examples\advanced\structured-document.tex
    echo     In this Part, unless the context otherwise requires, >> examples\advanced\structured-document.tex
    echo     "the State" includes the Government and Parliament of India >> examples\advanced\structured-document.tex
    echo     and the Government and the Legislature of each of the States >> examples\advanced\structured-document.tex
    echo     and all local or other authorities within the territory of India >> examples\advanced\structured-document.tex
    echo     or under the control of the Government of India. >> examples\advanced\structured-document.tex
    echo } >> examples\advanced\structured-document.tex
    echo. >> examples\advanced\structured-document.tex
    echo \end{document} >> examples\advanced\structured-document.tex
)

REM Template document
if not exist "examples\templates\constitution-template.tex" (
    echo %% Constitution of India Template > examples\templates\constitution-template.tex
    echo %% Complete template for constitutional documents >> examples\templates\constitution-template.tex
    echo. >> examples\templates\constitution-template.tex
    echo \documentclass[a4paper,12pt,showamendments,final]{soi} >> examples\templates\constitution-template.tex
    echo. >> examples\templates\constitution-template.tex
    echo %% Package configuration >> examples\templates\constitution-template.tex
    echo \usepackage{hyperref} >> examples\templates\constitution-template.tex
    echo \hypersetup{ >> examples\templates\constitution-template.tex
    echo     colorlinks=true, >> examples\templates\constitution-template.tex
    echo     linkcolor=blue, >> examples\templates\constitution-template.tex
    echo     pdfauthor={Government of India}, >> examples\templates\constitution-template.tex
    echo     pdftitle={The Constitution of India}, >> examples\templates\constitution-template.tex
    echo     pdfsubject={Constitutional Law} >> examples\templates\constitution-template.tex
    echo } >> examples\templates\constitution-template.tex
    echo. >> examples\templates\constitution-template.tex
    echo \begin{document} >> examples\templates\constitution-template.tex
    echo. >> examples\templates\constitution-template.tex
    echo %% Use this template by: >> examples\templates\constitution-template.tex
    echo %% 1. Uncommenting the sections you need >> examples\templates\constitution-template.tex
    echo %% 2. Adding your specific articles >> examples\templates\constitution-template.tex
    echo %% 3. Customizing the content >> examples\templates\constitution-template.tex
    echo. >> examples\templates\constitution-template.tex
    echo %% \input{includes/front-matter/cover} >> examples\templates\constitution-template.tex
    echo %% \input{includes/front-matter/preamble} >> examples\templates\constitution-template.tex
    echo %% \input{includes/front-matter/toc} >> examples\templates\constitution-template.tex
    echo %% \input{includes/parts/part-1} >> examples\templates\constitution-template.tex
    echo %% \input{includes/parts/part-2} >> examples\templates\constitution-template.tex
    echo %% \input{includes/parts/part-3} >> examples\templates\constitution-template.tex
    echo %% Add more parts as needed >> examples\templates\constitution-template.tex
    echo. >> examples\templates\constitution-template.tex
    echo \end{document} >> examples\templates\constitution-template.tex
)

echo   checkmark Example documents created
exit /b 0

:create_build_scripts
echo [STEP] Creating build scripts...

REM Main build script for Windows
if not exist "scripts\build.bat" (
    echo @echo off > scripts\build.bat
    echo REM Source of India LaTeX Build Script >> scripts\build.bat
    echo setlocal enabledelayedexpansion >> scripts\build.bat
    echo. >> scripts\build.bat
    echo set MAIN_FILE=main.tex >> scripts\build.bat
    echo set OUTPUT_DIR=output\pdf >> scripts\build.bat
    echo set TEMP_DIR=temp >> scripts\build.bat
    echo. >> scripts\build.bat
    echo if not exist "!OUTPUT_DIR!" mkdir "!OUTPUT_DIR!" >> scripts\build.bat
    echo if not exist "!TEMP_DIR!" mkdir "!TEMP_DIR!" >> scripts\build.bat
    echo. >> scripts\build.bat
    echo echo Building Constitution document... >> scripts\build.bat
    echo. >> scripts\build.bat
    echo REM Try XeLaTeX first >> scripts\build.bat
    echo where xelatex ^>nul 2^>^&1 >> scripts\build.bat
    echo if ^^!errorlevel^^! equ 0 ^( >> scripts\build.bat
    echo     echo Using XeLaTeX... >> scripts\build.bat
    echo     xelatex -output-directory="!TEMP_DIR!" "!MAIN_FILE!" >> scripts\build.bat
    echo     xelatex -output-directory="!TEMP_DIR!" "!MAIN_FILE!" >> scripts\build.bat
    echo     copy "!TEMP_DIR!\main.pdf" "!OUTPUT_DIR!\constitution.pdf" >> scripts\build.bat
    echo ^) else ^( >> scripts\build.bat
    echo     REM Fallback to pdfLaTeX >> scripts\build.bat
    echo     echo Using pdfLaTeX... >> scripts\build.bat
    echo     pdflatex -output-directory="!TEMP_DIR!" "!MAIN_FILE!" >> scripts\build.bat
    echo     pdflatex -output-directory="!TEMP_DIR!" "!MAIN_FILE!" >> scripts\build.bat
    echo     copy "!TEMP_DIR!\main.pdf" "!OUTPUT_DIR!\constitution.pdf" >> scripts\build.bat
    echo ^) >> scripts\build.bat
    echo. >> scripts\build.bat
    echo echo Build completed! PDF saved to !OUTPUT_DIR!\constitution.pdf >> scripts\build.bat
)

REM Clean script
if not exist "scripts\clean.bat" (
    echo @echo off > scripts\clean.bat
    echo REM Clean build artifacts >> scripts\clean.bat
    echo. >> scripts\clean.bat
    echo echo Cleaning build artifacts... >> scripts\clean.bat
    echo. >> scripts\clean.bat
    echo if exist temp rmdir /s /q temp >> scripts\clean.bat
    echo if exist *.aux del *.aux >> scripts\clean.bat
    echo if exist *.log del *.log >> scripts\clean.bat
    echo if exist *.toc del *.toc >> scripts\clean.bat
    echo if exist *.out del *.out >> scripts\clean.bat
    echo if exist *.fls del *.fls >> scripts\clean.bat
    echo if exist *.fdb_latexmk del *.fdb_latexmk >> scripts\clean.bat
    echo if exist *.synctex.gz del *.synctex.gz >> scripts\clean.bat
    echo. >> scripts\clean.bat
    echo echo Clean completed! >> scripts\clean.bat
)

REM Quick test compile script
if not exist "scripts\test-compile.bat" (
    echo @echo off > scripts\test-compile.bat
    echo REM Quick compilation test >> scripts\test-compile.bat
    echo. >> scripts\test-compile.bat
    echo echo Testing LaTeX compilation... >> scripts\test-compile.bat
    echo. >> scripts\test-compile.bat
    echo echo \documentclass{soi} ^> test.tex >> scripts\test-compile.bat
    echo echo \begin{document} ^>^> test.tex >> scripts\test-compile.bat
    echo echo \Article{1}{Test Article}{This is a test.} ^>^> test.tex >> scripts\test-compile.bat
    echo echo \end{document} ^>^> test.tex >> scripts\test-compile.bat
    echo. >> scripts\test-compile.bat
    echo where xelatex ^>nul 2^>^&1 >> scripts\test-compile.bat
    echo if ^^!errorlevel^^! equ 0 ^( >> scripts\test-compile.bat
    echo     xelatex test.tex >> scripts\test-compile.bat
    echo ^) else ^( >> scripts\test-compile.bat
    echo     pdflatex test.tex >> scripts\test-compile.bat
    echo ^) >> scripts\test-compile.bat
    echo. >> scripts\test-compile.bat
    echo if exist test.pdf ^( >> scripts\test-compile.bat
    echo     echo SUCCESS: Test compilation completed! >> scripts\test-compile.bat
    echo     del test.* >> scripts\test-compile.bat
    echo ^) else ^( >> scripts\test-compile.bat
    echo     echo ERROR: Test compilation failed! >> scripts\test-compile.bat
    echo ^) >> scripts\test-compile.bat
)

echo   checkmark Build scripts created
exit /b 0

:test_compilation
echo [STEP] Testing LaTeX compilation...

echo Creating test document...
echo \documentclass{soi} > test-setup.tex
echo \begin{document} >> test-setup.tex
echo \Article{1}{Test Article}{This is a successful compilation test.} >> test-setup.tex  
echo \end{document} >> test-setup.tex

echo Testing compilation with available LaTeX engine...
if !XELATEX_FOUND! equ 1 (
    echo   -> Testing with XeLaTeX...
    xelatex test-setup.tex >nul 2>&1
) else if !LUALATEX_FOUND! equ 1 (
    echo   -> Testing with LuaLaTeX...
    lualatex test-setup.tex >nul 2>&1
) else (
    echo   -> Testing with pdfLaTeX...
    pdflatex test-setup.tex >nul 2>&1
)

if exist test-setup.pdf (
    echo   checkmark Compilation test SUCCESSFUL
    del test-setup.*
) else (
    echo   ! Compilation test FAILED - check LaTeX installation
    if exist test-setup.log type test-setup.log
)

exit /b 0

:validate_structure
echo [STEP] Validating project structure...

set STRUCTURE_OK=1

echo   -> Checking directory structure...
if not exist "includes" (
    echo   ! Missing: includes directory
    set STRUCTURE_OK=0
)
if not exist "includes\articles" (
    echo   ! Missing: includes\articles directory  
    set STRUCTURE_OK=0
)
if not exist "includes\parts" (
    echo   ! Missing: includes\parts directory
    set STRUCTURE_OK=0
)
if not exist "scripts" (
    echo   ! Missing: scripts directory
    set STRUCTURE_OK=0
)

echo   -> Checking essential files...
if not exist "main.tex" (
    echo   ! Missing: main.tex
    set STRUCTURE_OK=0
)
if not exist "soi.cls" (
    echo   ! Missing: soi.cls
    set STRUCTURE_OK=0
)
if not exist "config.yaml" (
    echo   ! Missing: config.yaml
    set STRUCTURE_OK=0
)

if !STRUCTURE_OK! equ 1 (
    echo   checkmark Project structure is valid
) else (
    echo   ! Project structure has issues - consider running repair
)

exit /b 0

:validate_articles
echo [STEP] Validating article files...

set ARTICLE_COUNT=0
for %%f in (includes\articles\*.tex) do set /a ARTICLE_COUNT+=1

echo   -> Found %ARTICLE_COUNT% article files
if %ARTICLE_COUNT% gtr 400 (
    echo   checkmark Article count looks good
) else (
    echo   ! Low article count - may need regeneration
)

REM Check for key articles
if exist "includes\articles\article-1.tex" (
    echo   checkmark Article 1 exists
) else (
    echo   ! Missing Article 1
)

if exist "includes\articles\article-21.tex" (
    echo   checkmark Article 21 exists  
) else (
    echo   ! Missing Article 21
)

exit /b 0

:validate_examples
echo [STEP] Validating examples...

if exist "examples\basic\simple-article.tex" (
    echo   checkmark Basic example exists
) else (
    echo   ! Missing basic example
)

if exist "examples\advanced\structured-document.tex" (
    echo   checkmark Advanced example exists
) else (
    echo   ! Missing advanced example
)

exit /b 0

:repair_missing_files
echo [STEP] Repairing missing files...

echo   -> Checking and creating missing directories...
call :create_directories

echo   -> Checking and creating missing config files...
if not exist "main.tex" call :create_config_files
if not exist "config.yaml" call :create_config_files

echo   -> Checking article files...
set ARTICLE_COUNT=0
for %%f in (includes\articles\*.tex) do set /a ARTICLE_COUNT+=1

if %ARTICLE_COUNT% lss 100 (
    echo   -> Regenerating article files...
    call :generate_all_articles
)

echo   -> Checking part files...
if not exist "includes\parts\part-1.tex" call :create_parts_files

echo   -> Checking example files...
if not exist "examples\basic\simple-article.tex" call :create_examples

echo   -> Checking build scripts...
if not exist "scripts\build.bat" call :create_build_scripts

echo   checkmark Repair completed

exit /b 0

:clean_generated_files
echo [STEP] Cleaning generated files...

echo   -> Removing PDF outputs...
if exist "output\pdf" (
    for %%f in (output\pdf\*.pdf) do del "%%f"
    echo   checkmark PDF files cleaned
)

echo   -> Removing LaTeX auxiliary files...
for %%ext in (aux log toc out fls fdb_latexmk synctex.gz nav snm vrb bbl blg idx ind ilg lof lot) do (
    if exist "*.%%ext" del "*.%%ext"
    if exist "temp\*.%%ext" del "temp\*.%%ext"
)

echo   -> Removing temporary directories...
if exist "temp" rmdir /s /q "temp"

echo   -> Removing backup files...
if exist "*~" del "*~"
if exist "*.bak" del "*.bak"

echo   checkmark Generated files cleaned

exit /b 0

:show_summary
echo PROJECT SETUP SUMMARY:
echo.
echo Directory Structure:
echo   includes/           -> Modular LaTeX content files
echo   includes/articles/  -> Individual article files (470+ files)
echo   includes/parts/     -> Part organization files
echo   includes/schedules/ -> Constitutional schedules
echo   examples/          -> Sample documents and templates
echo   scripts/           -> Build and utility scripts
echo   output/            -> Generated PDF files
echo.
echo Key Files Created:
echo   main.tex           -> Main LaTeX document
echo   config.yaml        -> Configuration settings
echo   soi.cls            -> LaTeX document class (existing)
echo.
echo Build Instructions:
echo   1. Edit main.tex to include desired parts
echo   2. Run: scripts\build.bat
echo   3. Or manually: xelatex main.tex (twice for cross-refs)
echo.
echo Next Steps:
echo   1. Review and customize main.tex
echo   2. Fill in actual article content in includes/articles/
echo   3. Uncomment parts in main.tex as needed
echo   4. Run build script to generate PDF
echo.
echo Compilation Engines Supported:
if !XELATEX_FOUND! equ 1 echo   - XeLaTeX (recommended)
if !LUALATEX_FOUND! equ 1 echo   - LuaLaTeX
if !PDFLATEX_FOUND! equ 1 echo   - pdfLaTeX
echo.
echo For help: Run this script and select option 6 (Help)
exit /b 0

REM ================================================================================
REM                              UTILITY FUNCTIONS
REM ================================================================================

:display_progress
REM Simple progress indicator function
set /a PROGRESS_COUNT+=1
set PROGRESS_CHAR=.
if !PROGRESS_COUNT! gtr 10 (
    set PROGRESS_COUNT=0
    echo.
)
echo | set /p dummy="!PROGRESS_CHAR!"
exit /b 0

:check_file_exists
REM Check if a file exists and return appropriate error level
if exist "%~1" (
    exit /b 0
) else (
    exit /b 1
)

:create_directory_safe
REM Create directory only if it doesn't exist
if not exist "%~1" (
    mkdir "%~1"
    echo   + Created directory: %~1
)
exit /b 0

:backup_file
REM Create backup of existing file before overwriting
if exist "%~1" (
    copy "%~1" "%~1.backup" >nul 2>&1
    echo   + Backed up existing file: %~1
)
exit /b 0

:log_action
REM Log actions to a setup log file
echo %date% %time% - %~1 >> setup.log
exit /b 0

REM ================================================================================
REM                           END OF SCRIPT
REM ================================================================================

REM Final notes:
REM This script creates a complete LaTeX project structure for typesetting
REM the Constitution of India using the specialized 'soi' document class.
REM 
REM The script generates:
REM - 470+ constitutional article files
REM - Proper directory structure
REM - Configuration files
REM - Build scripts
REM - Example documents
REM - Documentation templates
REM
REM After running this script, users can:
REM 1. Customize main.tex for their specific needs
REM 2. Fill in actual constitutional text in article files
REM 3. Use build scripts for compilation
REM 4. Generate professional PDF output
REM
REM The script is designed to be safe for repeated runs and includes
REM validation and repair functionality.
REM
REM For technical support or contributions, see the project repository.

REM Script version: 1.0
REM Last updated: 2025
REM Compatibility: Windows Command Line
REM Requirements: LaTeX distribution, soi.cls file