# Source of India LaTeX Class Reference v1.0

## Table of Contents

1. [Overview](#overview)
2. [Class Options](#class-options)
3. [Package Dependencies](#package-dependencies)
4. [Core Commands](#core-commands)
5. [Document Structure Commands](#document-structure-commands)
6. [Amendment System](#amendment-system)
7. [Typography and Layout](#typography-and-layout)  
8. [Configuration Variables](#configuration-variables)
9. [Internal Commands](#internal-commands)
10. [Error Handling](#error-handling)
11. [Usage Examples](#usage-examples)

---

## Overview

The Source of India (SoI) LaTeX document class provides specialized typesetting for constitutional documents, particularly the Constitution of India. It handles complex article numbering, amendment tracking, and professional legal document formatting.

### System Requirements

- LaTeX distribution (TeX Live 2020+ recommended)
- Compatible with pdfLaTeX, XeLaTeX, and LuaLaTeX engines
- Minimum 512MB RAM for large documents

### File Structure

```
source-of-india/
├── README.md                   # This file
├── LICENSE                     # BSD 3-Clause License
├── soi.cls                     # Main LaTeX document class
├── main.tex                    # Main document entry point
├── config.tex                  # Configuration settings
│
├── content/
│   ├── covers/
│   │   ├── front.tex           # Front cover content
│   │   └── back.tex            # Back cover content
│   │
│   ├── preamble.tex            # Constitution Preamble
│   ├── toc.tex                 # Table of Contents setup
│   │
│   ├── parts/
│   │   ├── part_i.tex          # Part I: The Union and Its Territory
│   │   └── ...                 # Rest of the parts
│   │
│   ├── articles/
│   │   ├── article_1.tex       # Article 1: Name and territory
│   │   └── ...                 # Rest of the articles
│   │
│   ├── schedules/
│   │   ├── schedule_i.tex      # First Schedule: States and UTs
│   │   └── ...                 # Rest of the schedules
│   │
├── examples/
│   ├── sample_article.tex      # Example article with amendments
│   ├── sample_schedule.tex     # Example schedule structure
│   └── minimal.tex             # Minimal working example
│
├── docs/
│   ├── class_reference.md      # Complete command reference
│   ├── amendment_guide.md      # Guide for adding amendments
│   ├── numbering_guide.md      # Guide for adding amendments
│   ├── compilation_guide.md    # Guide for adding amendments
│   └── troubleshooting.md      # Common issues and solutions
│
└── tools/
    ├── validate.sh             # Shell script to validate structure
    ├── compile.sh              # Compilation helper script
    └── cleanup.sh              # Cleanup generated files
```

---

## Class Options

### Basic Options

```latex
\documentclass[option1,option2,...]{soi}
```

| Option | Type | Description | Default |
|--------|------|-------------|---------|
| `a4paper` | Layout | A4 paper size | Yes |
| `a5paper` | Layout | A5 paper size | No |
| `letterpaper` | Layout | US Letter size | No |
| `10pt` | Typography | 10pt base font | No |
| `11pt` | Typography | 11pt base font | No |
| `12pt` | Typography | 12pt base font | Yes |

### Amendment Control Options

| Option | Description | Default |
|--------|-------------|---------|
| `showamendments` | Display amendment footnotes | Enabled |
| `hideamendments` | Hide amendment footnotes | Disabled |
| `showomitted` | Show omitted articles | Disabled |
| `hideomitted` | Hide omitted articles | Enabled |

### Footnote Options

| Option | Description | Default |
|--------|-------------|---------|
| `globalfootnotes` | Continuous numbering across document | Enabled |
| `pagefootnotes` | Reset footnote numbers per page | Disabled |

### Development Options

| Option | Description | Default |
|--------|-------------|---------|
| `draft` | Enable development features | Disabled |
| `final` | Production mode | Enabled |

---

## Package Dependencies

### Engine-Specific Loading

The class automatically detects the LaTeX engine and loads appropriate packages:

**pdfLaTeX:**
```latex
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
```

**XeLaTeX/LuaLaTeX:**
```latex
\RequirePackage{fontspec}
\RequirePackage{luatextra} % LuaLaTeX only
```

### Core Dependencies

| Package | Purpose | Version Required |
|---------|---------|------------------|
| `geometry` | Page layout | Any |
| `xparse` | Command definition | 2020/03/03+ |
| `fancyhdr` | Headers/footers | Any |
| `needspace` | Page break control | Any |
| `hyperref` | PDF features | Any |
| `xstring` | String processing | Any |
| `etoolbox` | Programming utilities | Any |

---

## Core Commands

### Declaration Commands

#### `\DeclareArticle{number}{suffix}{tag}`

Declares an article for the numbering system.

**Parameters:**
- `number`: Base article number (1, 21, 124, 243)
- `suffix`: Additional suffix (A, AA, AB, ZA, ZT, etc.)
- `tag`: Internal classification tag

**Example:**
```latex
\DeclareArticle{21}{A}{fundamental-rights}
\DeclareArticle{243}{ZA}{municipalities}
\DeclareArticle{124}{}{judiciary}
```

#### `\DeclarePart{roman}{suffix}{tag}`

Declares a constitutional part.

**Example:**
```latex
\DeclarePart{III}{}{fundamental-rights}
\DeclarePart{IV}{A}{fundamental-duties}
```

#### `\DeclareSchedule{roman}{tag}`

Declares a schedule.

**Example:**
```latex
\DeclareSchedule{I}{states}
\DeclareSchedule{VII}{legislative-lists}
```

### File Generation Commands

#### `\articlefilename{number}{suffix}`

Generates standardized filenames for article files.

**Returns:** `article_{number}{lowercase_suffix}.tex`

**Example:**
```latex
\articlefilename{21}{A}     % Returns: article_21a.tex
\articlefilename{243}{ZA}   % Returns: article_243za.tex
```

#### `\partfilename{roman}{suffix}`

Generates part filenames.

**Example:**
```latex
\partfilename{III}{}    % Returns: part_iii.tex
\partfilename{IV}{A}    % Returns: part_iva.tex
```

---

## Document Structure Commands

### Part Command

```latex
\Part{roman_number}{title}[optional_tag]
```

Creates a constitutional part with proper page management and table of contents entry.

**Features:**
- Automatic page break calculation
- TOC integration
- Header updates

**Example:**
```latex
\Part{III}{FUNDAMENTAL RIGHTS}
\Part{IX}{THE PANCHAYATS}[Panchayati Raj]
```

### Article Command

```latex
\Article{title}{content}[optional_tag]
```

Creates an article with intelligent page break management.

**Features:**
- Pre-calculates space requirements
- Handles footnote placement
- Updates document headers
- TOC integration

**Example:**
```latex
\Article{Equality before law}{%
    The State shall not deny to any person equality before the law or the equal protection of the laws within the territory of India.
}
```

### Clause Commands

#### `\Clause{content}`
Creates numbered clauses (1), (2), (3)...

#### `\SubClause{content}`  
Creates lettered sub-clauses (a), (b), (c)...

#### `\SubSubClause{content}`
Creates Roman sub-sub-clauses (i), (ii), (iii)...

**Example:**
```latex
\Article{Parliamentary privileges}{%
    \Clause{Subject to the provisions of this Constitution and to the rules and standing orders regulating the procedure of Parliament:}
    
    \SubClause{there shall be freedom of speech in Parliament;}
    
    \SubClause{no member of Parliament shall be liable to any proceedings in any court in respect of anything said by him in Parliament;}
    
    \SubSubClause{subject to reasonable restrictions imposed by existing law;}
}
```

### Schedule Command

```latex
\Schedule{roman_number}{title}{content}[optional_tag]
```

Creates constitutional schedules with proper formatting.

**Example:**
```latex
\Schedule{I}{THE STATES}{
    \begin{enumerate}
    \item Andhra Pradesh
    \item Assam  
    \item Bihar
    \end{enumerate}
}
```

---

## Amendment System

### Core Amendment Command

```latex
\Amendment{new_text}{amendment_citation}[type]
```

The primary command for tracking constitutional amendments.

**Parameters:**
- `new_text`: The current/amended text
- `amendment_citation`: Full citation of the amending act
- `type`: Optional amendment type (insertion, substitution, omission)

**Display:** Creates footnote with amendment information when `showamendments` is enabled.

### Specialized Commands

#### `\Inserted{text}{citation}`
For newly inserted provisions.

```latex
\Inserted{The State shall provide free and compulsory education to all children of the age of six to fourteen years}{Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 (w.e.f. 1-4-2010)}
```

#### `\Substituted{new_text}{old_text}{citation}`
For replaced provisions.

```latex
\Substituted{not more than thirty-three other Judges}{not more than seven other Judges}{Constitution (Forty-second Amendment) Act, 1976, s. 39}
```

#### `\Omitted{citation}` and `\Repealed{citation}`
For removed provisions (displayed only when `showomitted` is enabled).

```latex
\Omitted{Constitution (Forty-fourth Amendment) Act, 1978, s. 6}
\Repealed{Constitution (Forty-third Amendment) Act, 1977, s. 2}
```

### Amendment Display Control

The class provides boolean flags to control amendment display:

```latex
% In config.tex or preamble
\showamendmentstrue   % Show all amendments
\showamendmentsfalse  % Hide all amendments
\showomittedtrue      % Show omitted articles
\showomittedfalse     % Hide omitted articles
```

---

## Typography and Layout

### Page Geometry

Default page setup for A4:
```latex
\geometry{
    top=2.5cm,
    bottom=2.5cm, 
    left=3cm,
    right=2.5cm,
    headheight=14pt,
    headsep=20pt,
    footskip=25pt
}
```

### Typography Hierarchy

| Element | Default Size | Customization Command |
|---------|--------------|----------------------|
| Parts | `\LARGE` | `\renewcommand{\partsize}{\huge}` |
| Articles | `\normalsize` | `\renewcommand{\articlesize}{\large}` |
| Headings | `\normalsize` | `\renewcommand{\headingsize}{\large}` |
| Tags | `\normalsize` | `\renewcommand{\tagsize}{\small}` |

### Spacing Configuration

```latex
\setlength{\parskip}{0.6em plus 0.1em minus 0.1em}
\setlength{\parindent}{0pt}
\renewcommand{\baselinestretch}{1.1}
```

### Header and Footer System

The class uses `fancyhdr` with automatic updates:

```latex
\fancyhead[L]{\small\@currentarticledisplay}
\fancyhead[R]{\small\itshape Constitution of India}
\fancyfoot[C]{\thepage}
```

In draft mode, additional information appears in footers:
```latex
\fancyfoot[L]{\tiny Articles: \thetotalarticles{}}
\fancyfoot[R]{\tiny Amendments: \thetotalamendments}
```

---

## Configuration Variables

### Amendment Brackets

Customize amendment display brackets:

```latex
\renewcommand{\amendmentopen}{[}    % Default: [
\renewcommand{\amendmentclose}{]}   % Default: ]
```

Alternative styles:
```latex
% Curly braces
\renewcommand{\amendmentopen}{\{}
\renewcommand{\amendmentclose}{\}}

% Angle brackets  
\renewcommand{\amendmentopen}{<}
\renewcommand{\amendmentclose}{>}
```

### Counters

| Counter | Purpose | Access Command |
|---------|---------|----------------|
| `articlenumber` | Article count | `\thearticlenumber` |
| `partnumber` | Part count | `\thepartnumber` |
| `schedulenumber` | Schedule count | `\theschedulenumber` |
| `totalarticles` | Total articles processed | `\thetotalarticles` |
| `totalamendments` | Total amendments tracked | `\thetotalamendments` |

### Internal Variables

| Variable | Content | Usage |
|----------|---------|-------|
| `\@currentarticlenum` | Current article number | Internal tracking |
| `\@currentarticlesuffix` | Current article suffix | Internal tracking |
| `\@currentarticledisplay` | Formatted display text | Headers, TOC |

---

## Internal Commands

### Utility Functions

#### `\toroman{number}`
Converts Arabic numerals to Roman numerals (1-22 range).

#### `\parsecompletesuffix{suffix}`
Parses complex suffixes like "ZA" into major and minor components.

#### `\checkarticlestatus{number}{suffix}`
Determines if an article is omitted based on internal lists.

### Page Management

#### `\needspace{dimension}`
Ensures minimum space available on current page before content.

#### `\UpdateHeaders`
Refreshes header content based on current document position.

### String Processing

The class uses `xstring` package functions for:
- Suffix parsing and validation
- Filename generation
- Amendment text processing

---

## Error Handling

### Warning System

```latex
\soiwarning{message}    % Issues class warnings
\soierror{error}{help}  % Issues class errors
```

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Missing article file | File not found | Check filename convention |
| Invalid suffix | Unsupported suffix format | Use standard suffixes (A, AA, etc.) |
| Page break issues | Insufficient space calculation | Adjust `\needspace` values |
| Amendment footnote overflow | Too many amendments per page | Use `pagefootnotes` option |

### Debug Mode

Enable with `draft` class option:
```latex
\documentclass[draft]{soi}
```

Provides:
- Counter information in footers
- Warning messages for missing files
- Page break debugging information

---

## Usage Examples

### Basic Document Setup

```latex
\documentclass[a4paper,12pt,showamendments]{soi}

\begin{document}

% Part declaration
\Part{III}{FUNDAMENTAL RIGHTS}

% Article with amendment
\DeclareArticle{21}{A}{fundamental-rights}
\Article{Right to education}{%
    \Inserted{The State shall provide free and compulsory education to all children of the age of six to fourteen years in such manner as the State may, by law, determine.}{Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 (w.e.f. 1-4-2010)}%
}

\end{document}
```

### Complex Article Structure

```latex
\DeclareArticle{124}{}{judiciary}
\Article{Establishment and constitution of Supreme Court}{%
    \Clause{There shall be a Supreme Court of India consisting of a Chief Justice of India and \Amendment{not more than thirty-three other Judges}{Constitution (Forty-second Amendment) Act, 1976, s. 39}.}
    
    \Clause{Every Judge of the Supreme Court shall be appointed by the President and shall hold office until he attains the age of sixty-five years:}
    
    Provided that---
    
    \SubClause{a Judge may, by writing under his hand addressed to the President, resign his office;}
    
    \SubClause{a Judge may be removed from his office in the manner provided in clause (4).}
}
```

### Configuration Example

```latex
% In config.tex
\showamendmentstrue
\showomittedfalse

% Custom amendment brackets
\renewcommand{\amendmentopen}{\{}
\renewcommand{\amendmentclose}{\}}

% Typography adjustments
\renewcommand{\partsize}{\huge}
\renewcommand{\articlesize}{\large}
```

---

## Version Information

- **Class Version:** 1.0
- **Release Date:** August 2025
- **Compatibility:** LaTeX2e 2020/10/01+
- **Author:** Sandeepan Sengupta
- **License:** LaTeX Project Public License v1.3c

For additional documentation, see:
- `numbering_guide.md` - Article and part numbering conventions
- `amendment_guide.md` - Amendment system usage
- `compilation_guide.md` - Building and compilation instructions
- `troubleshooting.md` - Common problems and solutions