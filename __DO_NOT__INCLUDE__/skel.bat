@echo off
setlocal enabledelayedexpansion

REM Source of India LaTeX Project Setup Script - Simplified Version
REM Creates basic directory structure and dummy files only

title Source of India LaTeX Project Setup

:main_menu
cls
echo.
echo ================================================================================
echo                    SOURCE OF INDIA LATEX PROJECT SETUP
echo ================================================================================
echo.
echo Simplified Setup - Creates directory structure and dummy files
echo.
echo Main Menu:
echo.
echo [1] Create Project Structure    - Generate directories and dummy files
echo [2] Validate Project           - Check existing setup
echo [3] Clean Generated Files      - Remove output files only
echo [4] Help                       - Show information about this script
echo [5] Exit                       - Quit the setup script
echo.
echo ================================================================================
echo.

set /p choice="Please select an option (1-5): "

if "%choice%"=="1" goto create_structure
if "%choice%"=="2" goto validate_project
if "%choice%"=="3" goto clean_files
if "%choice%"=="4" goto show_help
if "%choice%"=="5" goto exit_script

echo.
echo Invalid choice. Please select a number between 1 and 5.
pause
goto main_menu

:create_structure
cls
echo.
echo ================================================================================
echo                        CREATING PROJECT STRUCTURE
echo ================================================================================
echo.

REM Check prerequisites
if not exist "soi.cls" (
    echo ERROR: soi.cls not found in current directory!
    echo Please run this script from the directory containing soi.cls
    echo.
    pause
    goto main_menu
)

echo Creating directory structure...
echo.

REM Create main directories
call :create_directories

echo Creating configuration files...
echo.

REM Create basic config files
call :create_config_files

echo Generating article files...
echo.

REM Generate dummy article files
call :generate_article_files

echo Creating part files...
echo.

REM Create part organization files
call :create_part_files

echo Creating example files...
echo.

REM Create basic examples
call :create_examples

echo.
echo ================================================================================
echo                     PROJECT STRUCTURE CREATED SUCCESSFULLY!
echo ================================================================================
echo.
echo Created:
echo   - Directory structure (includes/, examples/, docs/, etc.)
echo   - Configuration files (main.tex, config.yaml)
echo   - 470+ dummy article files (article-1.tex, article-21A.tex, etc.)
echo   - Part organization files (part-1.tex, part-2.tex, etc.)
echo   - Basic example documents
echo.
echo Next steps:
echo   1. Edit article files in includes/articles/ with actual content
echo   2. Modify main.tex to include desired parts
echo   3. Compile with: xelatex main.tex
echo.
echo Press any key to return to main menu...
pause >nul
goto main_menu

:clean_files
cls
echo.
echo ================================================================================
echo                           CLEAN GENERATED FILES
echo ================================================================================
echo.
echo This will remove generated output files but keep source files:
echo   - PDF files in output/
echo   - LaTeX auxiliary files (.aux, .log, .toc, .out, .fls, .fdb_latexmk)
echo   - Temporary files
echo.
echo Source files (.tex, .cls, config files) will be kept.
echo.
set /p confirm="Continue with cleanup? (Y/N): "
if /i not "%confirm%"=="Y" goto main_menu

echo.
echo Cleaning generated files...

REM Clean output directory
if exist "output\" (
    del /q "output\*.*" 2>nul
    echo   [OK] Cleaned output directory
)

REM Clean LaTeX auxiliary files
for %%ext in (aux log toc out fls fdb_latexmk synctex.gz) do (
    if exist "*.%%ext" (
        del "*.%%ext" 2>nul
        echo   [OK] Removed .%%ext files
    )
)

