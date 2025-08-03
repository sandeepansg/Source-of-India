# Source of India LaTeX Document Class

A specialized LaTeX document class for typesetting the Constitution of India with professional formatting, amendment tracking, and modular structure.

## Technical Specifications

### Paper Size Support
- Supported: A4 and A5 paper sizes only
- Warning issued for any other paper size specifications
- Default: A4 paper with optimized margins for constitutional text

### Engine Compatibility
- pdfLaTeX (recommended)
- XeLaTeX
- LuaLaTeX

### Required LaTeX Distribution
- TeX Live 2020 or later
- MiKTeX 2.9 or later

## Project Structure

```
source-of-india/
├── README.md
├── LICENSE
├── soi.cls
├── main.tex
├── config.tex
├── toc.tex
├── content/
│   ├── parts/
│   │   ├── part_01.tex
│   │   ├── part_03.tex
│   │   └── part_04.tex
│   ├── articles/
│   │   ├── article_001.tex
│   │   ├── article_014.tex
│   │   ├── article_015.tex
│   │   ├── article_021a.tex
│   │   └── article_045.tex
│   └── schedules/
│       ├── schedule_01.tex
│       └── schedule_12.tex
```

## Key Features Implemented

1. **Paper Size Validation**: Only A4 and A5 supported with warnings for other sizes
2. **Modular Structure**: Organized content directory with parts, articles, and schedules
3. **Smart Amendment System**: 
   - `\soiAmendment{}` places footnote marker with brackets
   - `\soiAmendmentData{}` provides footnote content with automatic numbering
4. **Sophisticated Page Management**: Keeps amendments with their content on same page
5. **Proper Clause Numbering**: Arabic (1), alphabetic (a), and roman (i) with indentation
6. **Dynamic Headers**: Two-sided layout with context-aware headers
7. **Professional TOC**: Compatible with amendment system

## Amendment System

### Universal Amendment Commands
```latex
\soiAmendment{amended text}\soiAmendmentData{Citation and details}
```

### Page Management
- Sophisticated page management keeps amendments with their references
- Intelligent page break decisions for constitutional elements
- Dynamic space optimization between text and footnotes

## Numbering System

- Parts: Roman numerals (I, II, III, etc.)
- Articles: Arabic numerals with suffix support (1, 2, 3A, etc.)
- Schedules: Ordinal numbers (FIRST, SECOND, etc.)
- Clauses: (1), (2), (3) with proper indentation
- Sub-clauses: (a), (b), (c) with increased indentation
- Sub-sub-clauses: (i), (ii), (iii) with further indentation

## Header System (Two-Sided Layout)

- Left pages (even): Part/Schedule number on outer margin, "Constitution of India" on inner
- Right pages (odd): Article number on outer margin, "Constitution of India" on inner
- Bottom center: Page number
- Automatic context switching based on current page content

## Class Options

### Paper Size
```latex
\documentclass[a4paper]{soi}    % A4 paper (default)
\documentclass[a5paper]{soi}    % A5 paper
```

### Amendment Display
```latex
\documentclass[showamendments]{soi}    % Show amendments (default)
\documentclass[hideamendments]{soi}    % Hide amendments
```

### Development Mode
```latex
\documentclass[draft]{soi}      % Draft mode
\documentclass[final]{soi}      % Final mode (default)
```

## Core Commands

### Document Structure
```latex
\soiPart{I}{THE UNION AND ITS TERRITORY}
\soiArticle{Name and territory of the Union}{content}
\soiSchedule{FIRST}{THE STATES}{content}
```

### Clause Structure
```latex
\soiClause{Primary clause content}
\soiSubClause{Sub-clause content}
\soiSubSubClause{Sub-sub-clause content}
```

### Amendment System
```latex
\soiAmendment{amended text}\soiAmendmentData{Citation and details}
```

### Special Constitutional Elements
```latex
\soiProviso{Provided that...}
\soiExplanation{Explanation content}
\soiException{Exception content}
```

## Usage Example

### Basic Article Structure
```latex
\documentclass[a4paper,showamendments]{soi}
\input{config}

\begin{document}
\input{toc}

\soiPart{I}{THE UNION AND ITS TERRITORY}

\soiArticle{Name and territory of the Union}{%
    \soiClause{India, that is Bharat, shall be a Union of States.}
    
    \soiClause{The States and the territories thereof shall be as specified in the 
    \soiAmendment{First Schedule}\soiAmendmentData{Constitution (Seventh Amendment) Act, 1956, s. 2}.}
}

\end{document}
```

### Amendment Examples
```latex
% Simple amendment
The State shall provide \soiAmendment{free and compulsory education to all children of the age of six to fourteen years}\soiAmendmentData{Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 (w.e.f. 1-4-2010)}.

% Multiple amendments in sequence
The Parliament may by law \soiAmendment{admit into the Union}\soiAmendmentData{Constitution (First Amendment) Act, 1951, s. 2}, or \soiAmendment{establish}\soiAmendmentData{Constitution (Seventh Amendment) Act, 1956, s. 3} new States.
```

## Configuration

The `config.tex` file controls:
- Amendment display preferences
- Typography settings
- Page layout parameters
- Header and footer formatting
- Table of contents depth

## Compilation

### Standard Compilation
```bash
pdflatex main.tex
pdflatex main.tex  # Second run for cross-references
```

### From Any Directory
Each file is designed to be compilation-aware of its directory structure:
```bash
cd content/articles/
pdflatex article_001.tex  # Compiles independently
```

## File Naming Convention

### Articles
- Format: `article_XXX.tex` where XXX is zero-padded number
- Suffix articles: `article_XXXa.tex`, `article_XXXb.tex`
- Example: `article_001.tex`, `article_021a.tex`

### Parts
- Format: `part_XX.tex` where XX is zero-padded number
- Example: `part_01.tex`, `part_03.tex`

### Schedules
- Format: `schedule_XX.tex` where XX is zero-padded number
- Example: `schedule_01.tex`, `schedule_12.tex`

## Development Guidelines

### Adding New Articles
1. Create article file in `content/articles/`
2. Include in appropriate part file
3. Ensure proper numbering and cross-references

### Adding Amendments
1. Use `\soiAmendment{}` for marked text
2. Follow immediately with `\soiAmendmentData{}`
3. Include full citation with effective date

### Page Management
- Class automatically handles page breaks
- Use `\soiNeedSpace{}` for manual control if needed
- Footnotes automatically managed with text

## Known Limitations

- Paper sizes restricted to A4 and A5 only
- Amendment footnotes use single numbering sequence
- Complex table formatting may require manual adjustment
- Schedule numbering uses English ordinals only

## Version History

- v1.0: Initial implementation with core features
- Amendment tracking system
- Modular document structure
- Automatic page management
- Constitutional formatting

## License

This project is licensed under the LaTeX Project Public License v1.3c.

## Technical Notes

### Font Handling
- Automatic font selection based on LaTeX engine
- Libertinus Serif preferred for XeLaTeX/LuaLaTeX
- Latin Modern fallback for pdfLaTeX
- T1 encoding for proper character support

### Memory Management
- Optimized for large documents
- Efficient cross-reference handling
- Minimized package conflicts

### Cross-References
- Automatic part/article/schedule numbering
- Header content updates based on current context
- Table of contents with proper depth control