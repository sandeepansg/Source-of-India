# Compilation Guide - SoI LaTeX Class

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Installation](#installation)
3. [Basic Compilation](#basic-compilation)
4. [Advanced Compilation Options](#advanced-compilation-options)
5. [Engine-Specific Instructions](#engine-specific-instructions)
6. [Build Scripts](#build-scripts)
7. [Troubleshooting Compilation](#troubleshooting-compilation)
8. [Performance Optimization](#performance-optimization)

---

## System Requirements

### LaTeX Distribution

**Recommended:**
- TeX Live 2020 or later
- MiKTeX 2.9 or later (Windows)
- MacTeX 2020 or later (macOS)

**Minimum:**
- LaTeX2e (2020/10/01 release or later)
- pdfTeX 1.40.20 or equivalent

### System Resources

| Document Size | RAM Required | Disk Space | Compilation Time |
|---------------|--------------|------------|------------------|
| Sample (10 articles) | 256 MB | 50 MB | 30 seconds |
| Partial (100 articles) | 512 MB | 200 MB | 2 minutes |
| Complete Constitution | 1 GB | 500 MB | 5-10 minutes |

### Required Packages

Core packages automatically loaded by the class:
```
geometry, xparse, fancyhdr, needspace, array, longtable, 
booktabs, footnote, hyperref, xstring, etoolbox, afterpage, 
changepage, calc
```

**Font packages (engine-dependent):**
- pdfLaTeX: `fontenc`, `inputenc`, `lmodern`
- XeLaTeX/LuaLaTeX: `fontspec`, `luatextra` (LuaLaTeX only)

---

## Installation

### Method 1: Direct Use (Recommended)

1. **Download the class file:**
   ```bash
   # Place soi.cls in your document directory
   source-of-india/
   ├── soi.cls
   ├── main.tex
   └── config.tex
   ```

2. **No installation required** - LaTeX will find the class file in the same directory.

### Method 2: System Installation

1. **Find your local texmf directory:**
   ```bash
   kpsewhich -var-value TEXMFHOME
   ```

2. **Create class directory:**
   ```bash
   # Example path (adjust for your system)
   mkdir -p ~/texmf/tex/latex/soi/
   ```

3. **Copy class file:**
   ```bash
   cp soi.cls ~/texmf/tex/latex/soi/
   ```

4. **Update package database:**
   ```bash
   texhash ~/texmf
   ```

### Method 3: Project-Specific Setup

For collaborative projects:
```bash
# Create symlinks (Unix/Linux/macOS)
ln -s /path/to/soi.cls ./soi.cls

# Or copy for Windows
copy "C:\path\to\soi.cls" ".\soi.cls"
```

---

## Basic Compilation

### Single Document Compilation

**Command line:**
```bash
pdflatex main.tex
```

**For documents with cross-references:**
```bash
pdflatex main.tex
pdflatex main.tex  # Second run for references
```

**For documents with bibliography:**
```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

### IDE Integration

#### TeXShop (macOS)
1. Set engine to pdfLaTeX
2. Use standard compile button
3. For multiple runs: Typeset → Run Multiple Times

#### TeXworks (Cross-platform)
1. Select pdfLaTeX from dropdown
2. Click green arrow to compile
3. Use Scripts → Multiple Runs for complex documents

#### TeXstudio (Cross-platform)
1. Configure: Options → Configure → Build → Default Compiler: pdfLaTeX
2. Use F5 for single compilation
3. Use F1 for complete build chain

#### Overleaf (Online)
1. Upload soi.cls to project root
2. Set compiler to pdfLaTeX (recommended)
3. Auto-compilation on save

---

## Advanced Compilation Options

### Class Options During Compilation

```latex
% Different compilation scenarios
\documentclass[draft,showamendments]{soi}      % Development
\documentclass[final,hideamendments]{soi}      % Production
\documentclass[showomitted,pagefootnotes]{soi} % Research edition
```

### Conditional Compilation

```latex
% In main.tex or config.tex
\newif\ifcompletedoc\completedocfalse

% Compile only specific parts
\ifcompletedoc
    \input{content/parts/part_i}
    \input{content/parts/part_ii}
    % ... all parts
\else
    \input{content/parts/part_iii}  % Only Fundamental Rights
\fi
```

### Memory Management

For large documents:
```latex
% In preamble
\RequirePackage[active,tightpage]{preview}  % Reduce memory usage
\def\pgfsysdriver{pgfsys-pdftex.def}        % Optimize graphics
```

### Output Customization

```latex
% Different output formats
\documentclass[a4paper]{soi}     % A4 (default)
\documentclass[a5paper]{soi}     % Compact version
\documentclass[letterpaper]{soi} % US Letter
```

---

## Engine-Specific Instructions

### pdfLaTeX (Recommended)

**Advantages:**
- Fastest compilation
- Best package compatibility
- Stable footnote handling

**Usage:**
```bash
pdflatex -interaction=nonstopmode main.tex
```

**Font configuration:**
```latex
% Automatic - no user action required
% Class loads: fontenc, inputenc, lmodern
```

### XeLaTeX

**Advantages:**
- Better font support
- Unicode handling
- System font access

**Usage:**
```bash
xelatex main.tex
```

**Font configuration:**
```latex
% Automatic with fallback
% Tries: Libertinus Serif → Latin Modern Roman
```

**Custom fonts:**
```latex
% In config.tex
\ifxetex
    \setmainfont{Times New Roman}
    \setsansfont{Arial}
\fi
```

### LuaLaTeX

**Advantages:**
- Advanced typography features
- Lua scripting capabilities
- Better memory management

**Usage:**
```bash
lualatex main.tex
```

**Special features:**
```latex
% Access to Lua functions
\directlua{
    -- Custom Lua code for processing
    tex.print("Constitutional text processing")
}
```

### Engine Selection Guidelines

| Use Case | Recommended Engine | Reason |
|----------|-------------------|---------|
| Standard documents | pdfLaTeX | Speed and compatibility |
| Complex fonts | XeLaTeX | Font flexibility |
| Large documents | LuaLaTeX | Memory efficiency |
| Simple documents | pdfLaTeX | Simplicity |

---

## Build Scripts

### Basic Build Script (Bash/Linux/macOS)

Create `tools/compile.sh`:
```bash
#!/bin/bash
# Basic compilation script

echo "Compiling Constitution of India..."

# Clean previous build
rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk

# First compilation
pdflatex -interaction=nonstopmode main.tex

# Second compilation for cross-references
pdflatex -interaction=nonstopmode main.tex

echo "Compilation complete: main.pdf"
```

### Advanced Build Script

Create `tools/build.sh`:
```bash
#!/bin/bash
# Advanced build script with error handling

set -e  # Exit on error

PROJECT_NAME="main"
BUILD_DIR="build"
ENGINES=("pdflatex" "xelatex" "lualatex")

# Create build directory
mkdir -p "$BUILD_DIR"

# Function to compile with specific engine
compile_with_engine() {
    local engine=$1
    echo "Compiling with $engine..."
    
    $engine -output-directory="$BUILD_DIR" \
            -interaction=nonstopmode \
            "$PROJECT_NAME.tex"
    
    # Second run for references
    $engine -output-directory="$BUILD_DIR" \
            -interaction=nonstopmode \
            "$PROJECT_NAME.tex"
    
    # Rename output
    mv "$BUILD_DIR/$PROJECT_NAME.pdf" "$BUILD_DIR/${PROJECT_NAME}_${engine}.pdf"
    echo "Created: $BUILD_DIR/${PROJECT_NAME}_${engine}.pdf"
}

# Compile with each engine
for engine in "${ENGINES[@]}"; do
    if command -v "$engine" &> /dev/null; then
        compile_with_engine "$engine"
    else
        echo "Warning: $engine not found, skipping..."
    fi
done

echo "Build complete!"
```

### Windows Batch Script

Create `tools/compile.bat`:
```batch
@echo off
echo Compiling Constitution of India...

:: Clean previous build
del /q *.aux *.log *.toc *.out 2>nul

:: First compilation
pdflatex -interaction=nonstopmode main.tex
if errorlevel 1 (
    echo Compilation failed!
    pause
    exit /b 1
)

:: Second compilation
pdflatex -interaction=nonstopmode main.tex
if errorlevel 1 (
    echo Second compilation failed!
    pause
    exit /b 1
)

echo Compilation complete: main.pdf
pause
```

### Makefile

Create `Makefile`:
```makefile
# Makefile for SoI LaTeX class
PROJECT = main
ENGINE = pdflatex
BUILD_DIR = build

.PHONY: all clean pdf draft final

all: pdf

pdf:
	$(ENGINE) $(PROJECT).tex
	$(ENGINE) $(PROJECT).tex

draft:
	sed -i.bak 's/\\documentclass\[/\\documentclass[draft,/' $(PROJECT).tex
	$(MAKE) pdf
	mv $(PROJECT).tex.bak $(PROJECT).tex

final:
	sed -i.bak 's/\\documentclass\[draft,/\\documentclass[/' $(PROJECT).tex
	$(MAKE) pdf
	mv $(PROJECT).tex.bak $(PROJECT).tex

clean:
	rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk
	rm -f $(BUILD_DIR)/*

install:
	mkdir -p ~/texmf/tex/latex/soi/
	cp soi.cls ~/texmf/tex/latex/soi/
	texhash ~/texmf

validate:
	lacheck $(PROJECT).tex
	chktex $(PROJECT).tex
```

---

## Troubleshooting Compilation

### Common Error Messages

#### "File `soi.cls' not found"
**Cause:** Class file not in LaTeX path
**Solution:**
```bash
# Place soi.cls in document directory, or
cp soi.cls ~/texmf/tex/latex/soi/
texhash ~/texmf
```

#### "Package xparse Error: Unknown document command"
**Cause:** Outdated LaTeX distribution
**Solution:**
```bash
# Update LaTeX distribution
# Or use compatibility mode in config.tex
\RequirePackage{xparse}[2020/03/03]
```

#### "Undefined control sequence \DeclareArticle"
**Cause:** Class not properly loaded
**Solution:**
```latex
% Check document class declaration
\documentclass{soi}  % Correct
% Not: \usepackage{soi}
```

#### "Too many unprocessed floats"
**Cause:** Too many footnotes or figures
**Solution:**
```latex
\documentclass[pagefootnotes]{soi}
% Or in preamble:
\RequirePackage{morefloats}
```

### Memory Issues

#### "TeX capacity exceeded"
**Solutions:**
```bash
# Increase memory limits (texmf.cnf)
main_memory = 5000000
extra_mem_bot = 5000000

# Or use LuaLaTeX
lualatex main.tex
```

#### "Out of memory"
**Solutions:**
1. Use conditional compilation
2. Split document into smaller parts
3. Reduce amendment detail level
4. Use external memory management

### Font Issues

#### "Font not found" (XeLaTeX/LuaLaTeX)
**Solution:**
```latex
% In config.tex - specify fallback fonts
\ifxetex
    \IfFontExistsTF{Libertinus Serif}{
        \setmainfont{Libertinus Serif}
    }{
        \setmainfont{Latin Modern Roman}
    }
\fi
```

### Cross-Reference Issues

#### "Reference undefined"
**Solution:**
```bash
# Always run twice for cross-references
pdflatex main.tex
pdflatex main.tex

# Or use latexmk for automatic handling
latexmk -pdf main.tex
```

---

## Performance Optimization

### Compilation Speed

1. **Use draft mode during development:**
   ```latex
   \documentclass[draft]{soi}
   ```

2. **Conditional compilation:**
   ```latex
   % Compile only changed sections
   \includeonly{content/parts/part_iii}
   ```

3. **Optimize images:**
   ```latex
   % Use appropriate image formats
   \includegraphics[width=\textwidth]{image.pdf}  % Vector
   \includegraphics[width=\textwidth]{photo.jpg}  % Raster
   ```

### Memory Optimization

1. **Use efficient packages:**
   ```latex
   \RequirePackage[final]{microtype}  % Better typography
   \RequirePackage{etoolbox}          % Efficient programming
   ```

2. **Optimize footnotes:**
   ```latex
   \documentclass[pagefootnotes]{soi}  % Reset per page
   ```

3. **Reduce float memory:**
   ```latex
   \setcounter{totalnumber}{50}        % More floats per page
   \setcounter{topnumber}{50}
   \setcounter{bottomnumber}{50}
   ```

### Automated Optimization

Create `tools/optimize.sh`:
```bash
#!/bin/bash
# Optimization script

echo "Optimizing LaTeX compilation..."

# Compress images
find . -name "*.png" -exec pngcrush -ow {} \;
find . -name "*.jpg" -exec jpegoptim --strip-all {} \;

# Remove unnecessary files
find . -name "*.aux" -delete
find . -name "*.log" -delete
find . -name "*.toc" -delete

# Optimize PDF
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET \
   -dBATCH -sOutputFile=main_optimized.pdf main.pdf

echo "Optimization complete!"
```

### Continuous Integration

For automated builds (GitHub Actions example):
```yaml
# .github/workflows/compile.yml
name: Compile LaTeX
on: [push, pull_request]
jobs:
  compile:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Compile LaTeX
      uses: xu-cheng/latex-action@v2
      with:
        root_file: main.tex
        compiler: pdflatex
        args: -interaction=nonstopmode
    - name: Upload PDF
      uses: actions/upload-artifact@v2
      with:
        name: constitution-pdf
        path: main.pdf
```

This compilation guide ensures successful building of constitutional documents across different platforms and use cases.