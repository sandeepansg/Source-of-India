 
# Developer Guide - Source of India LaTeX Class

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Class Structure](#class-structure)
4. [Development Environment](#development-environment)
5. [File Organization](#file-organization)
6. [Core Components](#core-components)
7. [Amendment System](#amendment-system)
8. [Testing Framework](#testing-framework)
9. [Build System](#build-system)
10. [Contributing Guidelines](#contributing-guidelines)
11. [Technical Specifications](#technical-specifications)

## Project Overview

The Source of India (SoI) LaTeX class is a specialized document class designed for typesetting the Constitution of India with proper formatting, amendment tracking, and cross-referencing capabilities. The project aims to provide a comprehensive, maintainable, and legally accurate representation of India's constitutional text.

### Key Features

- **Structured Document Class**: Custom LaTeX class (`soi.cls`) with constitutional-specific commands
- **Amendment Tracking**: Complete amendment history with footnote support
- **Multi-format Support**: Compatible with pdfLaTeX, XeLaTeX, and LuaLaTeX
- **Modular Architecture**: Separate files for each article, part, and schedule
- **Automated Testing**: Unit and integration tests for document integrity
- **Cross-referencing**: Automatic generation of internal references

## Architecture

### Document Structure Hierarchy

```
Constitution
├── Preamble
├── Parts (I-XXII)
│   ├── Chapters (optional)
│   └── Articles (1-395+)
│       ├── Clauses
│       ├── Sub-clauses
│       └── Sub-sub-clauses
└── Schedules (I-XII)
```

### File Structure

```
project/
├── soi.cls                    # Main LaTeX class file
├── main.tex                   # Document entry point
├── config.yaml                # Configuration settings
├── amendments/
│   ├── changes.yaml           # Amendment database
│   └── footnotes.tex          # Amendment footnotes
├── includes/
│   ├── articles/              # Individual article files
│   ├── parts/                 # Part division files
│   ├── schedules/             # Schedule files
│   ├── article-helpers.tex    # Helper macros
│   ├── article-mapping.tex    # Article mapping utilities
│   ├── cover.tex              # Cover pages
│   ├── preamble.tex           # Constitutional preamble
│   └── toc.tex                # Table of contents
├── scripts/                   # Build and validation scripts
├── tests/                     # Test suite
├── docs/                      # Documentation
└── output/                    # Generated PDFs
```

## Class Structure

### Core Class Design

The `soi.cls` file implements a specialized document class that extends LaTeX's `article` class with constitutional-specific functionality:

#### Class Options

```latex
% Paper size
\DeclareOption{a4paper}{\@afoursizepapertrue}
\DeclareOption{a5paper}{\@afivesizepapertrue}

% Font size
\DeclareOption{10pt}{\@tenpointsizetrue}
\DeclareOption{11pt}{\@elevenpointsizetrue}
\DeclareOption{12pt}{\@twelvepointsizetrue}

% Amendment display
\DeclareOption{hideamendments}{\@showamendmentsfalse}
\DeclareOption{showamendments}{\@showamendmentstrue}

% Draft mode
\DeclareOption{draft}{\@draftmodetrue}
\DeclareOption{final}{\@draftmodefalse}
```

#### Font Configuration

The class supports multiple TeX engines with automatic font selection:

```latex
\ifXeTeX
    \RequirePackage{fontspec}
    \setmainlang{english}
    \IfFontExistsTF{Libertinus Serif}{
        \setmainfont{Libertinus Serif}
    }{
        \setmainfont{Latin Modern Roman}
    }
\else\ifLuaTeX
    % Similar LuaTeX configuration
\else
    % pdfLaTeX fallback
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{lmodern}
\fi\fi
```

### Document Structure Commands

#### Part Command
```latex
\newcommand{\Part}[2]{%
    \addtocounter{partcounter}{1}%
    \setcounter{chaptercounter}{0}%
    \renewcommand{\currentpart}{Part \Roman{partcounter}: #2}%
    \soipart{\Roman{partcounter}}{#2}%
    \addcontentsline{toc}{part}{Part \Roman{partcounter}: #2}%
}
```

#### Article Command
```latex
\newcommand{\Article}[3]{%
    \renewcommand{\currentarticle}{Article #1}%
    \soiarticle{#1}{#2}{#3}%
    \addcontentsline{toc}{section}{Article #1: #2}%
}
```

#### Clause System
```latex
\newcommand{\Clause}[1]{%
    \addtocounter{clausecounter}{1}%
    \par\vspace{0.5em}%
    {\fontsize{10}{13}\selectfont \theclausecounter\enskip #1\par}%
}
```

## Development Environment

### Prerequisites

- **TeX Distribution**: TeX Live 2020+ or MiKTeX 2.9+
- **Python**: 3.7+ (for build scripts)
- **Git**: For version control
- **Make**: For build automation (optional)

### Required LaTeX Packages

The class automatically loads these packages:

```latex
\RequirePackage{iftex}        % Engine detection
\RequirePackage{etoolbox}     % Advanced macros
\RequirePackage{xstring}      % String manipulation
\RequirePackage{needspace}    % Page break control
\RequirePackage{fancyhdr}     % Headers and footers
\RequirePackage{geometry}     % Page layout
\RequirePackage{titletoc}     % Table of contents
\RequirePackage{hyperref}     % Cross-references
\RequirePackage{forloop}      # Loop constructs
```

### Font Requirements

#### Primary Fonts (XeLaTeX/LuaLaTeX)
- **Libertinus Serif**: Main text font
- **Libertinus Sans**: Sans serif font

#### Fallback Fonts (All engines)
- **Latin Modern Roman**: Default serif
- **Latin Modern Sans**: Default sans serif

## File Organization

### Article Files

Each article is stored in a separate file following the naming convention:
```
includes/articles/article-{number}.tex
```

Examples:
- `article-1.tex` - Article 1
- `article-21A.tex` - Article 21A (inserted by amendment)
- `article-31A.tex` - Article 31A (complex numbering)

### Part Files

Part divisions are organized as:
```
includes/parts/part-{number}.tex
```

Each part file includes:
- Part title and description
- Chapter divisions (if applicable)
- Article inclusions

### Schedule Files

Schedules follow similar organization:
```
includes/schedules/schedule-{number}.tex
```

## Core Components

### Counter System

The class implements a comprehensive counter system:

```latex
\newcounter{partcounter}
\newcounter{chaptercounter}[partcounter]
\newcounter{articlecounter}
\newcounter{clausecounter}[articlecounter]
\newcounter{subclausecounter}[clausecounter]
\newcounter{subsubclausecounter}[subclausecounter]
\newcounter{schedulecounter}
\newcounter{amendmentcounter}
```

### Typography Controls

#### Font Size Hierarchy
- **Part Titles**: 18pt bold
- **Chapter Titles**: 14pt bold
- **Article Numbers**: 11pt bold
- **Article Text**: 10pt regular
- **Clause Text**: 10pt regular

#### Spacing Controls
```latex
\needspace{8\baselineskip}    % Article spacing
\needspace{6\baselineskip}    % Chapter spacing
\needspace{4\baselineskip}    % Group spacing
```

### Page Layout System

#### A4 Paper Configuration
```latex
\geometry{
    a4paper,
    top=2.5cm,
    bottom=2cm,
    left=2.5cm,
    right=2cm,
    headheight=1cm,
    headsep=0.5cm,
    footskip=1cm
}
```

#### A5 Paper Configuration
```latex
\geometry{
    a5paper,
    top=2cm,
    bottom=1.5cm,
    left=2cm,
    right=1.5cm,
    headheight=0.8cm,
    headsep=0.4cm,
    footskip=0.8cm
}
```

## Amendment System

### Amendment Database Structure

The amendment system uses YAML for data storage (`amendments/changes.yaml`):

```yaml
amendments:
  - id: 1
    act: "Constitution (First Amendment) Act, 1951"
    date: "1951-06-18"
    articles:
      - number: "31A"
        title: "Saving of laws providing for acquisition of estates, etc."
        action: "insert"
        text: "Article text..."
        footnote: "Inserted by the Constitution (First Amendment) Act, 1951, s. 4"
```

### Amendment Actions

- **insert**: Add new article
- **substitute**: Replace existing article
- **omit**: Remove article
- **modify**: Change specific text

### Amendment Display Commands

```latex
% Amendment footnote
\newcommand{\AmendmentFootnote}[2]{%
    \if@showamendments%
        \footnote{#2}%
    \fi%
}

% Inline amendment marker
\newcommand{\AmendText}[2]{%
    \if@showamendments%
        \textit{[#1]}\footnote{#2}%
    \else%
        #1%
    \fi%
}
```

### Complex Article Numbering

The system handles complex constitutional numbering:

- Simple numbers: 1, 2, 3...
- Letter suffixes: 21A, 31A, 371A...
- Multiple letters: 239AA, 239AB...
- Special cases: 35A (Jammu & Kashmir)

## Testing Framework

### Test Structure

```
tests/
├── unit/                    # Unit tests
│   ├── test-articles.tex   # Article command tests
│   ├── test-parts.tex      # Part command tests
│   └── test-amendments.tex # Amendment system tests
├── integration/             # Integration tests
│   ├── full-compile.tex    # Complete document compilation
│   └── cross-references.tex # Cross-reference validation
└── visual/                  # Visual regression tests
    ├── layout-a4.tex       # A4 layout verification
    └── layout-a5.tex       # A5 layout verification
```

### Test Execution

Tests can be run using the provided scripts:

```bash
# Run all tests
./scripts/run-tests.sh

# Run specific test category
./scripts/run-tests.sh unit
./scripts/run-tests.sh integration
./scripts/run-tests.sh visual
```

### Test Validation

Each test generates:
- PDF output for visual inspection
- Log files for error checking
- Metrics for performance monitoring

## Build System

### Build Scripts

#### Primary Build Script
```bash
./scripts/setup-or-validate-project.sh
```

This script:
1. Validates LaTeX installation
2. Checks required packages
3. Compiles test documents
4. Generates output PDFs

#### Python Build Script
```python
# scripts/setup-or-validate-project.py
# Provides cross-platform build support
```

#### Windows Batch Script
```batch
# scripts/setup-or-validate-project.cmd
# Windows-specific build commands
```

### Configuration Management

The `config.yaml` file controls build behavior:

```yaml
# Compilation options
compiler: xelatex
font: libertinus
page_size: a4
font_size: 12

# Feature flags
show_amendment_footnotes: true
validate_article_numbers: true
auto_cross_reference: true

# Output options
pdf_bookmarks: true
hyperlinks: true
```

### Compilation Process

1. **Pre-processing**: Validate configuration and file structure
2. **Main compilation**: Process main.tex with selected engine
3. **Post-processing**: Generate bookmarks and hyperlinks
4. **Validation**: Check output integrity
5. **Cleanup**: Remove auxiliary files (optional)

## Contributing Guidelines

### Code Style

#### LaTeX Code Standards
- Use 4-space indentation
- Maximum line length: 80 characters
- Comment complex macro definitions
- Use descriptive command names

#### File Naming Conventions
- Article files: `article-{number}.tex`
- Part files: `part-{number}.tex`
- Schedule files: `schedule-{number}.tex`
- Helper files: descriptive names with hyphens

#### Command Naming
- Public commands: CamelCase (`\Article`, `\Part`)
- Internal commands: lowercase with prefixes (`\soi@internal`)
- Counters: descriptive names (`\articlecounter`)

### Development Workflow

1. **Fork Repository**: Create personal fork
2. **Create Branch**: Use descriptive branch names
3. **Make Changes**: Follow coding standards
4. **Add Tests**: Include relevant test cases
5. **Update Documentation**: Modify affected documentation
6. **Submit Pull Request**: Include clear description

### Testing Requirements

All contributions must include:
- Unit tests for new functionality
- Integration tests for structural changes
- Visual tests for layout modifications
- Documentation updates

### Review Process

1. **Automated Checks**: CI/CD pipeline validation
2. **Code Review**: Peer review of changes
3. **Testing**: Manual testing of edge cases
4. **Documentation Review**: Accuracy and completeness
5. **Final Approval**: Maintainer approval required

## Technical Specifications

### Performance Requirements

- **Compilation Time**: < 60 seconds for full document
- **Memory Usage**: < 512MB during compilation
- **Output Size**: Reasonable PDF file size (< 5MB typical)

### Compatibility Matrix

| Engine    | Version | Status    | Notes                    |
|-----------|---------|-----------|--------------------------|
| pdfLaTeX  | 2018+   | Supported | Basic functionality      |
| XeLaTeX   | 2018+   | Preferred | Full font support        |
| LuaLaTeX  | 2018+   | Supported | Advanced typography      |

### Font Support

| Font Family      | Engine Req. | License    | Status    |
|------------------|-------------|------------|-----------|
| Libertinus       | XeTeX/Lua   | OFL        | Primary   |
| Latin Modern     | All         | LPPL       | Fallback  |
| Times New Roman  | XeTeX/Lua   | Commercial | Optional  |

### Output Formats

- **PDF**: Primary output format
- **DVI**: Legacy support (pdfLaTeX only)
- **PostScript**: Conversion support

### Error Handling

The class implements comprehensive error checking:

```latex
% Validate article number format
\newcommand{\validatearticlenumber}[1]{%
    \IfInteger{#1}{}{%
        \IfEndWith{#1}{A}{}{%
            \PackageWarning{soi}{%
                Unusual article number format: #1
            }%
        }%
    }%
}
```

### Debugging Features

#### Draft Mode
```latex
\if@draftmode
    \RequirePackage{draftwatermark}
    \SetWatermarkText{DRAFT}
    \overfullrule=5pt
\fi
```

#### Logging
- Package warnings for missing files
- Article number validation
- Cross-reference checking
- Font loading status

### Security Considerations

- No external network access required
- All fonts and resources included or system-available
- No executable code in document files
- Safe for automated processing environments

---

This developer guide provides comprehensive technical documentation for contributing to and maintaining the Source of India LaTeX project. For user-focused documentation, refer to the User Guide.