@echo off
setlocal enabledelayedexpansion

echo ================================================================
echo Source of India LaTeX Project - Cleanup and Restructure Script
echo ================================================================
echo.

:: Check if we're in the right directory
if not exist "soi.cls" (
    echo ERROR: soi.cls not found. Please run this script from the project root.
    pause
    exit /b 1
)

echo [INFO] Starting project cleanup and restructuring...
echo.

:: Create backup of current structure
echo [STEP 1] Creating backup of current structure...
if exist "backup" (
    echo [WARN] Backup directory already exists, skipping backup creation
) else (
    mkdir backup
    xcopy /E /I /Q . backup\ >nul 2>&1
    echo [OK] Backup created in 'backup' directory
)
echo.

:: Clean up existing problematic directories
echo [STEP 2] Cleaning up existing directory structure...
if exist "includes\articles" (
    rmdir /S /Q "includes\articles" >nul 2>&1
    echo [OK] Removed old includes\articles directory
)
echo.

:: Create the new directory structure
echo [STEP 3] Creating new directory structure...

:: Main directories
mkdir "includes" >nul 2>&1
mkdir "includes\parts" >nul 2>&1
mkdir "includes\articles" >nul 2>&1
mkdir "includes\schedules" >nul 2>&1
mkdir "amendments" >nul 2>&1
mkdir "fonts" >nul 2>&1
mkdir "docs" >nul 2>&1
mkdir "tests" >nul 2>&1
mkdir "tests\unit" >nul 2>&1
mkdir "tests\integration" >nul 2>&1
mkdir "tests\visual" >nul 2>&1
mkdir "scripts" >nul 2>&1

echo [OK] Created main directory structure

:: Create individual article directories and files
echo [STEP 4] Creating individual article files...

:: Articles 1-30 (Part I - The Union and its Territory)
for /L %%i in (1,1,4) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 5-11 (Part I continued)
for /L %%i in (5,1,11) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 12-35 (Part III - Fundamental Rights)
for /L %%i in (12,1,35) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 36-51 (Part IV - Directive Principles)
for /L %%i in (36,1,51) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 52-78 (Part V - The Union Executive)
for /L %%i in (52,1,78) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 79-122 (Part V continued - Parliament)
for /L %%i in (79,1,122) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 123-213 (Parts VI-VIII - States, Union Territories)
for /L %%i in (123,1,213) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 214-232 (Part VI continued - High Courts)
for /L %%i in (214,1,232) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 233-237 (Part VI continued - Subordinate Courts)
for /L %%i in (233,1,237) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 238-242 (Part VIII - Union Territories)
for /L %%i in (238,1,242) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 243-243ZT (Parts IX-IXA - Panchayats and Municipalities)
for /L %%i in (243,1,300) do (
    if %%i leq 243 (
        echo. > "includes\articles\article-%%i.tex"
    )
)

:: Create special articles with suffixes (243A, 243B, etc.)
set "suffixes=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ZA ZB ZC ZD ZE ZF ZG ZH ZI ZJ ZK ZL ZM ZN ZO ZP ZQ ZR ZS ZT"
for %%s in (%suffixes%) do (
    echo. > "includes\articles\article-243%%s.tex"
)

:: Articles 244-263 (Parts X-XI - Scheduled Areas, Relations between Union and States)
for /L %%i in (244,1,263) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 264-300A (Parts XII-XIII - Finance, Trade and Commerce)
for /L %%i in (264,1,300) do (
    echo. > "includes\articles\article-%%i.tex"
)
echo. > "includes\articles\article-300A.tex"

:: Articles 301-323 (Part XIII continued)
for /L %%i in (301,1,323) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 323A-323B (Part XIVA - Tribunals)
echo. > "includes\articles\article-323A.tex"
echo. > "includes\articles\article-323B.tex"

:: Articles 324-329A (Part XV - Elections)
for /L %%i in (324,1,329) do (
    echo. > "includes\articles\article-%%i.tex"
)
echo. > "includes\articles\article-329A.tex"

:: Articles 330-342 (Part XVI - Special Provisions for Certain Classes)
for /L %%i in (330,1,342) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 343-351 (Part XVII - Official Language)
for /L %%i in (343,1,351) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 352-360 (Part XVIII - Emergency Provisions)
for /L %%i in (352,1,360) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 361-367 (Part XIX - Miscellaneous)
for /L %%i in (361,1,367) do (
    echo. > "includes\articles\article-%%i.tex"
)

:: Articles 368 (Part XX - Amendment of Constitution)
echo. > "includes\articles\article-368.tex"

:: Articles 369-395 (Part XXI - Temporary, Transitional and Special Provisions)
for /L %%i in (369,1,395) do (
    echo. > "includes\articles\article-%%i.tex"
)

echo [OK] Created individual article files (1-395 plus special articles)

:: Create part files
echo [STEP 5] Creating part template files...
for /L %%i in (1,1,22) do (
    echo. > "includes\parts\part-%%i.tex"
)
echo [OK] Created part template files (1-22)

