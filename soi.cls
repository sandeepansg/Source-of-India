%% Source of India (SoI) LaTeX Document Class
%% Version 1.0
%% 
%% A comprehensive LaTeX document class for typesetting the Constitution of India
%% with sophisticated article numbering, intelligent amendment tracking, and 
%% professional legal formatting.
%%
%% Author: SoI Development Team
%% License: LaTeX Project Public License v1.3c or later
%% 
%% This work may be distributed and/or modified under the conditions of the 
%% LaTeX Project Public License, either version 1.3c of this license or 
%% (at your option) any later version.

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{soi}[2025/08/02 v1.0 Source of India Constitution Class]

%% ============================================================================
%% CLASS OPTIONS
%% ============================================================================

% Engine detection and conditional loading
\RequirePackage{iftex}

% Default options
\newif\if@showamendments\@showamendmentstrue
\newif\if@globalfootnotes\@globalfootnotestrue
\newif\if@draftmode\@draftmodefalse
\newif\if@english\@englishtrue

% Paper and font size options
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{a5paper}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{letterpaper}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}

% Amendment options
\DeclareOption{showamendments}{\@showamendmentstrue}
\DeclareOption{hideamendments}{\@showamendmentsfalse}

% Footnote options
\DeclareOption{globalfootnotes}{\@globalfootnotestrue}
\DeclareOption{pagefootnotes}{\@globalfootnotesfalse}