REM Clean temp directory
if exist "temp\" (
    rmdir /s /q "temp" 2>nul
    echo   [OK] Removed temp directory
)

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
echo Source of India LaTeX Project Setup Script - Simplified Version
echo.
echo PURPOSE:
echo This script creates a basic project structure for typesetting the Constitution
echo of India using the 'soi' LaTeX document class. It generates dummy files that
echo you can fill with actual content.
echo.
echo FEATURES:
echo - Creates organized directory structure
echo - Generates 470+ dummy article files (Articles 1-395, amendments, etc.)
echo - Creates basic configuration files
echo - Sets up example documents
echo - Validates existing project structure
echo - Cleans generated output files
echo.
echo REQUIREMENTS:
echo - soi.cls file must be in the current directory
echo - LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
echo - Windows command line environment
echo.
echo ARTICLE FILES CREATED:
echo - Basic articles: article-1.tex to article-395.tex
echo - Amendment articles: article-21A.tex, article-31A.tex, etc.
echo - Panchayat articles: article-243A.tex to article-243O.tex
echo - Municipality articles: article-243P.tex to article-243ZG.tex
echo - Co-operative articles: article-243ZH.tex to article-243ZT.tex
echo.
echo AFTER SETUP:
echo 1. Edit article files in includes/articles/ with actual constitutional text
echo 2. Modify main.tex to include the parts you want
echo 3. Compile with: xelatex main.tex (or pdflatex/lualatex)
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
echo For more information:
echo - Read the generated docs/README.txt
echo - Check examples/ directory for sample usage
echo - Visit the project repository for documentation
echo.
exit /b 0

REM ================================================================================
REM                              FUNCTION DEFINITIONS
REM ================================================================================

:create_directories
REM Main project directories
for %%d in (includes includes\articles includes\parts includes\schedules includes\helpers includes\front-matter includes\back-matter) do (
    if not exist "%%d" mkdir "%%d"
)

REM Documentation and examples
for %%d in (docs examples examples\basic examples\advanced examples\templates) do (
    if not exist "%%d" mkdir "%%d"
)

REM Build and output directories
for %%d in (scripts output output\pdf temp) do (
    if not exist "%%d" mkdir "%%d"
)

echo   [OK] Directory structure created
exit /b 0

:create_config_files
REM Main LaTeX document
if not exist "main.tex" (
    echo %% Source of India Constitution - Main Document > main.tex
    echo %% Generated by SoI LaTeX Setup Script >> main.tex
    echo. >> main.tex
    echo \documentclass[a4paper,12pt]{soi} >> main.tex
    echo. >> main.tex
    echo \begin{document} >> main.tex
    echo. >> main.tex
    echo %% Front matter >> main.tex
    echo \input{includes/front-matter/cover} >> main.tex
    echo \input{includes/front-matter/preamble} >> main.tex
    echo \input{includes/front-matter/toc} >> main.tex
    echo. >> main.tex
    echo %% Main content - Uncomment parts as needed >> main.tex
    echo \input{includes/parts/part-1}  %% The Union and its Territory >> main.tex
    echo %% \input{includes/parts/part-2}  %% Citizenship >> main.tex
    echo %% \input{includes/parts/part-3}  %% Fundamental Rights >> main.tex
    echo %% Add more parts as needed >> main.tex
    echo. >> main.tex
    echo \end{document} >> main.tex
)

REM Configuration file
if not exist "config.yaml" (
    echo # Source of India LaTeX Configuration > config.yaml
    echo compiler: xelatex >> config.yaml
    echo page_size: a4 >> config.yaml
    echo font_size: 12 >> config.yaml
    echo show_amendments: true >> config.yaml
    echo output_dir: output/pdf >> config.yaml
)

REM Front matter files
if not exist "includes\front-matter\cover.tex" (
    echo %% Cover page > includes\front-matter\cover.tex
    echo \begin{titlepage} >> includes\front-matter\cover.tex
    echo \centering >> includes\front-matter\cover.tex
    echo \vspace*{3cm} >> includes\front-matter\cover.tex
    echo {\Huge\bfseries THE CONSTITUTION OF INDIA} >> includes\front-matter\cover.tex
    echo \vspace{2cm} >> includes\front-matter\cover.tex
    echo {\large As Adopted by the Constituent Assembly} >> includes\front-matter\cover.tex
    echo \vspace{0.5cm} >> includes\front-matter\cover.tex
    echo {\large 26th November 1949} >> includes\front-matter\cover.tex
    echo \vfill >> includes\front-matter\cover.tex
    echo {\large GOVERNMENT OF INDIA} >> includes\front-matter\cover.tex
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
    echo India into a SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC... >> includes\front-matter\preamble.tex
    echo \end{center} >> includes\front-matter\preamble.tex
    echo \newpage >> includes\front-matter\preamble.tex
)

if not exist "includes\front-matter\toc.tex" (
    echo %% Table of Contents > includes\front-matter\toc.tex
    echo \tableofcontents >> includes\front-matter\toc.tex
    echo \newpage >> includes\front-matter\toc.tex
)

