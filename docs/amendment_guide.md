# Amendment Guide - SoI LaTeX Class

## Table of Contents

1. [Amendment System Overview](#amendment-system-overview)
2. [Amendment Commands](#amendment-commands)
3. [Citation Standards](#citation-standards)
4. [Amendment Types](#amendment-types)
5. [Display Control](#display-control)
6. [Best Practices](#best-practices)
7. [Common Amendment Patterns](#common-amendment-patterns)
8. [Troubleshooting](#troubleshooting)

---

## Amendment System Overview

The SoI LaTeX class provides a comprehensive system for tracking constitutional amendments. The system handles footnote generation, citation formatting, and conditional display of amendment information.

### Design Philosophy

The amendment system follows these principles:
- **Accuracy**: Precise citation of amending acts
- **Flexibility**: Support for various amendment types
- **Readability**: Clear distinction between original and amended text
- **Control**: User control over amendment display

### Amendment Workflow

1. **Mark amended text** using amendment commands
2. **Provide citation** following standard format
3. **Classify amendment type** (optional)
4. **Control display** through class options

---

## Amendment Commands

### Core Amendment Command

```latex
\Amendment{current_text}{citation}[type]
```

The fundamental command for all constitutional amendments.

**Parameters:**
- `current_text`: The text as it currently appears
- `citation`: Full legal citation of the amending act
- `type`: Optional classification (insertion, substitution, omission, repeal)

**Example:**
```latex
\Amendment{not more than thirty-three other Judges}{Constitution (Forty-second Amendment) Act, 1976, s. 39 (w.e.f. 3-1-1977)}[substitution]
```

**Output:** 
- Text: [not more than thirty-three other Judges]
- Footnote: Constitution (Forty-second Amendment) Act, 1976, s. 39 (w.e.f. 3-1-1977)

### Specialized Amendment Commands

#### `\Inserted{text}{citation}`

For provisions added to the Constitution.

```latex
\Inserted{The State shall provide free and compulsory education to all children of the age of six to fourteen years in such manner as the State may, by law, determine.}{Constitution (Eighty-sixth Amendment) Act, 2002, s. 2 (w.e.f. 1-4-2010)}
```

**Use Cases:**
- New articles (Article 21A)
- New clauses within existing articles
- New parts (Part IVA)
- New schedules

#### `\Substituted{new_text}{old_text}{citation}` 

For replaced provisions showing both old and new text.

```latex
\Substituted{not more than thirty-three other Judges}{not more than seven other Judges}{Constitution (Forty-second Amendment) Act, 1976, s. 39}
```

**Features:**
- Shows current text in document
- Records original text in footnote
- Provides complete amendment history

#### `\Omitted{citation}`

For provisions removed but retaining article numbers.

```latex
\Article{Right to property}{%
    \Omitted{Constitution (Forty-fourth Amendment) Act, 1978, s. 6 (w.e.f. 20-6-1979)}%
}
```

**Behavior:**
- Only displayed when `showomitted` option is enabled
- Appears in italics with "Omitted by" text
- Maintains constitutional numbering integrity

#### `\Repealed{citation}`

For provisions completely removed from the Constitution.

```latex
\Repealed{Constitution (Forty-third Amendment) Act, 1977, s. 2 (w.e.f. 13-4-1978)}
```

**Difference from Omitted:**
- Repealed: Completely removed, no trace
- Omitted: Removed but number preserved

---

## Citation Standards

### Standard Citation Format

Constitutional amendments follow this pattern:
```
Constitution ({Ordinal} Amendment) Act, {Year}, s. {Section} (w.e.f. {Date})
```

**Components:**
- **Ordinal**: First, Second, Third, ..., Forty-second, etc.
- **Year**: Year of enactment
- **Section**: Section number of the amending act
- **Date**: Date of coming into effect (w.e.f. = with effect from)

### Citation Examples

#### Simple Amendment
```latex
Constitution (First Amendment) Act, 1951, s. 2
```

#### Amendment with Effective Date
```latex
Constitution (Forty-fourth Amendment) Act, 1978, s. 6 (w.e.f. 20-6-1979)
```

#### Multiple Section References
```latex
Constitution (Forty-second Amendment) Act, 1976, ss. 38-39 (w.e.f. 3-1-1977)
```

#### Presidential Orders (Special Cases)
```latex
Constitution (Application to Jammu and Kashmir) Order, 1954, para. 2
```

### Ordinal Number Reference

| Number | Ordinal | Number | Ordinal |
|--------|---------|--------|---------|
| 1 | First | 21 | Twenty-first |
| 2 | Second | 42 | Forty-second |
| 3 | Third | 44 | Forty-fourth |
| 10 | Tenth | 73 | Seventy-third |
| 11 | Eleventh | 74 | Seventy-fourth |
| 20 | Twentieth | 86 | Eighty-sixth |

---

## Amendment Types

### Classification System

The class supports four amendment types:

#### Insertion
- **Purpose**: Adding new provisions
- **Command**: `\Inserted{}`
- **Examples**: Article 21A, Part IVA, Article 51A

#### Substitution  
- **Purpose**: Replacing existing provisions
- **Command**: `\Substituted{}`
- **Examples**: Supreme Court judge limits, President's powers

#### Omission
- **Purpose**: Removing provisions while preserving numbering
- **Command**: `\Omitted{}`
- **Examples**: Article 31, Article 32A

#### Repeal
- **Purpose**: Complete removal of provisions
- **Command**: `\Repealed{}`
- **Examples**: Article 31D, transitional provisions

### Type-Specific Formatting

Each amendment type can have distinct formatting:

```latex
% Customizing insertion display
\renewcommand{\Inserted}[2]{%
    \textcolor{blue}{\Amendment{#1}{Inserted by #2}[insertion]}%
}

% Customizing substitution display  
\renewcommand{\Substituted}[3]{%
    \Amendment{#1}{Substituted for "#2" by #3}[substitution]%
}
```

---

## Display Control

### Class Options

Control amendment display at document level:

```latex
% Show all amendments (default)
\documentclass[showamendments]{soi}

% Hide all amendments
\documentclass[hideamendments]{soi}

% Show omitted articles
\documentclass[showomitted]{soi}

% Hide omitted articles (default)
\documentclass[hideomitted]{soi}
```

### Runtime Control

Change settings within document:

```latex
% Enable amendment display
\showamendmentstrue

% Disable amendment display  
\showamendmentsfalse

% Show omitted articles
\showomittedtrue

% Hide omitted articles
\showomittedfalse
```

### Conditional Amendments

Show amendments only in specific contexts:

```latex
% Show amendments only in draft mode
\if@draftmode
    \showamendmentstrue
\else
    \showamendmentsfalse
\fi

% Show amendments for specific parts only
\ifx\@currentparttag\@fundamentalrights
    \showamendmentstrue
\fi
```

---

## Best Practices

### Citation Accuracy

1. **Use Official Citations**
   ```latex
   % Correct
   Constitution (Eighty-sixth Amendment) Act, 2002, s. 2
   
   % Incorrect
   86th Amendment Act, 2002
   ```

2. **Include Effective Dates**
   ```latex
   % Preferred
   Constitution (Forty-fourth Amendment) Act, 1978, s. 6 (w.e.f. 20-6-1979)
   
   % Acceptable when date unknown
   Constitution (Forty-fourth Amendment) Act, 1978, s. 6
   ```

3. **Use Standard Abbreviations**
   - `s.` for section
   - `ss.` for sections (plural)
   - `w.e.f.` for "with effect from"
   - `para.` for paragraph (in orders)

### Content Organization

1. **Mark All Amendments**
   ```latex
   % Even minor word changes
   \Amendment{shall}{may}Constitution (Amendment) Act, Year, s. X}
   ```

2. **Preserve Original Context**
   ```latex
   % Show relationship between amendments
   \Substituted{current text}{original text}{First Amendment}
   \Amendment{further modified text}{Second Amendment}
   ```

3. **Group Related Amendments**
   ```latex
   % Multiple changes in single amendment act
   \Article{Supreme Court}{%
       \Clause{\Amendment{Chief Justice and thirty-three other Judges}{42nd Amendment, s. 39}}
       \Clause{\Amendment{appointment procedure}{42nd Amendment, s. 40}}
   }
   ```

### Performance Considerations

1. **Minimize Footnote Overflow**
   ```latex
   % Use pagefootnotes for amendment-heavy sections
   \documentclass[pagefootnotes]{soi}
   ```

2. **Balance Amendment Detail**
   ```latex
   % Detailed for important amendments
   \Inserted{complete text}{detailed citation}
   
   % Concise for minor changes
   \Amendment{minor change}{short citation}
   ```

---

## Common Amendment Patterns

### Fundamental Rights Amendments

```latex
% Article 19 - Freedom of speech restrictions
\Article{Protection of certain rights regarding freedom of speech, etc.}{%
    \Clause{All citizens shall have the right to freedom of speech and expression \Amendment{subject to reasonable restrictions}{Constitution (First Amendment) Act, 1951};}
}

% Article 21A - New right inserted
\Article{Right to education}{%
    \Inserted{The State shall provide free and compulsory education to all children of the age of six to fourteen years}{Constitution (Eighty-sixth Amendment) Act, 2002, s. 2}%
}
```

### Directive Principles Modifications

```latex
% Article 39A - New directive principle
\Article{Equal justice and free legal aid}{%
    \Inserted{The State shall secure that the operation of the legal system promotes justice, on a basis of equal opportunity}{Constitution (Forty-second Amendment) Act, 1976, s. 7}%
}
```

### Structural Changes

```latex
% New Part insertion
\Part{IVA}{FUNDAMENTAL DUTIES}
\Article{Fundamental duties}{%
    \Inserted{It shall be the duty of every citizen of India to abide by the Constitution and respect its ideals and institutions}{Constitution (Forty-second Amendment) Act, 1976, s. 11}%
}
```

### Panchayati Raj Insertions

```latex
% Systematic insertion of multiple articles
\DeclareArticle{243}{A}{panchayati-raj}
\Article{Gram Sabha}{%
    \Inserted{A Gram Sabha may exercise such powers and perform such functions at the village level as the Legislature of a State may, by law, provide.}{Constitution (Seventy-third Amendment) Act, 1992, s. 2}%
}
```

### Emergency Provisions Amendments

```latex
% Article 352 - National emergency modifications
\Article{Proclamation of emergency}{%
    \Clause{If the President is satisfied that a grave emergency exists whereby the security of India \Amendment{or of any part of the territory thereof}{Constitution (Forty-fourth Amendment) Act, 1978} is threatened, he may issue a Proclamation of Emergency.}
}
```

---

## Troubleshooting

### Common Issues

#### Footnote Overflow
**Problem**: Too many amendments cause footnotes to overflow page.
**Solution**: 
```latex
\documentclass[pagefootnotes]{soi}
% or
\renewcommand{\footnotesep}{0.5em} % Reduce footnote spacing
```

#### Missing Citations
**Problem**: Amendment command without proper citation.
**Solution**:
```latex
% Always provide complete citation
\Amendment{text}{Constitution (Amendment) Act, Year, s. Section}
```

#### Inconsistent Display
**Problem**: Some amendments show, others don't.
**Solution**:
```latex
% Check class options and boolean flags
\showamendmentstrue  % Ensure amendments are enabled
```

#### Wrong Amendment Type
**Problem**: Using wrong specialized command.
**Solution**:
```latex
% For new text: use \Inserted{}
% For replaced text: use \Substituted{}
% For removed text: use \Omitted{} or \Repealed{}
```

### Debug Mode

Enable debug information:
```latex
\documentclass[draft]{soi}
```

Shows:
- Amendment count in footer
- Missing citation warnings
- Footnote overflow indicators

### Validation Commands

Check amendment integrity:
```latex
% Custom validation in config.tex
\newcommand{\ValidateAmendment}[1]{%
    \ifx#1\empty
        \ClassWarning{soi}{Empty amendment citation detected}%
    \fi
}
```

### Performance Optimization

For documents with many amendments:
```latex
% Reduce memory usage
\documentclass[hideamendments]{soi} % For final version

% Optimize footnote handling
\setlength{\footnotesep}{0.4em}
\renewcommand{\footnotesize}{\small}
```

---

## Amendment Statistics

The class automatically tracks amendment statistics:

```latex
% Access amendment counts
Total Articles: \thetotalarticles
Total Amendments: \thetotalamendments  
Omitted Articles: \thetotalomitted
```

These counters help in:
- Document validation
- Performance monitoring
- Statistical analysis of constitutional changes

---

This amendment system ensures accurate tracking of constitutional changes while providing flexibility for different document requirements and display preferences.