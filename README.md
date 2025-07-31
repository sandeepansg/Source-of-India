# Source of India LaTeX Class

A specialized LaTeX document class for typesetting the Constitution of India and similar legal documents with professional formatting, amendment tracking, and comprehensive cross-referencing capabilities.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Usage Examples](#usage-examples)
- [Documentation](#documentation)
- [Requirements](#requirements)
- [Supported Engines](#supported-engines)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)

## Overview

The Source of India (SoI) LaTeX class provides a complete solution for creating professionally formatted constitutional and legal documents. It implements the hierarchical structure of the Indian Constitution with proper typography, automatic numbering, and amendment tracking capabilities.

### Key Benefits

- **Professional Typography**: Follows constitutional document formatting standards
- **Structured Content**: Hierarchical organization with Parts, Chapters, Articles, and Clauses
- **Amendment Support**: Built-in system for tracking and displaying constitutional amendments
- **Multi-format Output**: Supports A4/A5 paper sizes and multiple font configurations
- **Cross-platform**: Compatible with all major LaTeX distributions and operating systems
- **Engine Flexibility**: Works with pdfLaTeX, XeLaTeX, and LuaLaTeX

## Features

### Document Structure
- **Hierarchical Organization**: Parts, Chapters, Articles, Clauses, Sub-clauses
- **Automatic Numbering**: Roman numerals for parts, Arabic for articles, with complex numbering support (21A, 371G, etc.)
- **Table of Contents**: Automatic generation with proper formatting
- **Cross-references**: Built-in support for internal document references

### Typography and Layout
- **Multiple Paper Sizes**: A4 and A5 support with optimized layouts
- **Font Support**: Automatic font selection based on LaTeX engine
- **Professional Formatting**: Constitutional document typography standards
- **Page Layout**: Optimized margins, headers, and footers

### Amendment System
- **Amendment Tracking**: Complete constitutional amendment history
- **Footnote Support**: Automatic amendment footnotes
- **Flexible Display**: Show/hide amendments as needed
- **Historical Accuracy**: Maintains legal document integrity

### Development Features
- **Modular Architecture**: Separate files for articles, parts, and schedules
- **Testing Framework**: Comprehensive unit and integration tests
- **Build Automation**: Cross-platform build scripts
- **Version Control Ready**: Optimized for collaborative development

## Quick Start

### Minimal Example

Create a file named `example.tex`:

```latex
\documentclass[a4paper,12pt]{soi}

\begin{document}

% Front matter
\soifrontcover
\soipreamble
\soitableofcontents

% Main content
\Part{I}{THE UNION AND ITS TERRITORY}

\Article{1}{Name and territory of the Union}{
    India, that is Bharat, shall be a Union of States.
}

\Article{2}{Admission or establishment of new States}{
    Parliament may by law admit into the Union, or establish, new States 
    on such terms and conditions as it thinks fit.
}

% Back matter
\soibackcover

\end{document}
```

### Compilation

```bash
# Recommended (best font support)
xelatex example.tex
xelatex example.tex  # Run twice for cross-references

# Alternative engines
pdflatex example.tex
lualatex example.tex
```

## Installation

### Method 1: Local Installation

1. Download `soi.cls` from the releases page
2. Place it in your project directory alongside your `.tex` files
3. Use `\documentclass{soi}` in your document

### Method 2: System Installation

#### Linux/macOS
```bash
# Create local texmf directory if it doesn't exist
mkdir -p ~/texmf/tex/latex/soi/

# Copy the class file
cp soi.cls ~/texmf/tex/latex/soi/

# Update LaTeX file database
texhash ~/texmf
```

#### Windows
```cmd
# Copy to local texmf (adjust path as needed)
copy soi.cls "%USERPROFILE%\texmf\tex\latex\soi\"

# Update file database
mktexlsr
```

### Method 3: Complete Project Template

```bash
# Clone the repository
git clone https://github.com/source-of-india/soi-latex.git
cd soi-latex

# Run setup script
./scripts/setup-project.sh
```

### Verification

Test your installation:

```latex
\documentclass{soi}
\begin{document}
Installation successful!
\end{document}
```

If this compiles without errors, the installation is complete.

## Usage Examples

### Basic Article Structure

```latex
\documentclass{soi}
\begin{document}

\Article{21}{Protection of life and personal liberty}{
    No person shall be deprived of his life or personal liberty 
    except according to procedure established by law.
}

\end{document}
```

### Complex Article with Clauses

```latex
\Article{19}{Protection of certain rights regarding freedom of speech, etc.}{
    All citizens shall have the right to:
    
    \Clause{freedom of speech and expression;}
    
    \Clause{to assemble peaceably and without arms;}
    
    \Clause{to form associations or unions or cooperative societies;}
    
    \Clause{to move freely throughout the territory of India;}
    
    \Clause{to reside and settle in any part of the territory of India; and}
    
    \Clause{subject to the provisions of any law made by the State, 
    to practice any profession, or to carry on any occupation, trade or business.}
}
```

### Nested Structure with Sub-clauses

```latex
\Article{368}{Power of Parliament to amend the Constitution}{
    Parliament may amend this Constitution in accordance with this article.
    
    \Clause{A Bill shall be passed by each House where the Bill is passed:
        \SubClause{by a majority of the total membership of that House; and}
        \SubClause{by a majority of not less than two-thirds of the members 
        of that House present and voting.}
    }
    
    \Clause{Where such amendment seeks to make changes in:
        \SubClause{any provision mentioned in the proviso to this clause,}
        \SubClause{the representation of States in Parliament,}
            \SubSubClause{the amendment shall require ratification by the States.}
    }
}
```

### Document with Parts and Chapters

```latex
\documentclass[a4paper,12pt,showamendments]{soi}

\begin{document}

\soifrontcover
\soipreamble
\soitableofcontents

\Part{V}{THE UNION}

\Chapter{I}{THE EXECUTIVE}

\Group{The President and Vice-President}

\Article{52}{The President of India}{
    There shall be a President of India.
}

\Article{53}{Executive power of the Union}{
    The executive power of the Union shall be vested in the President and 
    shall be exercised by him either directly or through officers subordinate to him 
    in accordance with this Constitution.
}

\Chapter{II}{PARLIAMENT}

\SubGroup{General}

\Article{79}{Constitution of Parliament}{
    There shall be a Parliament for the Union which shall consist of the President 
    and two Houses to be known respectively as the Council of States and the House of the People.
}

\soibackcover

\end{document}
```

### Schedule Example

```latex
\Schedule{FIRST SCHEDULE}{
    \begin{center}
    \textbf{STATES}
    \end{center}
    
    \begin{enumerate}
    \item Andhra Pradesh
    \item Arunachal Pradesh
    \item Assam
    \item Bihar
    \item Chhattisgarh
    % ... more states
    \end{enumerate}
    
    \begin{center}
    \textbf{UNION TERRITORIES}
    \end{center}
    
    \begin{enumerate}
    \item Andaman and Nicobar Islands
    \item Chandigarh
    \item Dadra and Nagar Haveli and Daman and Diu
    % ... more territories
    \end{enumerate}
}
```

## Documentation

### User Documentation
- **[User Guide](docs/user-guide.md)**: Complete user manual with examples and troubleshooting
- **[Quick Reference](docs/quick-reference.md)**: Command reference and class options
- **[FAQ](docs/faq.md)**: Frequently asked questions and solutions

### Developer Documentation
- **[Developer Guide](docs/developer-guide.md)**: Technical documentation for contributors
- **[API Reference](docs/api-reference.md)**: Complete command and macro documentation
- **[Testing Guide](docs/testing.md)**: Information about the testing framework

### Examples
- **[Basic Examples](examples/basic/)**: Simple document examples
- **[Advanced Examples](examples/advanced/)**: Complex document structures
- **[Template](examples/template/)**: Complete Constitution template

## Requirements

### LaTeX Distribution
- **TeX Live 2020+** (recommended)
- **MiKTeX 2.9+**
- **MacTeX 2020+**

### Required Packages
The following packages are automatically loaded by the class:

```latex
% Core packages
iftex, etoolbox, xstring, needspace
fancyhdr, geometry, titletoc, hyperref, forloop

% Font packages (engine-dependent)
fontspec        % XeLaTeX/LuaLaTeX
inputenc, T1enc % pdfLaTeX
polyglossia     % XeLaTeX/LuaLaTeX
microtype       % pdfLaTeX
```

### Recommended Fonts
- **Libertinus Serif** (primary choice for XeLaTeX/LuaLaTeX)
- **Libertinus Sans** (sans serif companion)
- **Latin Modern** (fallback for all engines)

### Optional Dependencies
- **draftwatermark**: For draft mode functionality
- **graphicx**: For including images and diagrams
- **babel/polyglossia**: For multilingual documents
- **setspace**: For custom line spacing

## Supported Engines

| Engine    | Version | Status      | Font Support | Performance | Notes |
|-----------|---------|-------------|--------------|-------------|-------|
| XeLaTeX   | 2018+   | Recommended | Excellent    | Good        | Best font handling |
| LuaLaTeX  | 2018+   | Supported   | Excellent    | Good        | Advanced typography |
| pdfLaTeX  | 2018+   | Supported   | Basic        | Excellent   | Fastest compilation |

### Engine-Specific Features

#### XeLaTeX
- Full Unicode support
- System font access
- Advanced OpenType features
- Best font rendering quality

#### LuaLaTeX
- Lua scripting capabilities
- Advanced typography control
- Unicode support
- Moderate compilation speed

#### pdfLaTeX
- Fastest compilation
- Widest compatibility
- Limited to Type 1 fonts
- Reliable cross-platform behavior

## Project Structure

```
soi-latex/
├── soi.cls                    # Main LaTeX class file
├── README.md                  # This file
├── LICENSE                    # License information
├── config.yaml                # Configuration settings
├── main.tex                   # Complete Constitution template
├── docs/                      # Documentation
│   ├── user-guide.md          # User manual
│   ├── developer-guide.md     # Developer documentation
│   ├── quick-reference.md     # Command reference
│   └── api-reference.md       # Complete API documentation
├── examples/                  # Example documents
│   ├── basic/                 # Simple examples
│   ├── advanced/              # Complex examples
│   └── template/              # Document templates
├── includes/                  # Modular content files
│   ├── articles/              # Individual article files
│   ├── parts/                 # Part division files
│   ├── schedules/             # Schedule files
│   ├── cover.tex              # Cover page templates
│   ├── preamble.tex           # Constitutional preamble
│   └── helpers/               # Utility macros
├── amendments/                # Amendment system
│   ├── changes.yaml           # Amendment database
│   └── footnotes.tex          # Amendment footnotes
├── scripts/                   # Build and utility scripts
│   ├── setup-project.bat      # Project skeleton generation (on Windows)
│   ├── setup-project.sh       # Project skeleton generation
│   ├── build-all.sh           # Main build and batch compilation script
│   ├── validate-structure.py  # Structure validation
│   └── generate-toc.py        # TOC generation
├── tests/                     # Test suite
│   ├── unit/                  # Unit tests
│   ├── integration/           # Integration tests
│   └── visual/                # Visual regression tests
└── output/                    # Generated PDFs
    ├── constitution-a4.pdf    # A4 format output
    ├── constitution-a5.pdf    # A5 format output
    └── test-results/          # Test outputs
```

## Contributing

We welcome contributions to improve the Source of India LaTeX class!

### How to Contribute

1. **Fork the Repository**
   ```bash
   git clone https://github.com/your-username/soi-latex.git
   cd soi-latex
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**
   - Follow the coding standards in the developer guide
   - Add tests for new functionality
   - Update documentation as needed

4. **Test Your Changes**
   ```bash
   ./scripts/run-tests.sh
   ```

5. **Submit a Pull Request**
   - Provide a clear description of changes
   - Include test results
   - Reference any related issues

### Types of Contributions

- **Bug Fixes**: Resolve compilation issues, formatting problems
- **Feature Enhancements**: New commands, improved functionality
- **Documentation**: User guide improvements, examples, tutorials
- **Testing**: Additional test cases, performance improvements
- **Localization**: Support for additional languages and scripts

### Coding Standards

- **LaTeX Code**: 4-space indentation, 80-character line limit
- **Documentation**: Clear, concise explanations with examples
- **File Naming**: Descriptive names with hyphens for separation
- **Comments**: Document complex macros and design decisions

### Testing Requirements

All contributions must include:
- Unit tests for new functionality
- Integration tests for structural changes
- Visual tests for layout modifications
- Updated documentation

## License

This project is licensed under the LaTeX Project Public License (LPPL) version 1.3c or later.

### Key Points
- **Free Use**: Use for any purpose, including commercial
- **Modification**: Allowed with proper attribution
- **Distribution**: Freely distributable under LPPL terms
- **Name Protection**: Modified versions must use different names

See the [LICENSE](LICENSE) file for complete terms.

## Support

### Getting Help

1. **Documentation**: Check the [User Guide](docs/user-guide.md) and [FAQ](docs/faq.md)
2. **Examples**: Review the [examples directory](examples/) for usage patterns
3. **Issues**: Report bugs or request features on [GitHub Issues](https://github.com/source-of-india/soi-latex/issues)
4. **Discussions**: Join community discussions on [GitHub Discussions](https://github.com/source-of-india/soi-latex/discussions)

### Reporting Issues

When reporting problems, please include:

- **LaTeX Distribution**: TeX Live, MiKTeX, MacTeX version
- **Operating System**: Windows, macOS, Linux distribution
- **LaTeX Engine**: pdfLaTeX, XeLaTeX, LuaLaTeX
- **Error Messages**: Complete error log
- **Minimal Example**: Smallest code that reproduces the issue

### Community Resources

- **Project Repository**: [https://github.com/source-of-india/soi-latex](https://github.com/source-of-india/soi-latex)
- **Wiki**: Community-maintained tips and tutorials
- **Discussions**: Q&A and feature discussions
- **Releases**: Stable versions and changelogs

### Professional Support

For institutional users requiring professional support:
- Custom document class development
- Training and workshops
- Integration consulting
- Performance optimization

Contact the maintainers for commercial support options.

---

## Quick Reference

### Essential Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `\Part{num}{title}` | Document part | `\Part{I}{THE UNION}` |
| `\Chapter{num}{title}` | Chapter division | `\Chapter{I}{EXECUTIVE}` |
| `\Article{num}{title}{text}` | Main article | `\Article{1}{Name}{India...}` |
| `\Clause{text}` | Numbered clause | `\Clause{First condition}` |
| `\SubClause{text}` | Sub-clause | `\SubClause{Sub-condition}` |
| `\Schedule{title}{content}` | Appendix | `\Schedule{FIRST}{Content}` |

### Class Options

```latex
\documentclass[a4paper,12pt,showamendments,final]{soi}
```

| Option | Values | Default | Purpose |
|--------|---------|---------|---------|
| Paper | `a4paper`, `a5paper` | `a4paper` | Page size |
| Font Size | `10pt`, `11pt`, `12pt` | `12pt` | Base font size |
| Amendments | `showamendments`, `hideamendments` | `showamendments` | Amendment display |
| Mode | `draft`, `final` | `final` | Document mode |

### Build Commands

```bash
# Single document
xelatex document.tex
xelatex document.tex  # Second pass for references

# Full project
./scripts/setup-project.sh

# Run tests
./scripts/run-tests.sh
```

---

The Source of India LaTeX class provides professional typesetting capabilities for constitutional and legal documents. Whether you're creating educational materials, legal references, or official publications, this class ensures consistent, high-quality formatting that meets professional standards.

For the latest updates and community contributions, visit our [GitHub repository](https://github.com/source-of-india/soi-latex).