if not exist "includes\back-matter\appendices.tex" (
    echo %% Back matter > includes\back-matter\appendices.tex
    echo %% Additional appendices can be added here >> includes\back-matter\appendices.tex
)

echo   [OK] Configuration files created
exit /b 0

:generate_article_files
REM Create basic articles 1-395
for /L %%i in (1,1,395) do (
    if not exist "includes\articles\article-%%i.tex" (
        echo %% Article %%i - Constitution of India > includes\articles\article-%%i.tex
        echo %% Replace with actual content >> includes\articles\article-%%i.tex
        echo. >> includes\articles\article-%%i.tex
        echo \Article{%%i}{[Article Title - To be filled]}{ >> includes\articles\article-%%i.tex
        echo     [Article content for Article %%i - Replace with actual constitutional text] >> includes\articles\article-%%i.tex
        echo } >> includes\articles\article-%%i.tex
    )
)

REM Amendment articles with A suffix
for %%a in (21A 31A 31B 31C 35A 39A 43A 48A 51A 103A 124A 124B 124C 131A 134A 139A 217A 224A 230A 239A 239AA 239AB 239B 244A 246A 269A 279A 290A 300A 312A 323A 323B 329A 338A 338B 342A 350A 350B 371A 371B 371C 371D 371E 371F 371G 371H 371I 371J 378A 394A) do (
    if not exist "includes\articles\article-%%a.tex" (
        echo %% Article %%a - Amendment Article > includes\articles\article-%%a.tex
        echo \Article{%%a}{[Amendment Article Title]}{ >> includes\articles\article-%%a.tex
        echo     [Content for Article %%a - Replace with actual text] >> includes\articles\article-%%a.tex
        echo } >> includes\articles\article-%%a.tex
    )
)

REM Panchayat articles (243A-243O)
for %%p in (243A 243B 243C 243D 243E 243F 243G 243H 243I 243J 243K 243L 243M 243N 243O) do (
    if not exist "includes\articles\article-%%p.tex" (
        echo %% Article %%p - Panchayats > includes\articles\article-%%p.tex
        echo \Article{%%p}{[Panchayat Article Title]}{ >> includes\articles\article-%%p.tex
        echo     [Panchayat provision content - Replace with actual text] >> includes\articles\article-%%p.tex
        echo } >> includes\articles\article-%%p.tex
    )
)

REM Municipality articles (243P-243ZG)
for %%m in (243P 243Q 243R 243S 243T 243U 243V 243W 243X 243Y 243Z 243ZA 243ZB 243ZC 243ZD 243ZE 243ZF 243ZG) do (
    if not exist "includes\articles\article-%%m.tex" (
        echo %% Article %%m - Municipalities > includes\articles\article-%%m.tex
        echo \Article{%%m}{[Municipality Article Title]}{ >> includes\articles\article-%%m.tex
        echo     [Municipality provision content - Replace with actual text] >> includes\articles\article-%%m.tex
        echo } >> includes\articles\article-%%m.tex
    )
)

REM Co-operative articles (243ZH-243ZT)
for %%c in (243ZH 243ZI 243ZJ 243ZK 243ZL 243ZM 243ZN 243ZO 243ZP 243ZQ 243ZR 243ZS 243ZT) do (
    if not exist "includes\articles\article-%%c.tex" (
        echo %% Article %%c - Co-operatives > includes\articles\article-%%c.tex
        echo \Article{%%c}{[Co-operative Article Title]}{ >> includes\articles\article-%%c.tex
        echo     [Co-operative provision content - Replace with actual text] >> includes\articles\article-%%c.tex
        echo } >> includes\articles\article-%%c.tex
    )
)

REM Create a few sample articles with actual content
echo %% Article 1 - Name and territory of the Union > includes\articles\article-1.tex
echo \Article{1}{Name and territory of the Union}{ >> includes\articles\article-1.tex
echo     \Clause{India, that is Bharat, shall be a Union of States.} >> includes\articles\article-1.tex
echo     \Clause{The States and the territories thereof shall be as specified in the First Schedule.} >> includes\articles\article-1.tex
echo     \Clause{The territory of India shall comprise the territories of the States, the Union territories, and such other territories as may be acquired.} >> includes\articles\article-1.tex
echo } >> includes\articles\article-1.tex

