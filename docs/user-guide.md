# User Guide - Source of India LaTeX Class

## Table of Contents

1. [Introduction](#introduction)
2. [Quick Start](#quick-start)
3. [Installation](#installation)
4. [Basic Usage](#basic-usage)
5. [Document Structure](#document-structure)
6. [Customization Options](#customization-options)
7. [Amendment Features](#amendment-features)
8. [Output Formats](#output-formats)
9. [Troubleshooting](#troubleshooting)
10. [Examples](#examples)
11. [FAQ](#faq)

## Introduction

The Source of India (SoI) LaTeX class is a specialized document class designed for typesetting the Constitution of India and similar legal documents. It provides structured commands for creating professionally formatted constitutional documents with proper numbering, cross-references, and amendment tracking.

### What This Class Provides

- **Professional Formatting**: Automatic formatting following constitutional document standards
- **Structured Content**: Commands for parts, chapters, articles, and clauses
- **Amendment Tracking**: Support for displaying constitutional amendments with footnotes
- **Multiple Output Formats**: Support for different page sizes and font configurations
- **Cross-referencing**: Automatic table of contents and internal references
- **Multi-engine Support**: Works with pdfLaTeX, XeLaTeX, and LuaLaTeX

### Prerequisites

- Basic familiarity with LaTeX
- A working LaTeX installation (TeX Live 2020+ recommended)
- Text editor with LaTeX support (optional but recommended)

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

Compile with:
```bash
xelatex example.tex
```

## Installation

### Method 1: System Installation

1. Download the `soi.cls` file
2. Place it in your local LaTeX tree:
   - **Linux/Mac**: `~/texmf/tex/latex/soi/`
   - **Windows**: `%USERPROFILE%\texmf\tex\latex\soi\`
3. Update the LaTeX file database:
   ```bash
   texhash
   ```

### Method 2: Project-local Installation

1. Download the `soi.cls` file
2. Place it in the same directory as your `.tex` files
3. No additional setup required

### Method 3: Full Project Template

1. Clone or download the complete project
2. Use the provided structure as a template
3. Modify content files as needed

### Verification

Test your installation with:

```latex
\documentclass{soi}
\begin{document}
Test document
\end{document}
```

If this compiles without errors, the installation is successful.

## Basic Usage

### Document Structure

A typical SoI document follows this structure:

```latex
\documentclass[options]{soi}

% Optional: Configuration commands here

\begin{document}

% Front matter
\soifrontcover
\soipreamble
\soitableofcontents

% Main content
\Part{number}{title}
\Chapter{number}{title}    % Optional
\Article{number}{title}{content}

% Schedules (if needed)
\Schedule{title}{content}

% Back matter
\soibackcover

\end{document}
```

### Class Options

#### Paper Size
```latex
\documentclass[a4paper]{soi}    % A4 paper (default)
\documentclass[a5paper]{soi}    % A5 paper
```

#### Font Size
```latex
\documentclass[10pt]{soi}       % 10-point font
\documentclass[11pt]{soi}       % 11-point font
\documentclass[12pt]{soi}       % 12-point font (default)
```

#### Amendment Display
```latex
\documentclass[showamendments]{soi}    % Show amendments (default)
\documentclass[hideamendments]{soi}    % Hide amendments
```

#### Draft Mode
```latex
\documentclass[draft]{soi}      % Draft mode with watermark
\documentclass[final]{soi}      % Final mode (default)
```

### Combined Options
```latex
\documentclass[a4paper,12pt,showamendments,final]{soi}
```

## Document Structure

### Parts

Parts are the highest level of organization:

```latex
\Part{I}{THE UNION AND ITS TERRITORY}
\Part{II}{CITIZENSHIP}  
\Part{III}{FUNDAMENTAL RIGHTS}
```

### Chapters

Chapters are optional subdivisions within parts:

```latex
\Chapter{I}{THE EXECUTIVE}
\Chapter{II}{PARLIAMENT}
```

### Articles

Articles are the main content units:

```latex
\Article{1}{Name and territory of the Union}{
    India, that is Bharat, shall be a Union of States.
}

\Article{21}{Protection of life and personal liberty}{
    No person shall be deprived of his life or personal liberty 
    except according to procedure established by law.
}
```

### Clauses and Sub-clauses

For complex articles with multiple parts:

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

For nested structures:

```latex
\Clause{Main clause content}
    \SubClause{Sub-clause content}
        \SubSubClause{Sub-sub-clause content}
```

### Groups and Subgroups

For organizational headings within parts:

```latex
\Group{GENERAL}
\SubGroup{Preliminary}
```

### Schedules

For appendices and schedules:

```latex
\Schedule{FIRST SCHEDULE}{
    Content of the first schedule goes here.
}
```

## Customization Options

### Configuration File

Create a `config.yaml` file to customize behavior:

```yaml
# Page layout
page_size: a4
font: libertinus
font_size: 12

# Typography
line_spacing: 1.2
margin_top: 2.5
margin_bottom: 2.0

# Features
show_amendment_footnotes: true
show_inline_amendments: true
amendment_style: footnote

# PDF options
pdf_bookmarks: true
hyperlinks: true
```

### Font Selection

The class automatically selects fonts based on your LaTeX engine:

#### XeLaTeX/LuaLaTeX (Recommended)
- Primary: Libertinus Serif (if available)
- Fallback: Latin Modern Roman

#### pdfLaTeX
- Uses Latin Modern fonts with microtype

### Custom Fonts

To use custom fonts with XeLaTeX/LuaLaTeX:

```latex
\documentclass{soi}
\usepackage{fontspec}
\setmainfont{Your Custom Font}
\begin{document}
...
\end{document}
```

### Page Layout Customization

Modify margins and spacing:

```latex
\documentclass{soi}
\usepackage{geometry}
\geometry{
    top=3cm,
    bottom=2.5cm,
    left=3cm,
    right=2.5cm
}
\begin{document}
...
\end{document}
```

## Amendment Features

### Displaying Amendments

The class supports showing constitutional amendments:

```latex
% Show amendment footnote
\AmendmentFootnote{article-number}{amendment-text}

% Mark amended text
\AmendText{current text}{amendment description}

% Show amendment status
\Amendment{article-number}{amendment description}
```

### Amendment Control

Control amendment display globally:

```latex
% Hide all amendments
\documentclass[hideamendments]{soi}

% Show all amendments (default)
\documentclass[showamendments]{soi}
```

### Amendment Database

The system uses `amendments/changes.yaml` for amendment tracking. Users typically don't need to modify this file directly.

## Output Formats

### PDF Generation

#### Using XeLaTeX (Recommended)
```bash
xelatex document.tex
xelatex document.tex  # Run twice for cross-references
```

#### Using pdfLaTeX
```bash
pdflatex document.tex
pdflatex document.tex  # Run twice for cross-references
```

#### Using LuaLaTeX
```bash
lualatex document.tex
lualatex document.tex  # Run twice for cross-references
```

### Batch Processing

For multiple documents:

```bash
# Using make (if Makefile provided)
make all

# Using provided scripts
./scripts/build-all.sh
```

### Output Quality

For best results:
1. Use XeLaTeX or LuaLaTeX for font support
2. Run compilation twice for proper cross-references
3. Use vector fonts (avoid bitmap fonts)
4. Enable PDF bookmarks for navigation

## Troubleshooting

### Common Issues

#### Class File Not Found
```
! LaTeX Error: File `soi.cls' not found.
```

**Solution**: Ensure `soi.cls` is in your LaTeX path or current directory.

#### Font Errors
```
! Font \TU/LibertinusSerif(0)/m/n/10 = "[LibertinusSerif-Regular]" not loadable
```

**Solution**: 
- Install Libertinus fonts, or
- Use pdfLaTeX instead of XeLaTeX/LuaLaTeX

#### Missing Packages
```
! Package XXX not found.
```

**Solution**: Install missing packages using your TeX distribution's package manager:
- **TeX Live**: `tlmgr install package-name`
- **MiKTeX**: Packages install automatically, or use MiKTeX Console

#### Compilation Errors

**Overfull hbox warnings**:
- Normal for complex legal text
- Can be reduced by adjusting margins or using different fonts

**Undefined control sequence**:
- Check command spelling
- Ensure you're using SoI-specific commands correctly
- Use `\Article{}{}{}` not `\section{}`

### Debug Mode

Enable debug information:

```latex
\documentclass[draft]{soi}
```

This enables:
- Draft watermark
- Overfull box indicators
- Faster compilation (some features disabled)

### Getting Help

1. Check this user guide
2. Review example files
3. Check the FAQ section below
4. Review LaTeX logs for specific error messages
5. Consult the developer guide for advanced issues

## Examples

### Simple Article

```latex
\documentclass{soi}
\begin{document}

\Article{356}{Provisions in case of failure of constitutional machinery in States}{
    If the President, on receipt of a report from the Governor of a State or otherwise, 
    is satisfied that a situation has arisen in which the government of the State cannot 
    be carried on in accordance with the provisions of this Constitution, the President 
    may by Proclamation assume to himself all or any of the functions of the Government 
    of the State and all or any of the powers vested in or exercisable by the Governor 
    or anybody or authority in the State other than the Legislature of the State.
}

\end{document}
```

### Complex Article with Clauses

```latex
\documentclass{soi}
\begin{document}

\Article{368}{Power of Parliament to amend the Constitution and procedure therefor}{
    Notwithstanding anything in this Constitution, Parliament may in exercise of its 
    constituent power amend by way of addition, variation or repeal any provision of 
    this Constitution in accordance with the procedure laid down in this article.
    
    \Clause{A Bill for this purpose shall be deemed to be passed by each House of 
    Parliament where the Bill is passed in each House by a majority of the total 
    membership of that House and by a majority of not less than two-thirds of the 
    members of that House present and voting.}
    
    \Clause{Where such amendment seeks to make any change in:
        \SubClause{article 54, article 55, article 73, article 162 or article 241, or}
        \SubClause{Chapter IV of Part V, Chapter V of Part VI, or Chapter I of Part XI, or}
        \SubClause{any of the Lists in the Seventh Schedule, or}
        \SubClause{the representation of States in Parliament, or}
        \SubClause{the provisions of this article,}
        
        the amendment shall also require to be ratified by the Legislatures of not less 
        than one-half of the States specified in Parts A and B of the First Schedule by 
        resolutions to that effect passed by those Legislatures before the Bill making 
        provision for such amendment is presented to the President for assent.}
}

\end{document}
```

### Complete Document Structure

```latex
\documentclass[a4paper,12pt,showamendments]{soi}

\begin{document}

% Front matter
\soifrontcover
\soipreamble
\soitableofcontents

% Part I
\Part{I}{THE UNION AND ITS TERRITORY}

\Article{1}{Name and territory of the Union}{
    India, that is Bharat, shall be a Union of States.
}

\Article{2}{Admission or establishment of new States}{
    Parliament may by law admit into the Union, or establish, new States 
    on such terms and conditions as it thinks fit.
}

% Part II
\Part{II}{CITIZENSHIP}

\Article{5}{Citizenship at the commencement of the Constitution}{
    At the commencement of this Constitution, every person who has his domicile 
    in the territory of India and who was born in the territory of India shall 
    be a citizen of India.
}

% Schedules
\Schedule{FIRST SCHEDULE}{
    States and Union Territories listed here.
}

% Back matter
\soibackcover

\end{document}
```

## FAQ

### General Questions

**Q: Can I use this class for documents other than the Constitution?**
A: Yes, the class is suitable for any formally structured legal or governmental document with similar hierarchical organization.

**Q: Which LaTeX engine should I use?**
A: XeLaTeX is recommended for best font support and Unicode handling. pdfLaTeX works but with limited font options.

**Q: How do I change the document title?**
A: The title is built into the front cover. Modify the `\soifrontcover` command or create your own custom cover.

### Technical Questions

**Q: Why does compilation take so long?**
A: Complex documents with many cross-references require multiple passes. Use draft mode for faster development.

**Q: Can I modify the amendment database?**
A: Advanced users can modify `amendments/changes.yaml`, but this requires understanding of the YAML structure and LaTeX integration.

**Q: How do I create custom article numbering?**
A: The class supports complex numbering like "21A", "371G", etc. Just use the appropriate number in the `\Article{}{}{}` command.

**Q: Can I disable the table of contents?**
A: You can skip the table of contents by omitting the `\soitableofcontents` command from your document.

**Q: How do I handle articles with complex numbering like "21A" or "371G"?**
A: Simply use the full number including letters in the Article command: `\Article{21A}{Title}{Content}` or `\Article{371G}{Title}{Content}`.

**Q: Can I include only specific articles or parts?**
A: Yes, you can selectively include content. Use the provided utility commands:
```latex
\includeArticle{356}  % Include only Article 356
\includeArticleRange{1}{10}  % Include Articles 1-9
```

**Q: How do I handle very long articles?**
A: For lengthy articles, break them into logical clauses using `\Clause{}`, `\SubClause{}`, and `\SubSubClause{}` commands for better readability.

### Formatting Questions

**Q: Can I change the font throughout the document?**
A: Yes, but do it before `\begin{document}`:
```latex
\documentclass{soi}
\usepackage{fontspec}
\setmainfont{Times New Roman}  % XeLaTeX/LuaLaTeX only
\begin{document}
...
```

**Q: How do I adjust line spacing?**
A: Add this after `\documentclass{soi}`:
```latex
\usepackage{setspace}
\onehalfspacing  % or \doublespacing
```

**Q: Can I change the page orientation?**
A: Yes, add this configuration:
```latex
\usepackage{geometry}
\geometry{landscape}
```

**Q: How do I control page breaks?**
A: The class automatically handles page breaks, but you can force them:
```latex
\newpage          % Force new page
\clearpage        % Force new page and clear floats
\needspace{5cm}   % Ensure 5cm space or break page
```

### Content Questions

**Q: How do I add footnotes to articles?**
A: Use standard LaTeX footnotes:
```latex
\Article{21}{Right to Life}{
    No person shall be deprived of life\footnote{This is a fundamental right.} 
    except according to procedure established by law.
}
```

**Q: Can I cross-reference articles?**
A: Yes, use labels and references:
```latex
\Article{21}{Right to Life\label{art:life}}{Content...}

% Later in document:
As mentioned in Article \ref{art:life}...
```

**Q: How do I handle schedules with tables?**
A: Use standard LaTeX table environments within schedules:
```latex
\Schedule{States and Union Territories}{
    \begin{tabular}{|l|l|}
    \hline
    State & Capital \\
    \hline
    Andhra Pradesh & Amaravati \\
    \hline
    \end{tabular}
}
```

**Q: Can I add images or diagrams?**
A: Yes, use the `graphicx` package:
```latex
\usepackage{graphicx}
% In document:
\includegraphics[width=0.8\textwidth]{diagram.pdf}
```

### Advanced Usage Questions

**Q: How do I create a custom document based on this class?**
A: Create your own structure following the SoI pattern:
```latex
\documentclass{soi}
\begin{document}

\soifrontcover  % Optional
% Your custom content using \Part, \Article commands
\soibackcover   % Optional

\end{document}
```

**Q: Can I modify the class behavior permanently?**
A: Yes, but it requires creating a custom `.cls` file or using the configuration options. See the developer guide for details.

**Q: How do I create bilingual documents?**
A: Use packages like `babel` or `polyglossia`:
```latex
\usepackage[hindi,english]{babel}
% Switch languages with \selectlanguage{hindi}
```

**Q: Can I generate multiple output formats from the same source?**
A: Yes, use different compilation commands:
```bash
xelatex document.tex     # For high-quality PDF
pdflatex document.tex    # For compatibility
lualatex document.tex    # For advanced typography
```

### Performance Questions

**Q: Why is compilation slow?**
A: Large documents with many cross-references require multiple passes. To speed up development:
- Use draft mode: `\documentclass[draft]{soi}`
- Comment out `\soitableofcontents` during editing
- Use `\includeonly{}` to compile specific parts

**Q: How can I reduce PDF file size?**
A: Several options:
- Use A5 paper: `\documentclass[a5paper]{soi}`
- Optimize images before inclusion
- Use PDF compression tools after generation

**Q: Can I compile incrementally?**
A: Use the `\includeonly{}` command:
```latex
\documentclass{soi}
\includeonly{part1,part2}  % Only compile these parts
```

### Troubleshooting Questions

**Q: I get "Undefined control sequence" errors**
A: Check that you're using SoI-specific commands correctly:
- Use `\Article{}{}{}` not `\section{}`
- Use `\Part{}{}` not `\part{}`
- Ensure proper command syntax

**Q: Fonts look wrong or missing**
A: Font issues usually indicate:
- Missing font files (install Libertinus fonts)
- Wrong LaTeX engine (try XeLaTeX instead of pdfLaTeX)
- Outdated TeX distribution

**Q: Cross-references show "??" instead of numbers**
A: Run LaTeX twice:
```bash
xelatex document.tex
xelatex document.tex  # Second run resolves references
```

**Q: Amendment footnotes don't appear**
A: Ensure you're using the `showamendments` option:
```latex
\documentclass[showamendments]{soi}
```

**Q: Page numbering is incorrect**
A: The class automatically handles page numbering. If issues persist:
- Check for conflicting packages
- Ensure proper document structure
- Review any custom modifications

## Advanced Customization

### Custom Layouts

For specialized layouts, you can override default settings:

```latex
\documentclass{soi}

% Custom margins
\usepackage{geometry}
\geometry{
    top=3.5cm,
    bottom=3cm,
    left=3cm,
    right=2.5cm
}

% Custom fonts
\usepackage{fontspec}
\setmainfont{Crimson Text}
\setsansfont{Source Sans Pro}

% Custom line spacing
\usepackage{setspace}
\setstretch{1.15}

\begin{document}
% Your content
\end{document}
```

### Integration with Other Classes

The SoI class can inspire custom document classes for other legal documents:

```latex
% Create custom-legal.cls based on soi.cls
\LoadClass{soi}
\renewcommand{\soifrontcover}{%
    % Custom cover for your document type
}
```

### Automation and Scripting

For large projects, consider automation:

```bash
#!/bin/bash
# Build script for multiple documents
for file in *.tex; do
    xelatex "$file"
    xelatex "$file"  # Second pass for references
done
```

### Version Control

When using version control with LaTeX documents:

```gitignore
# .gitignore for LaTeX projects
*.aux
*.log
*.out
*.toc
*.synctex.gz
*.fdb_latexmk
*.fls
*.pdf  # Optional: exclude generated PDFs
```

## Contributing to the Project

### Reporting Issues

When reporting problems:

1. Specify your LaTeX distribution and version
2. Include the exact error message
3. Provide a minimal example that reproduces the issue
4. Mention your operating system

### Suggesting Improvements

The project welcomes contributions:

- Documentation improvements
- Bug fixes
- New features for constitutional documents
- Better font support
- Performance optimizations

### Testing Changes

Before submitting changes:

1. Test with multiple LaTeX engines
2. Verify on different operating systems
3. Check backward compatibility
4. Include appropriate tests

## Conclusion

The Source of India LaTeX class provides a comprehensive solution for typesetting constitutional and legal documents with professional formatting and structure. Its flexible design accommodates various document types while maintaining consistent, high-quality output.

For the most current information, additional examples, and community support, visit the project repository and documentation resources.

### Quick Reference Card

| Command | Purpose | Example |
|---------|---------|---------|
| `\Part{num}{title}` | Create document part | `\Part{I}{THE UNION}` |
| `\Chapter{num}{title}` | Create chapter | `\Chapter{I}{EXECUTIVE}` |
| `\Article{num}{title}{text}` | Create article | `\Article{1}{Name}{India...}` |
| `\Clause{text}` | Create numbered clause | `\Clause{First condition}` |
| `\SubClause{text}` | Create sub-clause | `\SubClause{Sub-condition}` |
| `\Group{title}` | Create group heading | `\Group{GENERAL}` |
| `\Schedule{title}{content}` | Create schedule | `\Schedule{FIRST}{Content}` |

### Essential Class Options

| Option | Effect |
|--------|--------|
| `a4paper` | A4 page size (default) |
| `a5paper` | A5 page size |
| `10pt,11pt,12pt` | Font size (12pt default) |
| `showamendments` | Show amendment footnotes (default) |
| `hideamendments` | Hide amendment footnotes |
| `draft` | Draft mode with watermark |
| `final` | Final mode (default) |

This completes the comprehensive user guide for the Source of India LaTeX class, providing users with all necessary information to effectively use the class for constitutional and legal document typesetting. 
