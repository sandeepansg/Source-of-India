# Source of India (SoI) LaTeX Document Class

A comprehensive LaTeX document class for typesetting the Constitution of India with sophisticated article numbering, intelligent amendment tracking, and professional legal formatting.

![License](https://img.shields.io/badge/license-LPPL%201.3c-blue.svg)
![LaTeX](https://img.shields.io/badge/LaTeX-pdflatex%20%7C%20xelatex%20%7C%20lualatex-green.svg)
![Constitution](https://img.shields.io/badge/Articles-467-orange.svg)
![Amendments](https://img.shields.io/badge/Amendments-106%2B-red.svg)

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Project Structure](#project-structure)
5. [Core Features](#core-features)
6. [Article Numbering System](#article-numbering-system)
7. [Amendment System](#amendment-system)
8. [Document Structure](#document-structure)
9. [Configuration](#configuration)
10. [Examples](#examples)
11. [Contributing](#contributing)
12. [License](#license)

## Overview

The Source of India (SoI) LaTeX class provides standardized typesetting for the Constitution of India, handling complex constitutional structures with high fidelity to legal standards and modern LaTeX best practices.

### Key Statistics
- 467 constitutional articles across 22 parts
- 12 schedules with complex table structures
- 106+ constitutional amendments with visual indicators
- Multi-compiler support (pdflatex, xelatex, lualatex)
- Professional legal document formatting

### Design Principles
- **Accuracy**: Faithful representation of constitutional text and structure
- **Flexibility**: Sophisticated numbering handles inserted articles (21A)
- **Intelligence**: Automatic amendment tracking with precise footnote positioning
- **Maintainability**: Modular design with separate files per article
- **Accessibility**: Screen reader compatible with semantic markup
- **Performance**: Optimized for large documents with efficient memory usage

## Installation

### Prerequisites
- LaTeX distribution (TeX Live 2020+, MiKTeX 21.1+, MacTeX 2020+)
- Compiler: pdflatex, xelatex, or lualatex
- Overleaf: No additional setup required

### Local Installation
```bash
git clone https://github.com/username/source-of-india.git
cd source-of-india
chmod +x tools/compile.sh
./tools/compile.sh
```

### Manual Compilation
```bash
pdflatex main.tex  # Run twice for proper footnote numbering
pdflatex main.tex  # Second pass for cross-references
```

## Quick Start

### Minimal Document
```latex
\documentclass[a4paper,12pt,showamendments,globalfootnotes]{soi}

\begin{document}
\soifrontcover
\soitableofcontents
\soipreamble

\Part{III}{FUNDAMENTAL RIGHTS}
\SubGroup{Right to Equality}
\input{content/articles/article-014}
\input{content/articles/article-015}

\soibackcover
\end{document}
```

### Simple Article Example
```latex
% content/articles/article-014.tex
\DeclareArticle{14}{}{}
\Article{Equality before law}{%
    The State shall not deny to any person equality before the law or the 
    equal protection of the laws within the territory of India.%
    \footnote{Part of original Constitution adopted 26th November 1949.}%
}
```

### Article with Amendment
```latex
% content/articles/article-021A.tex
\DeclareArticle{21}{A}{}
\Article{Right to education}{%
    The State shall provide free and compulsory education to all children 
    of the age of six to fourteen years in such manner as the State may, 
    by law, determine.%
    \Amendment{entire article}{Inserted by Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 (w.e.f. 1-4-2010)}%
}
```

## Project Structure

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
│   │   ├── part-01.tex         # Part I: The Union and Its Territory
│   │   ├── part-02.tex         # Part II: Citizenship
│   │   ├── part-03.tex         # Part III: Fundamental Rights
│   │   ├── part-04.tex         # Part IV: Directive Principles
│   │   └── ...                 # Additional parts as needed
│   │
│   ├── articles/
│   │   ├── article-001.tex     # Article 1: Name and territory
│   │   ├── article-002.tex     # Article 2: Admission of new States
│   │   ├── article-014.tex     # Article 14: Equality before law
│   │   ├── article-021A.tex    # Article 21A: Right to education
│   │   └── ...                 # All 450+ articles
│   │
│   ├── schedules/
│   │   ├── schedule-01.tex     # First Schedule: States and UTs
│   │   ├── schedule-02.tex     # Second Schedule: Provisions for President
│   │   └── ...                 # All 12 schedules
│   │
│   └── subgroups/
│       ├── right-to-equality.tex    # Subgroup under Part III
│       ├── right-to-freedom.tex     # Subgroup under Part III
│       └── ...                      # Other subgroups
│
├── examples/
│   ├── sample-article.tex      # Example article with amendments
│   ├── sample-schedule.tex     # Example schedule structure
│   └── minimal.tex             # Minimal working example
│
├── docs/
│   ├── class-reference.md      # Complete command reference
│   ├── amendment-guide.md      # Guide for adding amendments
│   └── troubleshooting.md      # Common issues and solutions
│
└── tools/
    ├── validate.sh             # Shell script to validate structure
    ├── compile.sh              # Compilation helper script
    └── clean.sh                # Cleanup generated files
```

## Core Features

### Document Class Options
```latex
\documentclass[options]{soi}
```

**Available Options:**
- **Paper**: `a4paper` (default), `a5paper`, `letterpaper`
- **Font Size**: `10pt`, `11pt`, `12pt` (default)
- **Amendments**: `showamendments` (default), `hideamendments`
- **Footnotes**: `globalfootnotes` (default), `pagefootnotes`
- **Mode**: `final` (default), `draft`
- **Language**: `english` (default)

### Font System with Engine Detection
The class automatically detects your LaTeX engine and loads appropriate fonts:
- **pdfLaTeX**: Latin Modern with T1 encoding
- **XeLaTeX**: Libertinus Serif with OpenType features
- **LuaLaTeX**: Libertinus Serif with advanced typography

### Amendment System
- Single universal `\Amendment{text}{footnote}` command
- Automatic footnote positioning before opening bracket: ¹[text]
- Smart page management keeps articles and footnotes together
- Complete control over footnote content and formatting

## Article Numbering System

The Constitution uses complex alphanumeric numbering: `{Number}{Suffix1}{Suffix2}`

**Examples from Constitution:**
```
Article 14    - Equality before law (original)
Article 21    - Protection of life and personal liberty (original)
Article 21A   - Right to education (86th Amendment, 2002)  
Article 31    - [Omitted by 44th Amendment, 1978]
```

**Usage:**
```latex
\DeclareArticle{21}{A}{}        % Article 21A
\DeclareArticle{239}{A}{A}      % Article 239AA (if it existed)
\DeclareArticle{14}{}{}         % Article 14
```

## Amendment System

### Core Command
```latex
\Amendment{amended text}{footnote content}
```

### Amendment Examples

#### Inserted Article
```latex
\DeclareArticle{21}{A}{}
\Article{Right to education}{%
    \Amendment{The State shall provide free and compulsory education to all children 
    of the age of six to fourteen years in such manner as the State may, 
    by law, determine.}{Inserted by Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 (w.e.f. 1-4-2010)}
}
```

#### Partial Amendment
```latex
\Article{Right to life and personal liberty}{%
    No person shall be deprived of his life or personal liberty except according to 
    \Amendment{procedure established by law}{Substituted for "due process of law" 
    by Constitution (Forty-fourth Amendment) Act, 1978, s. 8 (w.e.f. 20-6-1979)}.
}
```

## Document Structure

### Constitutional Hierarchy
```
Constitution
├── Preamble
├── Parts (22 total)
│   ├── Chapters (within some parts)
│   ├── Groups (thematic divisions)
│   ├── Sub-Groups (sub-divisions)
│   └── Articles (467 total)
│       ├── Clauses (1), (2), (3)...
│       ├── Sub-clauses (a), (b), (c)...
│       └── Sub-sub-clauses (i), (ii), (iii)...
└── Schedules (12 total)
    ├── Parts (within schedules)
    ├── Lists (numbered lists)
    └── Tables (complex tabular data)
```

### Structure Commands
```latex
\Part{III}{FUNDAMENTAL RIGHTS}
\Chapter{I}{RIGHT TO EQUALITY}
\Group{General}
\SubGroup{Right to Equality}
\Heading{Equality before law}
\SubHeading{Protection measures}

\Schedule{I}{THE STATES}
\SchedulePart{A}{THE STATES}
\ScheduleList{1}{State entries}
```

## Configuration

### Basic Configuration (config.tex)
```latex
% Amendment display control
\showamendmentstrue              % Show amendments
% \showamendmentsfalse           % Hide amendments

% Footnote numbering
\globalfootnotestrue             % Global numbering
% \globalfootnotesfalse          % Per-page numbering

% Draft mode
% \draftmodetrue                 % Enable draft features
```

### Typography Customization
```latex
% Size customization
\renewcommand{\partsize}{\LARGE}
\renewcommand{\articlesize}{\normalsize}
\renewcommand{\amendmentopen}{[}
\renewcommand{\amendmentclose}{]}
```

## Examples

See the `examples/` directory for:
- `minimal.tex` - Basic document setup
- `sample-article.tex` - Article with amendments
- `sample-schedule.tex` - Schedule formatting

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Guidelines
- Follow existing code style and documentation patterns
- Test with multiple LaTeX engines (pdflatex, xelatex, lualatex)
- Update documentation for new features
- Validate against constitutional accuracy

## License

This project is licensed under the LaTeX Project Public License (LPPL) v1.3c or later - see the [LICENSE](LICENSE) file for details.

The constitutional content remains in the public domain as government works.

## Acknowledgments

- Government of India for the constitutional text
- LaTeX community for excellent packages and tools
- Legal scholars who maintain constitutional accuracy

---

**Note**: This is an academic and educational project. For legal reference, always consult official government publications.