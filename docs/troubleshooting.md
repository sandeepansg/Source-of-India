# Troubleshooting Guide - SoI LaTeX Class

## Table of Contents

1. [Common Issues and Solutions](#common-issues-and-solutions)
2. [Class-Specific Problems](#class-specific-problems)
3. [Compilation Errors](#compilation-errors)
4. [Document Structure Issues](#document-structure-issues)
5. [Amendment System Problems](#amendment-system-problems)
6. [Typography and Formatting Issues](#typography-and-formatting-issues)
7. [Performance Problems](#performance-problems)
8. [Debug Mode and Diagnostics](#debug-mode-and-diagnostics)

---

## Common Issues and Solutions

### Installation Problems

#### Problem: "File `soi.cls' not found"
**Symptoms:**
```
! LaTeX Error: File `soi.cls' not found.
```

**Solutions:**
1. **Place class file in document directory:**
   ```bash
   # Copy soi.cls to your project folder
   cp soi.cls /path/to/your/project/
   ```

2. **Install system-wide:**
   ```bash
   # Find texmf directory
   kpsewhich -var-value TEXMFHOME
   
   # Create directory and copy class
   mkdir -p ~/texmf/tex/latex/soi/
   cp soi.cls ~/texmf/tex/latex/soi/
   texhash ~/texmf
   ```

3. **Check file permissions:**
   ```bash
   chmod 644 soi.cls
   ```

#### Problem: "Package not found" errors
**Symptoms:**
```
! LaTeX Error: File `xparse.sty' not found.
! LaTeX Error: File `etoolbox.sty' not found.
```

**Solutions:**
1. **Update LaTeX distribution:**
   ```bash
   # TeX Live
   tlmgr update --all
   
   # MiKTeX (Windows)
   mpm --update-db
   mpm --install=xparse
   ```

2. **Install missing packages manually:**
   ```bash
   tlmgr install xparse etoolbox xstring needspace
   ```

---

## Class-Specific Problems

### Article Declaration Issues

#### Problem: Invalid article numbering
**Symptoms:**
```
Package soi Warning: Invalid article suffix 'XYZ' detected
```

**Solutions:**
1. **Use valid suffixes:**
   ```latex
   % Correct
   \DeclareArticle{21}{A}{tag}
   \DeclareArticle{243}{ZA}{tag}
   
   % Incorrect
   \DeclareArticle{21}{XYZ}{tag}  % Invalid suffix
   ```

2. **Check suffix patterns:**
   ```latex
   % Valid patterns
   A, B, C, ..., Z          % Single letters
   AA, AB, AC, ..., ZZ      % Double letters
   ZA, ZB, ZC, ..., ZT      % Special range for 243 series
   ```

#### Problem: Missing article files
**Symptoms:**
```
Package soi Warning: Article file not found: content/articles/article_21a.tex
```

**Solutions:**
1. **Create missing files:**
   ```bash
   touch content/articles/article_21a.tex
   ```

2. **Check filename convention:**
   ```latex
   % For Article 21A
   % File should be: article_21a.tex (lowercase suffix)
   
   % For Article 243ZA  
   % File should be: article_243za.tex (lowercase suffix)
   ```

3. **Disable file validation:**
   ```latex
   % In config.tex
   \validatefilesfalse
   ```

### Part and Schedule Issues

#### Problem: Roman numeral errors
**Symptoms:**
```
! Undefined control sequence.
l.XX \Part{XXIII}{TITLE}
```

**Solutions:**
1. **Use supported range (I-XXII):**
   ```latex
   % Supported
   \Part{I}{THE UNION}
   \Part{XXII}{FINAL PROVISIONS}
   
   % Not supported
   \Part{XXIII}{BEYOND RANGE}
   ```

2. **Extend roman numeral function:**
   ```latex
   % In config.tex
   \renewcommand{\toroman}[1]{%
       % Add support for higher numbers
       \ifcase#1\or I\or II\or...\or XXIII\fi
   }
   ```

---

## Compilation Errors

### Engine Compatibility Issues

#### Problem: XeLaTeX/LuaLaTeX font errors
**Symptoms:**
```
fontspec error: "font-not-found"
The font "Libertinus Serif" cannot be found.
```

**Solutions:**
1. **Install required fonts:**
   ```bash
   # Ubuntu/Debian
   sudo apt install fonts-libertinus
   
   # macOS (with Homebrew)
   brew install --cask font-libertinus
   ```

2. **Use fallback fonts:**
   ```latex
   % In config.tex
   \ifxetex
       \IfFontExistsTF{Libertinus Serif}{
           \setmainfont{Libertinus Serif}
       }{
           \setmainfont{Times New Roman}  % Fallback
       }
   \fi
   ```

3. **Force Latin Modern:**
   ```latex
   % Override font selection
   \renewcommand{\rmdefault}{lmr}
   ```

#### Problem: pdfLaTeX encoding issues
**Symptoms:**
```
Package inputenc Error: Unicode char � (U+201C) not set up for use with LaTeX.
```

**Solutions:**
1. **Use proper encoding:**
   ```latex
   % Automatic in class, but can override
   \RequirePackage[utf8]{inputenc}
   \RequirePackage[T1]{fontenc}
   ```

2. **Replace problematic characters:**
   ```latex
   % Instead of Unicode quotes
   ``quoted text''  % LaTeX quotes
   
   % Instead of Unicode dashes
   ---  % em-dash
   --   % en-dash
   ```

### Memory and Capacity Errors

#### Problem: "TeX capacity exceeded"
**Symptoms:**
```
! TeX capacity exceeded, sorry [main memory size=5000000].
```

**Solutions:**
1. **Increase memory limits:**
   ```bash
   # Edit texmf.cnf
   main_memory = 12000000
   extra_mem_bot = 12000000
   save_size = 50000
   ```

2. **Use LuaLaTeX:**
   ```bash
   lualatex main.tex  # Better memory management
   ```

3. **Split document:**
   ```latex
   \includeonly{content/parts/part_iii}  % Compile only one part
   ```

#### Problem: "Too many unprocessed floats"
**Symptoms:**
```
! LaTeX Error: Too many unprocessed floats.
```

**Solutions:**
1. **Use pagefootnotes option:**
   ```latex
   \documentclass[pagefootnotes]{soi}
   ```

2. **Increase float limits:**
   ```latex
   \RequirePackage{morefloats}
   % Or manually:
   \setcounter{totalnumber}{50}
   ```

3. **Force float processing:**
   ```latex
   \clearpage  % Process all pending floats
   ```

---

## Document Structure Issues

### Page Break Problems

#### Problem: Unwanted page breaks in articles
**Symptoms:** Articles split across pages inappropriately

**Solutions:**
1. **Adjust needspace values:**
   ```latex
   % In config.tex
   \renewcommand{\Article}[3][]{%
       \needspace{6\baselineskip}  % Increase from default
       % ... rest of command
   }
   ```

2. **Manual page break control:**
   ```latex
   \Article{Title}{%
       \nopagebreak[4]  % Prevent page break
       Content here...
   }
   ```

3. **Use samepage environment:**
   ```latex
   \begin{samepage}
   \Article{Short Article}{Brief content}
   \end{samepage}
   ```

#### Problem: Excessive white space
**Symptoms:** Large gaps between articles or parts

**Solutions:**
1. **Adjust vertical spacing:**
   ```latex
   % In config.tex
   \setlength{\parskip}{0.4em plus 0.1em minus 0.1em}
   ```

2. **Modify article spacing:**
   ```latex
   \renewcommand{\Article}[3][]{%
       % Reduce spacing after articles
       \addvspace{0.5\baselineskip}  % Instead of 1\baselineskip
   }
   ```

### Header and Footer Issues

#### Problem: Headers not updating
**Symptoms:** Wrong article numbers in headers

**Solutions:**
1. **Manual header update:**
   ```latex
   \DeclareArticle{21}{A}{tag}
   \UpdateHeaders  % Force header update
   ```

2. **Check fancyhdr configuration:**
   ```latex
   % Verify header setup
   \fancyhead[L]{\small\@currentarticledisplay}
   \fancyhead[R]{\small\itshape Constitution of India}
   ```

---

## Amendment System Problems

### Footnote Issues

#### Problem: Amendment footnotes overflow
**Symptoms:** Footnotes extend beyond page bottom

**Solutions:**
1. **Use per-page footnotes:**
   ```latex
   \documentclass[pagefootnotes]{soi}
   ```

2. **Reduce footnote text:**
   ```latex
   \Amendment{text}{Brief citation}  % Shorter citations
   ```

3. **Adjust footnote spacing:**
   ```latex
   \setlength{\footnotesep}{0.4em}  % Tighter spacing
   \renewcommand{\footnotesize}{\scriptsize}
   ```

#### Problem: Amendment markers not showing
**Symptoms:** No footnote marks appear for amendments

**Solutions:**
1. **Check amendment display setting:**
   ```latex
   \showamendmentstrue  % Enable amendments
   ```

2. **Verify class options:**
   ```latex
   \documentclass[showamendments]{soi}  % Not hideamendments
   ```

3. **Test amendment command:**
   ```latex
   % Simple test
   \Amendment{test text}{test citation}
   ```

### Citation Format Problems

#### Problem: Inconsistent amendment citations
**Symptoms:** Various citation formats in same document

**Solutions:**
1. **Use standard format:**
   ```latex
   % Correct format
   Constitution (Forty-second Amendment) Act, 1976, s. 39 (w.e.f. 3-1-1977)
   
   % Standardize ordinals
   First, Second, Third, ..., Twenty-first, ..., Forty-second
   ```

2. **Create citation macros:**
   ```latex
   % In config.tex
   \newcommand{\FortySecondAmendment}{Constitution (Forty-second Amendment) Act, 1976}
   
   % Usage
   \Amendment{text}{\FortySecondAmendment, s. 39}
   ```

---

## Typography and Formatting Issues

### Font Problems

#### Problem: Inconsistent font sizes
**Symptoms:** Mixed font sizes throughout document

**Solutions:**
1. **Reset font hierarchy:**
   ```latex
   % In config.tex
   \renewcommand{\partsize}{\LARGE}
   \renewcommand{\articlesize}{\normalsize}
   \renewcommand{\tagsize}{\small}
   ```

2. **Check custom commands:**
   ```latex
   % Avoid manual font changes
   % Instead of: {\large Article Title}
   % Use: \Article{Article Title}{content}
   ```

#### Problem: Special characters not displaying
**Symptoms:** Missing characters in PDF output

**Solutions:**
1. **Use proper encoding:**
   ```latex
   % pdfLaTeX
   \RequirePackage[utf8]{inputenc}
   \RequirePackage[T1]{fontenc}
   ```

2. **Use LaTeX commands:**
   ```latex
   % Instead of direct Unicode
   \textregistered  % ®
   \copyright       % ©
   \pounds          # £
   ```

### Spacing and Alignment Issues

#### Problem: Inconsistent paragraph spacing
**Symptoms:** Irregular gaps between paragraphs

**Solutions:**
1. **Set consistent parskip:**
   ```latex
   \setlength{\parskip}{0.6em plus 0.1em minus 0.1em}
   \setlength{\parindent}{0pt}
   ```

2. **Avoid manual spacing:**
   ```latex
   % Avoid: \\[2em] or \vspace{}
   % Use: \addvspace{} for consistent spacing
   ```

---

## Performance Problems

### Slow Compilation

#### Problem: Long compilation times
**Symptoms:** Minutes to compile small documents

**Solutions:**
1. **Use draft mode:**
   ```latex
   \documentclass[draft]{soi}
   ```

2. **Conditional compilation:**
   ```latex
   \includeonly{content/parts/part_iii}
   ```

3. **Optimize images:**
   ```bash
   # Convert large images to appropriate formats
   convert large.png -resize 50% optimized.png
   ```

#### Problem: High memory usage
**Symptoms:** System becomes unresponsive during compilation

**Solutions:**
1. **Close other applications**
2. **Use efficient LaTeX engine:**
   ```bash
   lualatex main.tex  # Better memory management
   ```

3. **Reduce amendment detail:**
   ```latex
   \documentclass[hideamendments]{soi}  # For final version
   ```

---

## Debug Mode and Diagnostics

### Enabling Debug Information

```latex
% Enable comprehensive debugging
\documentclass[draft]{soi}

% Additional debug commands
\tracingcommands=1    % Trace command execution
\tracingmacros=1      % Trace macro expansion
\showboxdepth=3       % Show box structure
```

### Debug Output Analysis

#### Counter Information
In draft mode, footer shows:
```
Articles: 45 | Amendments: 23 | Omitted: 3
```

#### Log File Analysis
Check main.log for:
```
Package soi Info: Processing Article 21A
Package soi Warning: Missing file content/articles/article_21a.tex
```

### Custom Debug Commands

Add to config.tex:
```latex
% Debug article processing
\newcommand{\DebugArticle}[1]{%
    \typeout{DEBUG: Processing article #1}%
    \ifx\@currentarticlenum\empty
        \typeout{ERROR: No current article number}%
    \fi
}

% Debug amendment processing
\renewcommand{\Amendment}[3][]{%
    \typeout{DEBUG: Amendment - #2}%
    % ... original command code
}
```

### Validation Scripts

Create tools/validate.sh:
```bash
#!/bin/bash
# Validation script

echo "Validating SoI document structure..."

# Check for required files
required_files=("soi.cls" "main.tex" "config.tex")
for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "ERROR: Missing required file: $file"
        exit 1
    fi
done

# Check article files
echo "Checking article files..."
find content/articles/ -name "*.tex" | while read file; do
    if [[ ! -s "$file" ]]; then
        echo "WARNING: Empty article file: $file"
    fi
done

# Check for common issues
grep -n "\\Amendment{.*}{}" *.tex && echo "ERROR: Empty amendment citations found"
grep -n "\\DeclareArticle{.*}{.*}{}" *.tex && echo "WARNING: Empty article tags found"

echo "Validation complete!"
```

### Emergency Recovery

If document becomes uncompilable:

1. **Create minimal test:**
   ```latex
   \documentclass{soi}
   \begin{document}
   \Part{I}{TEST}
   \Article{Test}{Simple test content.}
   \end{document}
   ```

2. **Binary search for problems:**
   ```latex
   % Comment out half the content
   % \input{content/parts/part_i}
   % \input{content/parts/part_ii}
   \input{content/parts/part_iii}  % Test this part only
   ```

3. **Revert to last working version:**
   ```bash
   git checkout HEAD~1 main.tex  # If using version control
   ```

### Getting Help

When reporting issues:

1. **Provide minimal example:**
   ```latex
   \documentclass{soi}
   \begin{document}
   % Minimal code that reproduces the problem
   \end{document}
   ```

2. **Include system information:**
   ```bash
   latex --version
   kpsewhich -var-value TEXMFROOT
   ```

3. **Attach log file:** main.log with error messages

4. **Specify class options used:**
   ```latex
   \documentclass[showamendments,pagefootnotes]{soi}
   ```

This troubleshooting guide covers the most common issues encountered when using the SoI LaTeX class and provides systematic approaches to resolving them.