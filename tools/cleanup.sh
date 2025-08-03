#!/bin/bash
# Source of India LaTeX Project Cleanup Script
# Removes all LaTeX build files throughout the project directory structure
# Usage: ./cleanup.sh [--dry-run]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if dry-run mode
DRY_RUN=false
if [ "$1" = "--dry-run" ] || [ "$1" = "-n" ]; then
    DRY_RUN=true
    echo -e "${YELLOW}DRY RUN MODE - No files will actually be deleted${NC}"
    echo
fi

# Get the script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}Source of India LaTeX Project Cleanup${NC}"
echo -e "${BLUE}======================================${NC}"
echo "Project root: $PROJECT_ROOT"
echo

# Define file extensions to clean
EXTENSIONS=(
    "aux"      # Auxiliary files
    "log"      # Log files
    "toc"      # Table of contents
    "out"      # Hyperref output
    "fls"      # File list
    "fdb_latexmk"  # Latexmk database
    "synctex.gz"   # SyncTeX files
    "nav"      # Beamer navigation
    "snm"      # Beamer slide notes
    "vrb"      # Beamer verbatim
    "bbl"      # Bibliography files
    "blg"      # Bibliography log
    "idx"      # Index files
    "ind"      # Index output
    "ilg"      # Index log
    "lot"      # List of tables
    "lof"      # List of figures
    "glo"      # Glossary
    "gls"      # Glossary output
    "glg"      # Glossary log
    "xdy"      # Xindy style files
    "acn"      # Acronym files
    "acr"      # Acronym output
    "alg"      # Glossary algorithm files
    "glsdefs"  # Glossary definitions
    "run.xml"  # Biber run file
    "bcf"      # Biber control file
    "figlist"  # Figure list
    "makeidx"  # MakeIndex files
    "pyg"      # Pygments files
    "pythontex" # PythonTeX files
    "listing"  # Code listing files
    "lol"      # List of listings
    "dpth"     # Depth files
    "md5"      # MD5 checksum files
    "auxlock"  # Auxiliary lock files
    "backup"   # Backup files
    "bak"      # Backup files
    "sav"      # Save files
    "tmp"      # Temporary files
    "temp"     # Temporary files
    "fot"      # Font files
    "cb"       # Continuous build files
    "cb2"      # Continuous build files
    "lb"       # Label files
    "gz"       # Compressed files (be careful with this)
    "ps"       # PostScript files (generated)
    "dvi"      # DVI files
    "xcp"      # External files
    "upa"      # Unicode pattern files
    "upb"      # Unicode pattern files
    "fff"      # Font files
    "ttt"      # Font files
    "wrt"      # Write files
    "cut"      # Cut files
    "cutt"     # Cut files
    "spl"      # Spell check files
    "ent"      # Entity files
    "lox"      # List of examples
    "mw"       # MakeIndex work files
    "nlg"      # Nomenclature log
    "nlo"      # Nomenclature output
    "nls"      # Nomenclature style
    "ptc"      # Part table of contents
    "slf"      # Section list file
    "slt"      # Section list temporary
    "stc"      # Section table of contents
)

# Function to remove files with given pattern
cleanup_files() {
    local pattern="$1"
    local description="$2"
    
    echo -e "${YELLOW}Cleaning $description...${NC}"
    
    # Use find to locate files recursively
    found_files=$(find "$PROJECT_ROOT" -name "$pattern" -type f 2>/dev/null || true)
    
    if [ -n "$found_files" ]; then
        echo "$found_files" | while IFS= read -r file; do
            if [ "$DRY_RUN" = true ]; then
                echo -e "  ${YELLOW}Would delete:${NC} ${file#$PROJECT_ROOT/}"
            else
                echo -e "  ${RED}Deleting:${NC} ${file#$PROJECT_ROOT/}"
                rm -f "$file"
            fi
        done
    else
        echo -e "  ${GREEN}No $description found${NC}"
    fi
    echo
}

# Function to remove directories with given pattern
cleanup_directories() {
    local pattern="$1"
    local description="$2"
    
    echo -e "${YELLOW}Cleaning $description...${NC}"
    
    # Use find to locate directories recursively
    found_dirs=$(find "$PROJECT_ROOT" -name "$pattern" -type d 2>/dev/null || true)
    
    if [ -n "$found_dirs" ]; then
        echo "$found_dirs" | while IFS= read -r dir; do
            if [ "$DRY_RUN" = true ]; then
                echo -e "  ${YELLOW}Would delete directory:${NC} ${dir#$PROJECT_ROOT/}"
            else
                echo -e "  ${RED}Deleting directory:${NC} ${dir#$PROJECT_ROOT/}"
                rm -rf "$dir"
            fi
        done
    else
        echo -e "  ${GREEN}No $description found${NC}"
    fi
    echo
}

# Clean LaTeX build files by extension
echo -e "${BLUE}Cleaning LaTeX build files...${NC}"
echo

for ext in "${EXTENSIONS[@]}"; do
    cleanup_files "*.${ext}" "${ext} files"
done

# Clean specific LaTeX directories
cleanup_directories "_minted-*" "Minted cache directories"
cleanup_directories ".texpadtmp" "TeXPad temporary directories"
cleanup_directories "auto" "AUCTeX auto directories"

# Clean OS-specific files
echo -e "${BLUE}Cleaning OS-specific files...${NC}"
echo

# macOS
cleanup_files ".DS_Store" "macOS .DS_Store files"
cleanup_files "._*" "macOS resource fork files"

# Windows
cleanup_files "Thumbs.db" "Windows thumbnail cache files"
cleanup_files "Desktop.ini" "Windows desktop configuration files"

# Linux
cleanup_files ".directory" "Linux directory files"

# Clean editor temporary files
echo -e "${BLUE}Cleaning editor temporary files...${NC}"
echo

# Vim
cleanup_files "*.swp" "Vim swap files"
cleanup_files "*.swo" "Vim swap files"
cleanup_files "*~" "Vim backup files"

# Emacs
cleanup_files "*~" "Emacs backup files"
cleanup_files "#*#" "Emacs autosave files"
cleanup_files ".#*" "Emacs lock files"

# Visual Studio Code
cleanup_directories ".vscode" "VS Code configuration directories"

# JetBrains IDEs
cleanup_directories ".idea" "JetBrains IDE directories"

# Clean version control artifacts (be careful)
echo -e "${BLUE}Cleaning version control artifacts...${NC}"
echo

# Git (only clean temporary files, not the .git directory itself)
cleanup_files "*.orig" "Git merge conflict backup files"
cleanup_files "*.rej" "Git patch rejection files"

# Final summary
echo -e "${GREEN}Cleanup complete!${NC}"

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}This was a dry run. To actually delete files, run:${NC}"
    echo -e "${YELLOW}  ./cleanup.sh${NC}"
else
    echo -e "${GREEN}All LaTeX build files and temporary files have been removed.${NC}"
fi

echo
echo -e "${BLUE}Note: PDF files and source files (.tex, .cls, .sty) were preserved.${NC}"