#!/bin/bash

# Source of India LaTeX Compilation Script
# This script compiles the Constitution document with proper cross-references

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MAIN_FILE="main.tex"
MINIMAL_FILE="examples/minimal.tex"
ENGINE="pdflatex"  # Can be changed to xelatex or lualatex
CLEANUP=true

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if LaTeX is installed
check_latex() {
    if ! command -v $ENGINE &> /dev/null; then
        print_error "$ENGINE not found. Please install a LaTeX distribution."
        exit 1
    fi
    print_info "Using $ENGINE engine"
}

# Compile document
compile_document() {
    local file=$1
    local basename=$(basename "$file" .tex)
    
    print_info "Compiling $file..."
    
    # First pass
    print_info "First pass..."
    $ENGINE -interaction=nonstopmode "$file" > /dev/null 2>&1 || {
        print_error "First compilation pass failed for $file"
        print_info "Check ${basename}.log for details"
        return 1
    }
    
    # Second pass (for cross-references and footnotes)
    print_info "Second pass..."
    $ENGINE -interaction=nonstopmode "$file" > /dev/null 2>&1 || {
        print_error "Second compilation pass failed for $file"
        print_info "Check ${basename}.log for details"
        return 1
    }
    
    print_success "Successfully compiled $file -> ${basename}.pdf"
}

# Clean auxiliary files
cleanup_files() {
    local pattern=$1
    print_info "Cleaning auxiliary files..."
    
    # Remove common auxiliary files
    rm -f "${pattern}".{aux,log,toc,out,fdb_latexmk,fls,synctex.gz}
    rm -f *.aux *.log *.toc *.out *.fdb_latexmk *.fls *.synctex.gz 2>/dev/null || true
    
    print_info "Cleanup completed"
}

# Show usage
show_usage() {
    echo "Usage: $0 [options] [file]"
    echo ""
    echo "Options:"
    echo "  -e, --engine ENGINE    Use specified LaTeX engine (pdflatex, xelatex, lualatex)"
    echo "  -m, --minimal         Compile minimal example instead of main document"
    echo "  -c, --clean           Clean auxiliary files only (no compilation)"
    echo "  -k, --keep            Keep auxiliary files after compilation"
    echo "  -h, --help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    Compile main.tex with pdflatex"
    echo "  $0 -e xelatex         Compile with XeLaTeX"
    echo "  $0 -m                 Compile minimal example"
    echo "  $0 custom.tex         Compile custom.tex"
}

# Parse command line arguments
COMPILE_FILE="$MAIN_FILE"

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--engine)
            ENGINE="$2"
            shift 2
            ;;
        -m|--minimal)
            COMPILE_FILE="$MINIMAL_FILE"
            shift
            ;;
        -c|--clean)
            cleanup_files "*"
            exit 0
            ;;
        -k|--keep)
            CLEANUP=false
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        -*)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            COMPILE_FILE="$1"
            shift
            ;;
    esac
done

# Main execution
print_info "Source of India LaTeX Compilation Script"
print_info "========================================"

# Check prerequisites
check_latex

# Check if file exists
if [ ! -f "$COMPILE_FILE" ]; then
    print_error "File not found: $COMPILE_FILE"
    exit 1
fi

# Compile the document
if compile_document "$COMPILE_FILE"; then
    # Optional cleanup
    if [ "$CLEANUP" = true ]; then
        cleanup_files "$(basename "$COMPILE_FILE" .tex)"
    fi
    
    print_success "Compilation completed successfully!"
    print_info "Output: $(basename "$COMPILE_FILE" .tex).pdf"
else
    print_error "Compilation failed!"
    exit 1
fi