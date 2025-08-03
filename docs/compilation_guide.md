# Constitution of India LaTeX Document - Compilation Guide

## Overview
This project now uses the enhanced Source of India LaTeX Class v1.1 with all critical fixes implemented. The main document (`main.tex`) is the primary working document for the complete Constitution of India.

## Quick Start

### Prerequisites
- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Required packages: geometry, xparse, fancyhdr, array, longtable, booktabs, footnote, hyperref, etc.

### Basic Compilation

#### Using Command Line
```bash
# Basic compilation (run twice for cross-references)
pdflatex main.tex
pdflatex main.tex

# Or use the enhanced script (Unix/Linux/macOS)
./tools/compile_fixed.sh

# Windows users
tools\compile_fixed.bat
```

#### Using Enhanced Scripts
```bash
# Unix/Linux/macOS - with automatic PDF opening
./tools/compile_fixed.sh --open

# Windows - with automatic PDF opening  
tools\compile_fixed.bat --open
```

## Document Structure

### Main Files
- **main.tex** - Primary working document (this is what you compile)
- **sample.tex** - Demonstration document showing fixes
- **soi.cls** - Enhanced LaTeX class (v1.1) with all fixes
- **config.tex** - Configuration file with enhanced settings

### Content Structure (Modular)
```
content/
├── preamble.tex          # Constitution preamble
├── parts/
│   ├── part_i.tex       # The Union and Its Territory
│   ├── part_ii.tex      # Citizenship  
│   ├── part_iii.tex     # Fundamental Rights (with fixes)
│   └── ...              # Additional parts (to be added)
├── articles/
│   ├── article_1.tex    # Individual article files
│   ├── article_12.tex   # Fixed amendment syntax
│   ├── article_13.tex   # Fixed amendment syntax
│   └── ...              # All article files
└── schedules/
    ├── schedule_i.tex   # The States
    └── ...              # Additional schedules
```

## Key Improvements in v1.1

### Fixed Amendment System
- **Before**: `[citation]³` with footnote `³Inserted: actual text`
- **After**: `³[actual text]` with footnote `³Inserted by: citation`

### Enhanced Layout
- Two-sided document layout with binding offset
- Article names on outer margins (opposite to binding)
- Constitutional section headings properly sized and positioned
- Enhanced footnote spacing and formatting

### Better Typography
- Section headings like "Right to Equality" are appropriately sized
- Improved spacing around footnote separator lines
- Enhanced page break management to keep related content together

## Document Options

### Class Options
```latex
\documentclass[a4paper,12pt,showamendments,twoside]{soi}
```

Available options:
- `showamendments` / `hideamendments` - Control amendment footnote display
- `twoside` - Enable two-sided layout (recommended)
- `showomitted` / `hideomitted` - Control display of omitted provisions
- `draft` / `final` - Draft mode shows additional debug information

### Configuration Control
In `config.tex`, you can control compilation:
- `\compileparttrue` / `\compilepartfalse` - Include/exclude parts
- `\compileschedulestrue` / `\compileschedulesfalse` - Include/exclude schedules

## Troubleshooting

### Common Issues
1. **"File not found" errors**: Ensure all content files exist in correct directories
2. **Amendment display issues**: Check that article files use the new syntax
3. **Missing footnotes**: Verify `showamendments` option is enabled
4. **Layout problems**: Ensure `twoside` option is specified

### Compilation Errors
If compilation fails:
1. Check the `.log` file for specific errors
2. Ensure all required LaTeX packages are installed
3. Verify that individual article files use correct amendment syntax
4. Make sure `config.tex` exists and is properly formatted

### Enhancement Verification
To verify the fixes are working:
1. Look for properly positioned amendment footnotes
2. Check that section headings stay with their articles
3. Verify two-sided layout in PDF viewer
4. Confirm footnote spacing improvements

## Contributing

### Adding New Content
1. Create article files in `content/articles/` using the format:
   ```latex
   \DeclareArticle{number}{suffix}{category}
   \Article{Title}{Content with \Clause{} and \SubClause{}}
   ```

2. Add amendments using corrected syntax:
   ```latex
   \Inserted{amendment text}{citation}
   \Substituted{new text}{old text}{citation}  
   \InsertedClause{text}{citation}
   ```

3. Include new articles in appropriate part files

### Section Headings
Use the new constitutional section command:
```latex
\ConstitutionalSection{Right to Equality}
```

## File Cleanup
Remove auxiliary files after compilation:
```bash
# Unix/Linux/macOS
./tools/cleanup.sh

# Windows
tools\cleanup.bat
```

## Current Status
- **Parts I-III**: Implemented with fixed amendment system
- **Remaining Parts**: Templates ready, content to be added
- **Schedules**: First Schedule implemented, others to be added
- **Amendment System**: Fully corrected and operational
- **Layout**: Two-sided with proper binding and typography

This document system now provides a professional, legally accurate representation of the Constitution of India with proper amendment tracking and enhanced typography.