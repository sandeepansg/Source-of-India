# Source of India LaTeX Document Class v1.0

A specialized LaTeX document class for typesetting the Constitution of India and other constitutional documents with professional formatting, comprehensive amendment tracking, and modular structure.

## Overview

The Source of India (SoI) LaTeX class provides a complete framework for creating constitutional documents with features specifically designed for legal text formatting, amendment management, and professional presentation.

### Key Features

- **Professional Legal Formatting**: Optimized typography for constitutional documents
- **Amendment Tracking System**: Comprehensive footnote system for tracking constitutional amendments
- **Modular Structure**: Separate files for parts, articles, and schedules for easy maintenance
- **Flexible Compilation**: Support for partial compilation and conditional content
- **Cross-Platform Compatibility**: Works with pdfLaTeX, XeLaTeX, and LuaLaTeX
- **Automatic Numbering**: Intelligent article and section numbering with suffix support

## Quick Start

### Prerequisites

- LaTeX distribution (TeX Live 2020+ recommended)
- Basic familiarity with LaTeX

### Basic Usage

1. **Clone or download** the project files
2. **Compile the sample document**:
   ```bash
   pdflatex main.tex
   pdflatex main.tex  # Run twice for cross-references
   ```
3. **View** the generated `main.pdf`

### Minimal Example

```latex
\documentclass[a4paper,12pt,showamendments]{soi}
\input{config}

\begin{document}
\Part{I}{THE UNION AND ITS TERRITORY}

\DeclareArticle{1}{}{union-territory}
\Article{Name and territory of the Union}{%
    India, that is Bharat, shall be a Union of States.
}
\end{document}
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
│   ├── preamble.tex            # Constitution Preamble
│   │
│   ├── parts/
│   │   ├── part_i.tex          # Part I: The Union and Its Territory
│   │   ├── part_iii.tex        # Part III: Fundamental Rights
│   │   └── ...                 # Additional parts as needed
│   │
│   ├── articles/
│   │   ├── article_1.tex       # Article 1: Name and territory
│   │   ├── article_2.tex       # Article 2: Admission of new States
│   │   ├── article_3.tex       # Article 3: Formation of new States
│   │   ├── article_12.tex      # Article 12: Definition (State)
│   │   ├── article_13.tex      # Article 13: Laws inconsistent with FR
│   │   ├── article_14.tex      # Article 14: Equality before law
│   │   ├── article_15.tex      # Article 15: Prohibition of discrimination
│   │   ├── article_19.tex      # Article 19: Freedom of speech
│   │   ├── article_21.tex      # Article 21: Right to life
│   │   ├── article_21a.tex     # Article 21A: Right to education
│   │   └── ...                 # Additional articles as needed
│   │
│   └── schedules/
│       ├── schedule_i.tex      # First Schedule: States and UTs
│       └── ...                 # Additional schedules as needed
│
├── examples/
│   ├── minimal.tex             # Minimal working example
│   └── sample_article.tex      # Example article with amendments
│
├── docs/
│   ├── class_reference.md      # Complete command reference
│   ├── amendment_guide.md      # Guide for adding amendments
│   ├── compilation_guide.md    # Compilation instructions
│   └── troubleshooting.md      # Common issues and solutions
│
└── tools/
    ├── compile.sh              # Compilation helper script
    ├── clean.sh                # Cleanup generated files
    └── validate.sh             # Project structure validation
```

## Class Options

### Basic Options
- `a4paper`, `a5paper`, `letterpaper` - Paper size selection
- `10pt`, `11pt`, `12pt` - Font size (default: 12pt)
- `draft`, `final` - Development vs production mode

### Amendment Control
- `showamendments` - Display amendment footnotes (default)
- `hideamendments` - Hide amendment footnotes
- `showomitted` - Show omitted articles
- `hideomitted` - Hide omitted articles (default)

### Footnote Options
- `globalfootnotes` - Continuous numbering (default)
- `pagefootnotes` - Reset footnote numbers per page

## Core Commands

