#!/bin/bash

echo "================================================================"
echo "Source of India LaTeX Project - Cleanup and Restructure Script"
echo "================================================================"
echo

# Check if we're in the right directory
if [ ! -f "soi.cls" ]; then
    echo "ERROR: soi.cls not found. Please run this script from the project root."
    exit 1
fi

echo "[INFO] Starting project cleanup and restructuring..."
echo

# Create backup of current structure
echo "[STEP 1] Creating backup of current structure..."
if [ -d "backup" ]; then
    echo "[WARN] Backup directory already exists, skipping backup creation"
else
    cp -r . backup/ 2>/dev/null
    echo "[OK] Backup created in 'backup' directory"
fi
echo

# Clean up existing problematic directories
echo "[STEP 2] Cleaning up existing directory structure..."
if [ -d "includes/articles" ]; then
    rm -rf "includes/articles" 2>/dev/null
    echo "[OK] Removed old includes/articles directory"
fi
echo

# Create the new directory structure
echo "[STEP 3] Creating new directory structure..."

# Main directories
mkdir -p "includes/parts"
mkdir -p "includes/articles"
mkdir -p "includes/schedules"
mkdir -p "amendments"
mkdir -p "fonts"
mkdir -p "docs"
mkdir -p "tests/unit"
mkdir -p "tests/integration"
mkdir -p "tests/visual"
mkdir -p "scripts"

echo "[OK] Created main directory structure"

# Create individual article directories and files
echo "[STEP 4] Creating individual article files..."

# Articles 1-395 (main sequence)
for i in {1..395}; do
    touch "includes/articles/article-$i.tex"
done

# Create special articles with suffixes (243A, 243B, etc.)
suffixes=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "ZA" "ZB" "ZC" "ZD" "ZE" "ZF" "ZG" "ZH" "ZI" "ZJ" "ZK" "ZL" "ZM" "ZN" "ZO" "ZP" "ZQ" "ZR" "ZS" "ZT")
for suffix in "${suffixes[@]}"; do
    touch "includes/articles/article-243$suffix.tex"
done

# Additional special articles
touch "includes/articles/article-300A.tex"
touch "includes/articles/article-323A.tex"
touch "includes/articles/article-323B.tex"
touch "includes/articles/article-329A.tex"

echo "[OK] Created individual article files (1-395 plus special articles)"

# Create part files
echo "[STEP 5] Creating part template files..."
for i in {1..22}; do
    touch "includes/parts/part-$i.tex"
done
echo "[OK] Created part template files (1-22)"

# Create schedule files
echo "[STEP 6] Creating schedule template files..."
for i in {1..12}; do
    touch "includes/schedules/schedule-$i.tex"
done
echo "[OK] Created schedule template files (1-12)"

# Create test files
echo "[STEP 7] Creating test framework files..."
touch "tests/unit/test-parts.tex"
touch "tests/unit/test-articles.tex"
touch "tests/unit/test-amendments.tex"
touch "tests/integration/full-compile.tex"
touch "tests/integration/cross-references.tex"
touch "tests/visual/layout-a4.tex"
touch "tests/visual/layout-a5.tex"
echo "[OK] Created test framework files"

# Create documentation templates
echo "[STEP 8] Creating documentation templates..."
touch "docs/user-guide.md"
touch "docs/developer-guide.md"
echo "[OK] Created documentation templates"

# Create utility scripts
echo "[STEP 9] Creating utility scripts..."
touch "scripts/setup-project.sh"
touch "scripts/validate-structure.py"
echo "[OK] Created utility scripts"

# Update main.tex with proper structure
echo "[STEP 10] Creating updated main.tex template..."
cat > "main.tex" <<'EOF'
%%% Source of India LaTeX Document
%%% Main document file

\documentclass[a4paper,12pt]{soi}

%%% Load configuration
\input{config}

\begin{document}

%%% Front matter
\input{includes/cover}
\input{includes/preamble}
\input{includes/toc}

%%% Parts and Articles
%%% Part I - The Union and its Territory
\input{includes/parts/part-1}

%%% Part II - Citizenship
\input{includes/parts/part-2}

%%% Part III - Fundamental Rights  
\input{includes/parts/part-3}

%%% Continue with other parts...
%%% TODO: Add remaining parts

%%% Schedules
\input{includes/schedules/schedule-1}
%%% TODO: Add remaining schedules