echo %% Article 21 - Protection of life and personal liberty > includes\articles\article-21.tex
echo \Article{21}{Protection of life and personal liberty}{ >> includes\articles\article-21.tex
echo     No person shall be deprived of his life or personal liberty except according to procedure established by law. >> includes\articles\article-21.tex
echo } >> includes\articles\article-21.tex

echo   [OK] Article files generated
exit /b 0

:create_part_files
REM Create part organization files
if not exist "includes\parts\part-1.tex" (
    echo %% Part I - The Union and its Territory > includes\parts\part-1.tex
    echo \Part{I}{THE UNION AND ITS TERRITORY} >> includes\parts\part-1.tex
    echo. >> includes\parts\part-1.tex
    echo \input{includes/articles/article-1} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-2} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-3} >> includes\parts\part-1.tex
    echo \input{includes/articles/article-4} >> includes\parts\part-1.tex
)

if not exist "includes\parts\part-2.tex" (
    echo %% Part II - Citizenship > includes\parts\part-2.tex
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

if not exist "includes\parts\part-3.tex" (
    echo %% Part III - Fundamental Rights > includes\parts\part-3.tex
    echo \Part{III}{FUNDAMENTAL RIGHTS} >> includes\parts\part-3.tex
    echo. >> includes\parts\part-3.tex
    echo %% Articles 12-35 >> includes\parts\part-3.tex
    echo \input{includes/articles/article-12} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-13} >> includes\parts\part-3.tex
    echo \input{includes/articles/article-14} >> includes\parts\part-3.tex
    echo %% Add more articles as needed >> includes\parts\part-3.tex
)

echo   [OK] Part files created
exit /b 0

:create_examples
REM Basic example
if not exist "examples\basic\simple-article.tex" (
    echo %% Simple Article Example > examples\basic\simple-article.tex
    echo \documentclass{soi} >> examples\basic\simple-article.tex
    echo \begin{document} >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \Article{1}{Name and territory of the Union}{ >> examples\basic\simple-article.tex
    echo     India, that is Bharat, shall be a Union of States. >> examples\basic\simple-article.tex
    echo } >> examples\basic\simple-article.tex
    echo. >> examples\basic\simple-article.tex
    echo \end{document} >> examples\basic\simple-article.tex
)

REM README file
if not exist "docs\README.txt" (
    echo Source of India LaTeX Project > docs\README.txt
    echo ================================ >> docs\README.txt
    echo. >> docs\README.txt
    echo This project contains dummy files for the Constitution of India. >> docs\README.txt
    echo. >> docs\README.txt
    echo To use: >> docs\README.txt
    echo 1. Edit article files in includes/articles/ >> docs\README.txt
    echo 2. Modify main.tex to include desired parts >> docs\README.txt
    echo 3. Compile with: xelatex main.tex >> docs\README.txt
    echo. >> docs\README.txt
    echo Generated by SoI LaTeX Setup Script >> docs\README.txt
)

echo   [OK] Example files created
exit /b 0 key to return to main menu...
pause >nul
goto main_menu

:validate_project
cls
echo.
echo ================================================================================
echo                           PROJECT VALIDATION
echo ================================================================================
echo.

echo Checking project structure...
echo.

REM Check for soi.cls
if exist "soi.cls" (
    echo   [OK] soi.cls found
) else (
    echo   [ERROR] soi.cls missing
)

REM Check main files
if exist "main.tex" (
    echo   [OK] main.tex found
) else (
    echo   [ERROR] main.tex missing
)

if exist "config.yaml" (
    echo   [OK] config.yaml found
) else (
    echo   [ERROR] config.yaml missing
)

REM Check directories
set DIRS=includes includes\articles includes\parts examples docs output
for %%d in (%DIRS%) do (
    if exist "%%d\" (
        echo   [OK] %%d directory exists
    ) else (
        echo   [ERROR] %%d directory missing
    )
)

REM Count article files
set /a ARTICLE_COUNT=0
for %%f in (includes\articles\*.tex) do set /a ARTICLE_COUNT+=1

echo.
echo Summary:
echo   - Article files found: %ARTICLE_COUNT%
echo   - Expected: 470+ files
echo.

if %ARTICLE_COUNT% gtr 400 (
    echo   [OK] Project appears complete
) else (
    echo   [WARNING] Project may be incomplete - consider running structure creation
)

echo.
echo Press any