### Document Structure
```latex
\Part{roman_number}{title}              % Constitutional parts
\Article{title}{content}                % Articles
\Schedule{roman_number}{title}{content} % Schedules
```

### Article Declaration
```latex
\DeclareArticle{number}{suffix}{tag}    % Declare article for numbering
```

### Clause Structure
```latex
\Clause{content}        % Numbered clauses (1), (2), (3)...
\SubClause{content}     % Lettered sub-clauses (a), (b), (c)...
\SubSubClause{content}  % Roman sub-sub-clauses (i), (ii), (iii)...
```

### Amendment System
```latex
\Amendment{text}{citation}[type]                    % General amendment
\Inserted{text}{citation}                          % Newly inserted text
\Substituted{new_text}{old_text}{citation}         % Replaced text
\Omitted{citation}                                  % Removed provisions
\Repealed{citation}                                 % Completely removed
```

## Amendment Examples

### Simple Amendment
```latex
\Amendment{not more than thirty-three other Judges}{Constitution (Forty-second Amendment) Act, 1976, s. 39 \wef{3-1-1977}}
```

### Inserted Provision
```latex
\Inserted{The State shall provide free and compulsory education to all children of the age of six to fourteen years}{Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 \wef{1-4-2010}}
```

### Substituted Text
```latex
\Substituted{SOVEREIGN SOCIALIST SECULAR DEMOCRATIC}{SOVEREIGN DEMOCRATIC}{Constitution (Forty-second Amendment) Act, 1976, Preamble \wef{3-1-1977}}
```

## Sample Content

This package includes sample content demonstrating the class features:

### Part I: The Union and Its Territory
- Article 1: Name and territory of the Union
- Article 2: Admission or establishment of new States  
- Article 3: Formation of new States and alteration of boundaries

### Part III: Fundamental Rights
- Article 12: Definition of "State"
- Article 13: Laws inconsistent with fundamental rights
- Article 14: Equality before law
- Article 15: Prohibition of discrimination
- Article 19: Protection of freedom of speech
- Article 21: Protection of life and personal liberty
- Article 21A: Right to education (inserted by 86th Amendment)

### First Schedule: The States
- Sample entries showing state territories with amendments
- Union territories with recent changes (J&K reorganization, UT mergers)

## Configuration

The `config.tex` file allows customization of:
- Amendment display preferences
- Typography settings
- Spacing and layout
- Development mode features
- Custom commands and environments

## Compilation

### Basic Compilation
```bash
pdflatex main.tex
pdflatex main.tex  # Second run for cross-references
```

### Using Build Scripts
```bash
# Unix/Linux/macOS
./tools/compile.sh

# Windows
tools\compile.bat
```

### Engine Options
- **pdfLaTeX** (recommended): Fast, stable, best compatibility
- **XeLaTeX**: Better font support, Unicode handling
- **LuaLaTeX**: Advanced features, better memory management

## Documentation

Comprehensive documentation is available in the `docs/` directory:

- **Class Reference** (`class_reference.md`): Complete command documentation
- **Amendment Guide** (`amendment_guide.md`): Detailed amendment system usage
- **Compilation Guide** (`compilation_guide.md`): Building and compilation instructions  
- **Troubleshooting** (`troubleshooting.md`): Common problems and solutions

## Contributing

Contributions are welcome! Please read the documentation and follow the established patterns for:
- Adding new constitutional provisions
- Improving amendment tracking
- Enhancing typography and layout
- Adding new features or fixes

## License

This project is licensed under the LaTeX Project Public License v1.3c. See the `LICENSE` file for details.

## Version History

- **v1.0** (August 2025): Initial release with core functionality
  - Complete amendment tracking system
  - Modular document structure
  - Professional legal formatting
  - Sample constitutional content

## Support

For issues, questions, or contributions:
1. Check the documentation in the `docs/` directory
2. Review existing issues and solutions in `troubleshooting.md`
3. Create detailed issue reports with minimal examples

## Acknowledgments

This class was developed to support the digital preservation and academic study of constitutional documents, with particular focus on the Constitution of India and its amendments.