% Mode options
\DeclareOption{draft}{\@draftmodetrue\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{final}{\@draftmodefalse\PassOptionsToClass{\CurrentOption}{article}}

% Language options
\DeclareOption{english}{\@englishtrue}

% Default options
\ExecuteOptions{a4paper,12pt,showamendments,globalfootnotes,final,english}
\ProcessOptions\relax

%% Load base class
\LoadClass{article}

%% ============================================================================
%% PACKAGE LOADING WITH ENGINE DETECTION
%% ============================================================================

% Font handling based on engine
\ifpdftex
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{lmodern}
\else
    \ifxetex
        \RequirePackage{fontspec}
        \IfFontExistsTF{Libertinus Serif}{
            \setmainfont{Libertinus Serif}[Ligatures=TeX, Numbers=OldStyle]
        }{
            \setmainfont{Latin Modern Roman}[Ligatures=TeX]
        }
    \else
        \ifluatex
            \RequirePackage{fontspec}
            \RequirePackage{luatextra}
            \IfFontExistsTF{Libertinus Serif}{
                \setmainfont{Libertinus Serif}[Ligatures=TeX, Numbers=OldStyle]
            }{
                \setmainfont{Latin Modern Roman}[Ligatures=TeX]
            }
        \fi
    \fi
\fi

% Core packages
\RequirePackage{geometry}
\RequirePackage{xparse}
\RequirePackage{fancyhdr}
\RequirePackage{needspace}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{footnote}
\RequirePackage{hyperref}

%% ============================================================================
%% PAGE LAYOUT AND GEOMETRY
%% ============================================================================

\geometry{
    a4paper,
    top=2.5cm,
    bottom=2.5cm,
    left=3cm,
    right=2.5cm,
    headheight=14pt,
    headsep=20pt,
    footskip=25pt
}

%% ============================================================================
%% COUNTERS AND VARIABLES
%% ============================================================================

% Article numbering counters
\newcounter{articlebase}
\newcounter{articlesuffix}
\newcounter{articlesubsuffix}
\newcounter{totalarticles}
\newcounter{totalamendments}

% Structure counters
\newcounter{partcounter}
\newcounter{chaptercounter}
\newcounter{schedulecounter}
\newcounter{clausecounter}
\newcounter{subclausecounter}
\newcounter{subsubclausecounter}

% Current article information
\def\@currentarticlenum{}
\def\@currentarticlesuffix{}
\def\@currentarticlesubsuffix{}
\def\@displaynumber{}
\def\@currentarticledisplay{}
\def\@currentcontextname{}
\def\@currentpartname{}
\def\@currentpartfull{}
\def\@currentchaptername{}
\def\@currentschedulename{}
\def\@currentschedulefull{}

%% ============================================================================
%% UTILITY FUNCTIONS
%% ============================================================================

% Check if argument is integer
\newcommand{\IfInteger}[3]{%
    \if\relax\detokenize\expandafter{\romannumeral-0#1}\relax
        #3% Not integer
    \else
        #2% Is integer
    \fi
}

% Check if string contains substring
\makeatletter
\newcommand{\IfSubStr}[4]{%
    \def\@tempa{#1}%
    \def\@tempb{#2}%
    \ifx\@tempa\@empty
        #4%
    \else
        \expandafter\@IfSubStr\@tempa\@nil{#2}{#3}{#4}%
    \fi
}
\def\@IfSubStr#1#2\@nil#3#4#5{%
    \def\@tempc{#1#2}%
    \def\@tempd{#3}%
    \ifx\@tempc\@tempd
        #4%
    \else
        \ifx#2\@empty
            #5%
        \else
            \@IfSubStr#2\@nil{#3}{#4}{#5}%
        \fi
    \fi
}
\makeatother

%% ============================================================================
%% ARTICLE NUMBERING SYSTEM
%% ============================================================================

% Declare article with sophisticated numbering
\NewDocumentCommand{\DeclareArticle}{m m m}{%
    \IfInteger{#1}{%
        \def\@currentarticlenum{#1}%
        \def\@currentarticlesuffix{#2}%
        \def\@currentarticlesubsuffix{#3}%
        \GenerateDisplayNumber{#1}{#2}{#3}%
        \UpdateHeaders%
        \stepcounter{totalarticles}%
        \setcounter{clausecounter}{0}%
        \setcounter{subclausecounter}{0}%
        \setcounter{subsubclausecounter}{0}%
    }{%
        \ClassError{soi}{Article number must be integer}{%
            Use \protect\DeclareArticle{number}{suffix1}{suffix2} with numeric first argument.%
        }%
    }%
}

% Generate display number from components
\newcommand{\GenerateDisplayNumber}[3]{%
    % #1 = base number, #2 = suffix1, #3 = suffix2
    \def\@displaynumber{#1\ifx#2\empty\else#2\fi\ifx#3\empty\else#3\fi}%
    \def\@currentarticledisplay{Article \@displaynumber}%
    
    % Validate suffix combinations
    \ifx#2\empty\else
        \IfSubStr{ABCDEFGHIJKLMNOPQRSTUVWXYZ}{#2}{}{%
            \ClassWarning{soi}{Invalid suffix '#2' - should be A-Z}%
        }%
    \fi
    
    % Update internal counters
    \setcounter{articlebase}{#1}%
    \ifx#2\empty
        \setcounter{articlesuffix}{0}%
    \else
        \setcounter{articlesuffix}{\numexpr`#2-64\relax}%
    \fi
}

%% ============================================================================
%% AMENDMENT SYSTEM
%% ============================================================================

% Amendment display configuration
\newcommand{\amendmentopen}{[}
\newcommand{\amendmentclose}{]}

% Core amendment command with precise positioning
\NewDocumentCommand{\Amendment}{m m}{%
    \if@showamendments
        \makesavenoteenv{footnote}%
        \raisebox{0.7ex}{\scriptsize\footnotemark}%
        \amendmentopen#1\amendmentclose%
        \footnotetext{#2}%
        \stepcounter{totalamendments}%
    \else
        #1%
    \fi
}

% Protected amendment with page break management
\NewDocumentCommand{\ProtectedAmendment}{m m}{%
    \needspace{3\baselineskip}%
    \Amendment{#1}{#2}%
    \nopagebreak[3]%
}

%% ============================================================================
%% STRUCTURE COMMANDS
%% ============================================================================

% Typography sizes (customizable)
\newcommand{\partsize}{\LARGE}
\newcommand{\chaptersize}{\Large}
\newcommand{\articlesize}{\normalsize}
\newcommand{\groupsize}{\large}
\newcommand{\subgroupsize}{\normalsize}
\newcommand{\headingsize}{\normalsize}
\newcommand{\subheadingsize}{\small}
\newcommand{\schedulesize}{\LARGE}

% Part command
\NewDocumentCommand{\Part}{m m}{%
    \def\@currentpartname{Part #1}%
    \def\@currentpartfull{Part #1: #2}%
    \def\@currentcontextname{#2}%
    \UpdateHeaders%
    \needspace{4\baselineskip}%
    \phantomsection%
    \addcontentsline{toc}{part}{Part #1: #2}%
    {\partsize\bfseries Part #1}\\[0.5ex]%
    {\Large\bfseries #2}\par%
    \addvspace{2\baselineskip}%
    \stepcounter{partcounter}%
}

% Chapter command
\NewDocumentCommand{\Chapter}{m m}{%
    \def\@currentchaptername{Chapter #1}%
    \def\@currentcontextname{#2}%
    \UpdateHeaders%
    \needspace{3\baselineskip}%
    \phantomsection%
    \addcontentsline{toc}{chapter}{Chapter #1: #2}%
    {\chaptersize\bfseries Chapter #1: #2}\par%
    \addvspace{1.5\baselineskip}%
    \stepcounter{chaptercounter}%
}

% Group and subgroup commands
\NewDocumentCommand{\Group}{m}{%
    \needspace{2\baselineskip}%
    {\groupsize\bfseries #1}\par%
    \addvspace{0.5\baselineskip}%
}

\NewDocumentCommand{\SubGroup}{m}{%
    \needspace{2\baselineskip}%
    {\subgroupsize\bfseries #1}\par%
    \addvspace{0.3\baselineskip}%
}

% Heading commands
\NewDocumentCommand{\Heading}{m}{%
    \needspace{2\baselineskip}%
    {\headingsize\bfseries #1}\par%
    \addvspace{0.3\baselineskip}%
}

\NewDocumentCommand{\SubHeading}{m}{%
    \needspace{1.5\baselineskip}%
    {\subheadingsize\bfseries #1}\par%
    \addvspace{0.2\baselineskip}%
}

% Article command with smart space management
\NewDocumentCommand{\Article}{m +m}{%
    \needspace{4\baselineskip}%
    \phantomsection%
    \addcontentsline{toc}{section}{\@displaynumber: #1}%
    \noindent{\articlesize\bfseries \@displaynumber\quad #1}\par%
    \addvspace{0.5\baselineskip}%
    #2\par%
    \addvspace{1\baselineskip}%
}

% Clause hierarchy
\NewDocumentCommand{\Clause}{+m}{%
    \stepcounter{clausecounter}%
    \par\hangindent=2em\noindent(\arabic{clausecounter})\quad #1%
}

\NewDocumentCommand{\SubClause}{+m}{%
    \stepcounter{subclausecounter}%
    \par\hangindent=3em\noindent(\alph{subclausecounter})\quad #1%
}

\NewDocumentCommand{\SubSubClause}{+m}{%
    \stepcounter{subsubclausecounter}%
    \par\hangindent=4em\noindent(\roman{subsubclausecounter})\quad #1%
}

% Schedule support
\NewDocumentCommand{\Schedule}{m m +m}{%
    \def\@currentschedulename{Schedule #1}%
    \def\@currentschedulefull{Schedule #1: #2}%
    \def\@currentcontextname{#2}%
    \UpdateHeaders%
    \phantomsection%
    \addcontentsline{toc}{part}{Schedule #1: #2}%
    \needspace{4\baselineskip}%
    {\schedulesize\bfseries Schedule #1}\\[0.5ex]%
    {\Large\bfseries #2}\par%
    \addvspace{2\baselineskip}%
    #3%
    \stepcounter{schedulecounter}%
}

\NewDocumentCommand{\SchedulePart}{m m}{%
    \needspace{3\baselineskip}%
    {\Large\bfseries Part #1: #2}\par%
    \addvspace{1\baselineskip}%
}

\NewDocumentCommand{\ScheduleList}{m m}{%
    \needspace{2\baselineskip}%
    {\large\bfseries #1. #2}\par%
    \addvspace{0.5\baselineskip}%
}

%% ============================================================================
%% HEADER AND FOOTER SYSTEM
%% ============================================================================

\pagestyle{fancy}
\fancyhf{}

\newcommand{\UpdateHeaders}{%
    \fancyhf{}%
    
    \fancyhead[L]{\small\@currentarticledisplay}%
    \fancyhead[R]{\small\itshape\@currentcontextname}%
    \fancyfoot[C]{\thepage}%
    
    \if@draftmode
        \fancyfoot[L]{\tiny Total Articles: \thetotalarticles}%
        \fancyfoot[R]{\tiny Amendments: \thetotalamendments}%
    \fi
}

% Update headers initially
\UpdateHeaders

%% ============================================================================
%% HYPERREF CONFIGURATION
%% ============================================================================

\hypersetup{
    pdftitle={The Constitution of India},
    pdfauthor={Government of India},
    pdfsubject={Constitutional Document with Amendments},
    pdfkeywords={Constitution, India, Legal, Amendments, Constitutional Law},
    colorlinks=true,
    linkcolor=blue,
    urlcolor=blue,
    filecolor=blue,
    citecolor=blue,
    bookmarksnumbered=true,
    bookmarksopen=true,
    pdfpagelayout=TwoPageRight,
    pdfstartview=FitH
}

%% ============================================================================
%% TYPOGRAPHY AND SPACING
%% ============================================================================

% Paragraph spacing
\setlength{\parskip}{0.6em plus 0.1em minus 0.1em}
\setlength{\parindent}{0pt}

% Line spacing
\renewcommand{\baselinestretch}{1.1}

% Footnote configuration
\if@globalfootnotes
    % Global footnote numbering (default)
\else
    % Per-page footnote numbering
    \@addtoreset{footnote}{page}
\fi

% Footnote formatting
\renewcommand{\thefootnote}{\arabic{footnote}}
\setlength{\footnotesep}{0.7em}
\renewcommand{\footnoterule}{%
    \kern-3pt%
    \hrule width 0.4\columnwidth height 0.4pt%
    \kern 2.6pt%
}

%% ============================================================================
%% FRONT MATTER COMMANDS
%% ============================================================================

% Front cover command
\newcommand{\soifrontcover}{%
    \input{content/covers/front}%
    \newpage%
}

% Table of contents command
\newcommand{\soitableofcontents}{%
    \input{content/toc}%
    \newpage%
}

% Preamble command
\newcommand{\soipreamble}{%
    \input{content/preamble}%
    \newpage%
}

% Back cover command
\newcommand{\soibackcover}{%
    \input{content/covers/back}%
}

%% ============================================================================
%% ERROR HANDLING AND WARNINGS
%% ============================================================================

% Warning system
\newcommand{\soiwarning}[1]{%
    \ClassWarning{soi}{#1}%
}

% Error reporting
\newcommand{\soierror}[2]{%
    \ClassError{soi}{#1}{#2}%
}

%% ============================================================================
%% END OF CLASS
%% ============================================================================

\endinput

%% End of file `soi.cls'.