@echo off
REM Source of India LaTeX Project Cleanup Script for Windows
REM Removes all LaTeX build files throughout the project directory structure
REM Usage: cleanup.bat [--dry-run]

setlocal enabledelayedexpansion

REM Colors for output (if supported)
set RED=[31m
set GREEN=[32m
set YELLOW=[33m
set BLUE=[34m
set NC=[0m

REM Check if dry-run mode
set DRY_RUN=false
if "%1"=="--dry-run" set DRY_RUN=true
if "%1"=="-n" set DRY_RUN=true

if "%DRY_RUN%"=="true" (
    echo %YELLOW%DRY RUN MODE - No files will actually be deleted%NC%
    echo.
)

REM Get the script directory and project root
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..

echo %BLUE%Source of India LaTeX Project Cleanup%NC%
echo %BLUE%======================================%NC%
echo Project root: %PROJECT_ROOT%
echo.

REM Define file extensions to clean
set EXTENSIONS=aux log toc out fls fdb_latexmk synctex.gz nav snm vrb bbl blg idx ind ilg lot lof glo gls glg xdy acn acr alg glsdefs run.xml bcf figlist makeidx pyg pythontex listing lol dpth md5 auxlock backup bak sav tmp temp fot cb cb2 lb gz ps dvi xcp upa upb fff ttt wrt cut cutt spl ent lox mw nlg nlo nls ptc slf slt stc

echo %BLUE%Cleaning LaTeX build files...%NC%
echo.

REM Clean LaTeX build files by extension
for %%e in (%EXTENSIONS%) do (
    echo %YELLOW%Cleaning %%e files...%NC%
    if "%DRY_RUN%"=="true" (
        for /r "%PROJECT_ROOT%" %%f in (*.%%e) do (
            if exist "%%f" (
                echo   %YELLOW%Would delete:%NC% %%~nxf
            )
        )
    ) else (
        for /r "%PROJECT_ROOT%" %%f in (*.%%e) do (
            if exist "%%f" (
                echo   %RED%Deleting:%NC% %%~nxf
                del "%%f" >nul 2>&1
            )
        )
    )
    echo.
)

echo %BLUE%Cleaning LaTeX directories...%NC%
echo.

REM Clean specific LaTeX directories
echo %YELLOW%Cleaning Minted cache directories...%NC%
if "%DRY_RUN%"=="true" (
    for /d /r "%PROJECT_ROOT%" %%d in (_minted-*) do (
        if exist "%%d" (
            echo   %YELLOW%Would delete directory:%NC% %%~nxd
        )
    )
) else (
    for /d /r "%PROJECT_ROOT%" %%d in (_minted-*) do (
        if exist "%%d" (
            echo   %RED%Deleting directory:%NC% %%~nxd
            rmdir /s /q "%%d" >nul 2>&1
        )
    )
)
echo.

echo %YELLOW%Cleaning TeXPad temporary directories...%NC%
if "%DRY_RUN%"=="true" (
    for /d /r "%PROJECT_ROOT%" %%d in (.texpadtmp) do (
        if exist "%%d" (
            echo   %YELLOW%Would delete directory:%NC% %%~nxd
        )
    )
) else (
    for /d /r "%PROJECT_ROOT%" %%d in (.texpadtmp) do (
        if exist "%%d" (
            echo   %RED%Deleting directory:%NC% %%~nxd
            rmdir /s /q "%%d" >nul 2>&1
        )
    )
)
echo.

echo %YELLOW%Cleaning AUCTeX auto directories...%NC%
if "%DRY_RUN%"=="true" (
    for /d /r "%PROJECT_ROOT%" %%d in (auto) do (
        if exist "%%d" (
            echo   %YELLOW%Would delete directory:%NC% %%~nxd
        )
    )
) else (
    for /d /r "%PROJECT_ROOT%" %%d in (auto) do (
        if exist "%%d" (
            echo   %RED%Deleting directory:%NC% %%~nxd
            rmdir /s /q "%%d" >nul 2>&1
        )
    )
)
echo.

echo %BLUE%Cleaning OS-specific files...%NC%
echo.

REM Clean OS-specific files
echo %YELLOW%Cleaning Windows thumbnail cache files...%NC%
if "%DRY_RUN%"=="true" (
    for /r "%PROJECT_ROOT%" %%f in (Thumbs.db) do (
        if exist "%%f" (
            echo   %YELLOW%Would delete:%NC% %%~nxf
        )
    )
) else (
    for /r "%PROJECT_ROOT%" %%f in (Thumbs.db) do (
        if exist "%%f" (
            echo   %RED%Deleting:%NC% %%~nxf
            del "%%f" >nul 2>&1
        )
    )
)
echo.

echo %YELLOW%Cleaning Windows desktop configuration files...%NC%
if "%DRY_RUN%"=="true" (
    for /r "%PROJECT_ROOT%" %%f in (Desktop.ini) do (
        if exist "%%f" (
            echo   %YELLOW%Would delete:%NC% %%~nxf
        )
    )
) else (
    for /r "%PROJECT_ROOT%" %%f in (Desktop.ini) do (
        if exist "%%f" (
            echo   %RED%Deleting:%NC% %%~nxf
            del "%%f" >nul 2>&1
        )
    )
)
echo.

echo %BLUE%Cleaning editor temporary files...%NC%
echo.

REM Clean editor temporary files
echo %YELLOW%Cleaning editor swap and backup files...%NC%
set EDITOR_PATTERNS=*.swp *.swo *~ #*# .#*
for %%p in (%EDITOR_PATTERNS%) do (
    if "%DRY_RUN%"=="true" (
        for /r "%PROJECT_ROOT%" %%f in (%%p) do (
            if exist "%%f" (
                echo   %YELLOW%Would delete:%NC% %%~nxf
            )
        )
    ) else (
        for /r "%PROJECT_ROOT%" %%f in (%%p) do (
            if exist "%%f" (
                echo   %RED%Deleting:%NC% %%~nxf
                del "%%f" >nul 2>&1
            )
        )
    )
)
echo.

echo %BLUE%Cleaning IDE directories...%NC%
echo.

REM Clean IDE directories
echo %YELLOW%Cleaning VS Code configuration directories...%NC%
if "%DRY_RUN%"=="true" (
    for /d /r "%PROJECT_ROOT%" %%d in (.vscode) do (
        if exist "%%d" (
            echo   %YELLOW%Would delete directory:%NC% %%~nxd
        )
    )
) else (
    for /d /r "%PROJECT_ROOT%" %%d in (.vscode) do (
        if exist "%%d" (
            echo   %RED%Deleting directory:%NC% %%~nxd
            rmdir /s /q "%%d" >nul 2>&1
        )
    )
)
echo.

echo %YELLOW%Cleaning JetBrains IDE directories...%NC%
if "%DRY_RUN%"=="true" (
    for /d /r "%PROJECT_ROOT%" %%d in (.idea) do (
        if exist "%%d" (
            echo   %YELLOW%Would delete directory:%NC% %%~nxd
        )
    )
) else (
    for /d /r "%PROJECT_ROOT%" %%d in (.idea) do (
        if exist "%%d" (
            echo   %RED%Deleting directory:%NC% %%~nxd
            rmdir /s /q "%%d" >nul 2>&1
        )
    )
)
echo.

echo %BLUE%Cleaning version control artifacts...%NC%
echo.

REM Clean version control artifacts (be careful)
echo %YELLOW%Cleaning Git merge conflict backup files...%NC%
if "%DRY_RUN%"=="true" (
    for /r "%PROJECT_ROOT%" %%f in (*.orig *.rej) do (
        if exist "%%f" (
            echo   %YELLOW%Would delete:%NC% %%~nxf
        )
    )
) else (
    for /r "%PROJECT_ROOT%" %%f in (*.orig *.rej) do (
        if exist "%%f" (
            echo   %RED%Deleting:%NC% %%~nxf
            del "%%f" >nul 2>&1
        )
    )
)
echo.

REM Final summary
echo %GREEN%Cleanup complete!%NC%
echo.

if "%DRY_RUN%"=="true" (
    echo %YELLOW%This was a dry run. To actually delete files, run:%NC%
    echo %YELLOW%  cleanup.bat%NC%
) else (
    echo %GREEN%All LaTeX build files and temporary files have been removed.%NC%
)

echo.
echo %BLUE%Note: PDF files and source files (.tex, .cls, .sty) were preserved.%NC%

pause