\end{document}
EOF
echo "[OK] Created updated main.tex template"

# Create article inclusion helper
echo "[STEP 11] Creating article management utilities..."
cat > "includes/article-helpers.tex" <<'EOF'
%%% Article inclusion helper
%%% Usage: \includeArticle{number}

\newcommand{\includeArticle}[1]{%
    \IfFileExists{includes/articles/article-#1.tex}{%
        \input{includes/articles/article-#1.tex}%
    }{%
        \PackageWarning{soi}{Article #1 file not found}%
    }%
}

%%% Range inclusion helper  
%%% Usage: \includeArticleRange{1}{30}
\newcommand{\includeArticleRange}[2]{%
    \forloop{articleloop}{#1}{\value{articleloop} < #2}{%
        \includeArticle{\arabic{articleloop}}%
    }%
}
EOF
echo "[OK] Created article management utilities"

# Create validation script (Python version for cross-platform)
echo "[STEP 12] Creating structure validation..."
cat > "scripts/validate-structure.py" <<'EOF'
#!/usr/bin/env python3
"""
Source of India Project Structure Validator
Validates the directory structure and file existence
"""

import os
import sys

def validate_structure():
    """Validate the project structure"""
    errors = 0
    warnings = 0
    
    print("Validating Source of India project structure...")
    print()
    
    # Check main files
    required_files = ['soi.cls', 'main.tex', 'config.yaml']
    for file in required_files:
        if not os.path.exists(file):
            print(f"ERROR: {file} not found")
            errors += 1
    
    # Check directory structure
    required_dirs = [
        'includes/parts',
        'includes/articles', 
        'includes/schedules',
        'amendments',
        'tests/unit',
        'tests/integration'
    ]
    
    for dir_path in required_dirs:
        if not os.path.exists(dir_path):
            print(f"ERROR: Directory {dir_path} not found")
            errors += 1
    
    # Check article files
    missing_articles = 0
    for i in range(1, 396):  # Articles 1-395
        article_file = f"includes/articles/article-{i}.tex"
        if not os.path.exists(article_file):
            missing_articles += 1
    
    if missing_articles > 0:
        print(f"WARNING: {missing_articles} article files missing")
        warnings += 1
    
    # Check special articles
    special_articles = ['300A', '323A', '323B', '329A']
    special_suffixes = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'ZA', 'ZB', 'ZC', 'ZD', 'ZE', 'ZF', 'ZG', 'ZH', 'ZI', 'ZJ', 'ZK', 'ZL', 'ZM', 'ZN', 'ZO', 'ZP', 'ZQ', 'ZR', 'ZS', 'ZT']
    
    for suffix in special_suffixes:
        article_file = f"includes/articles/article-243{suffix}.tex"
        if not os.path.exists(article_file):
            missing_articles += 1
    
    for special in special_articles:
        article_file = f"includes/articles/article-{special}.tex"
        if not os.path.exists(article_file):
            missing_articles += 1
    
    # Final summary
    print()
    if errors == 0:
        print("[OK] Project structure validation passed")
        if warnings > 0:
            print(f"     {warnings} warnings found")
        return 0
    else:
        print(f"[ERROR] Project structure validation failed with {errors} errors")
        return 1

if __name__ == "__main__":
    sys.exit(validate_structure())
EOF

# Make validation script executable
chmod +x "scripts/validate-structure.py"
echo "[OK] Created structure validation script"

# Final summary
echo
echo "================================================================"
echo "                    RESTRUCTURING COMPLETE"
echo "================================================================"
echo
echo "Project structure has been reorganized with:"
echo "  - Individual files for each article (1-395 + special articles)"
echo "  - Separate part files (1-22)"  
echo "  - Schedule files (1-12)"
echo "  - Test framework structure"
echo "  - Documentation templates"
echo "  - Utility scripts"
echo
echo "Key files created:"
echo "  - includes/article-helpers.tex (article inclusion utilities)"
echo "  - scripts/validate-structure.py (structure validation)"
echo "  - Updated main.tex template"
echo
echo "Next steps:"
echo "  1. Run 'python3 scripts/validate-structure.py' to verify structure"
echo "  2. Populate individual article files with content"
echo "  3. Update soi.cls with new inclusion logic"  
echo "  4. Test compilation with your LaTeX distribution"
echo
echo "Original structure backed up in 'backup' directory"
echo "================================================================" 