:: Create schedule files
echo [STEP 6] Creating schedule template files...
for /L %%i in (1,1,12) do (
    echo. > "includes\schedules\schedule-%%i.tex"
)
echo [OK] Created schedule template files (1-12)

:: Create test files
echo [STEP 7] Creating test framework files...
echo. > "tests\unit\test-parts.tex"
echo. > "tests\unit\test-articles.tex"
echo. > "tests\unit\test-amendments.tex"
echo. > "tests\integration\full-compile.tex"
echo. > "tests\integration\cross-references.tex"
echo. > "tests\visual\layout-a4.tex"
echo. > "tests\visual\layout-a5.tex"
echo [OK] Created test framework files

:: Create documentation templates
echo [STEP 8] Creating documentation templates...
echo. > "docs\user-guide.md"
echo. > "docs\developer-guide.md"
echo [OK] Created documentation templates

:: Create utility scripts
echo [STEP 9] Creating utility scripts...
echo. > "scripts\setup-project.sh"
echo. > "scripts\validate-structure.py"
echo [OK] Created utility scripts

:: Update main.tex with proper structure
echo [STEP 10] Creating updated main.tex template...
(
echo %%% Source of India LaTeX Document
echo %%% Main document file
echo.
echo \documentclass[a4paper,12pt]{soi}
echo.
echo %%% Load configuration
echo \input{config}
echo.
echo \begin{document}
echo.
echo %%% Front matter
echo \input{includes/cover}
echo \input{includes/preamble}
echo \input{includes/toc}
echo.
echo %%% Parts and Articles
echo %%% Part I - The Union and its Territory
echo \input{includes/parts/part-1}
echo.
echo %%% Part II - Citizenship
echo \input{includes/parts/part-2}
echo.
echo %%% Part III - Fundamental Rights  
echo \input{includes/parts/part-3}
echo.
echo %%% Continue with other parts...
echo %%% TODO: Add remaining parts
echo.
echo %%% Schedules
echo \input{includes/schedules/schedule-1}
echo %%% TODO: Add remaining schedules
echo.
echo \end{document}
) > "main.tex"
echo [OK] Created updated main.tex template

:: Create article inclusion helper
echo [STEP 11] Creating article management utilities...
(
echo %%% Article inclusion helper
echo %%% Usage: \includeArticle{number}
echo.
echo \newcommand{\includeArticle}[1]{%%
echo     \IfFileExists{includes/articles/article-#1.tex}{%%
echo         \input{includes/articles/article-#1.tex}%%
echo     }{%%
echo         \PackageWarning{soi}{Article #1 file not found}%%
echo     }%%
echo }
echo.
echo %%% Range inclusion helper  
echo %%% Usage: \includeArticleRange{1}{30}
echo \newcommand{\includeArticleRange}[2]{%%
echo     \forloop{articleloop}{#1}{\value{articleloop} ^< #2}{%%
echo         \includeArticle{\arabic{articleloop}}%%
echo     }%%
echo }
) > "includes\article-helpers.tex"
echo [OK] Created article management utilities

:: Create validation script
echo [STEP 12] Creating structure validation...
(
echo @echo off
echo echo Validating Source of India project structure...
echo.
echo set "errors=0"
echo.
echo :: Check main files
echo if not exist "soi.cls" ^(
echo     echo ERROR: soi.cls not found
echo     set /a "errors+=1"  
echo ^)
echo.
echo if not exist "main.tex" ^(
echo     echo ERROR: main.tex not found
echo     set /a "errors+=1"
echo ^)
echo.
echo :: Check article files
echo set "missing_articles=0"
echo for /L %%%%i in ^(1,1,395^) do ^(
echo     if not exist "includes\articles\article-%%%%i.tex" ^(
echo         set /a "missing_articles+=1"
echo     ^)
echo ^)
echo.
echo if %%missing_articles%% gtr 0 ^(
echo     echo WARNING: %%missing_articles%% article files missing
echo ^)
echo.
echo if %%errors%% equ 0 ^(
echo     echo [OK] Project structure validation passed
echo ^) else ^(
echo     echo [ERROR] Project structure validation failed with %%errors%% errors
echo ^)
) > "scripts\validate-structure.bat"
echo [OK] Created structure validation script

:: Final summary
echo.
echo ================================================================
echo                    RESTRUCTURING COMPLETE
echo ================================================================
echo.
echo Project structure has been reorganized with:
echo   - Individual files for each article (1-395 + special articles)
echo   - Separate part files (1-22)  
echo   - Schedule files (1-12)
echo   - Test framework structure
echo   - Documentation templates
echo   - Utility scripts
echo.
echo Key files created:
echo   - includes\article-helpers.tex (article inclusion utilities)
echo   - scripts\validate-structure.bat (structure validation)
echo   - Updated main.tex template
echo.
echo Next steps:
echo   1. Run scripts\validate-structure.bat to verify structure
echo   2. Populate individual article files with content
echo   3. Update soi.cls with new inclusion logic
echo   4. Test compilation with your LaTeX distribution
echo.
echo Original structure backed up in 'backup' directory
echo ================================================================
pause