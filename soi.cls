%% Source of India LaTeX Document Class v1.1
%% For typesetting the Constitution of India
%% Author: Sandeepan Sengupta
%% License: LaTeX Project Public License v1.3c

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{soi}[2023/08/01 v1.1 Source of India Constitution Class - Fixed Version]

%% Class options processing
\newif\if@showamendments\@showamendmentstrue
\newif\if@showomitted\@showomittedfalse
\newif\if@globalfootnotes\@globalfootnotestrue
\newif\if@draftmode\@draftmodefalse

\DeclareOption{showamendments}{\@showamendmentstrue}
\DeclareOption{hideamendments}{\@showamendmentsfalse}
\DeclareOption{showomitted}{\@showomittedtrue}
\DeclareOption{hideomitted}{\@showomittedfalse}
\DeclareOption{globalfootnotes}{\@globalfootnotestrue}
\DeclareOption{pagefootnotes}{\@globalfootnotesfalse}
\DeclareOption{draft}{\@draftmodetrue\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{final}{\@draftmodefalse\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

%% Load base class with two-sided layout
\LoadClass[12pt,a4paper,twoside]{article}

%% Engine detection and font setup
\RequirePackage{iftex}
\ifpdftex
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{lmodern}
\else
    \ifxetex
        \RequirePackage{fontspec}
        \IfFontExistsTF{Libertinus Serif}{
            \setmainfont{Libertinus Serif}
        }{
            \setmainfont{Latin Modern Roman}
        }
    \else
        \ifluatex
            \RequirePackage{fontspec}
            \RequirePackage{luatextra}
            \IfFontExistsTF{Libertinus Serif}{
                \setmainfont{Libertinus Serif}
            }{
                \setmainfont{Latin Modern Roman}
            }
        \fi
    \fi
\fi

%% Required packages
\RequirePackage{geometry}
\RequirePackage{xparse}
\RequirePackage{fancyhdr}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{footnote}
\RequirePackage{hyperref}
\RequirePackage{xstring}
\RequirePackage{etoolbox}
\RequirePackage{afterpage}
\RequirePackage{changepage}
\RequirePackage{calc}
\RequirePackage{enumitem}
\RequirePackage{titletoc}
\RequirePackage{needspace}
\RequirePackage{footmisc}
\RequirePackage{perpage}
\RequirePackage{lastpage}
\RequirePackage{xcolor}

%% Two-sided page geometry with binding offset
\geometry{
    twoside,
    bindingoffset=0.5cm,
    inner=3cm,
    outer=2.5cm,
    top=2.5cm,
    bottom=2.5cm,
    headheight=14pt,
    headsep=20pt,
    footskip=25pt,
    heightrounded
}

%% Typography settings
\setlength{\parskip}{0.6em plus 0.1em minus 0.1em}
\setlength{\parindent}{0pt}
\renewcommand{\baselinestretch}{1.1}

%% Enhanced footnote configuration with improved spacing
\setlength{\footnotesep}{0.8em}
\setlength{\skip\footins}{1.2em plus 0.4em minus 0.2em}

%% Improved footnote rule with proper spacing
\renewcommand{\footnoterule}{%
    \kern-3pt
    \vspace{0.5em}%
    \hrule width 0.4\columnwidth height 0.4pt
    \vspace{0.3em}%
    \kern 2.6pt
}

%% Footnote numbering per page for amendments
\if@globalfootnotes
    % Global footnote numbering (default)
\else
    \MakePerPage{footnote}
\fi

%% Enhanced footnote formatting for amendments
\renewcommand{\footnotelayout}{\footnotesize\raggedright}
\setlength{\footnotemargin}{1em}

%% Counters
\newcounter{articlenumber}
\newcounter{partnumber}
\newcounter{schedulenumber}
\newcounter{totalarticles}
\newcounter{totalamendments}
\newcounter{totalomitted}

%% Internal variables
\def\@currentarticlenum{}
\def\@currentarticlesuffix{}
\def\@currentarticledisplay{}
\def\@currentparttitle{}
\def\@currentarticletitle{}

%% Amendment display configuration
\newcommand{\amendmentopen}{[}
\newcommand{\amendmentclose}{]}

%% Size commands
\newcommand{\partsize}{\LARGE}
\newcommand{\articlesize}{\normalsize}
\newcommand{\headingsize}{\normalsize}
\newcommand{\tagsize}{\normalsize}

%% Utility functions
\newcommand{\toroman}[1]{%
    \ifcase#1\or I\or II\or III\or IV\or V\or VI\or VII\or VIII\or IX\or X%
    \or XI\or XII\or XIII\or XIV\or XV\or XVI\or XVII\or XVIII\or XIX\or XX%
    \or XXI\or XXII\else\@ctrerr\fi%
}

%% Enhanced page break management for constitutional elements
\newcommand{\constitutionalbreak}[1]{%
    \needspace{#1\baselineskip}%
}

%% Article declaration system
\newcommand{\DeclareArticle}[3]{%
    \stepcounter{totalarticles}%
    \def\@currentarticlenum{#1}%
    \def\@currentarticlesuffix{#2}%
    \ifx\@currentarticlesuffix\empty
        \def\@currentarticledisplay{Article #1}%
    \else
        \def\@currentarticledisplay{Article #1#2}%
    \fi
    % Reset clause counters for each article
    \setcounter{clausecounter}{0}%
}

%% Part declaration system
\newcommand{\DeclarePart}[2]{%
    \stepcounter{partnumber}%
    \def\@currentparttitle{#2}%
}

%% Schedule declaration system
\newcommand{\DeclareSchedule}[2]{%
    \stepcounter{schedulenumber}%
}

%% FIXED AMENDMENT SYSTEM - Corrected logic and positioning

%% General amendment command
\newcommand{\Amendment}[3][]{%
    \if@showamendments
        #2\footnote{#3}%
        \stepcounter{totalamendments}%
    \else
        #2%
    \fi
}

%% Fixed Inserted command - text in main, citation in footnote
\newcommand{\Inserted}[2]{%
    \if@showamendments
        \amendmentopen#1\amendmentclose\footnote{Inserted by: #2}%
        \stepcounter{totalamendments}%
    \else
        #1%
    \fi
}

%% Fixed Substituted command - new text in main, old text and citation in footnote
\newcommand{\Substituted}[3]{%
    \if@showamendments
        \amendmentopen#1\amendmentclose\footnote{Substituted for ``#2'' by: #3}%
        \stepcounter{totalamendments}%
    \else
        #1%
    \fi
}

%% Fixed Omitted command - shows only citation in footnote when showing omitted
\newcommand{\Omitted}[1]{%
    \if@showomitted
        \amendmentopen\textit{Omitted}\amendmentclose\footnote{Omitted by: #1}%
        \stepcounter{totalomitted}%
    \fi
}

%% Fixed Repealed command
\newcommand{\Repealed}[1]{%
    \if@showomitted
        \amendmentopen\textit{Repealed}\amendmentclose\footnote{Repealed by: #1}%
        \stepcounter{totalomitted}%
    \fi
}

%% Constitutional section heading command with proper spacing and typography
\newcommand{\ConstitutionalSection}[1]{%
    \needspace{4\baselineskip}%
    \vspace{1em plus 0.3em minus 0.2em}%
    {\centering\normalsize\bfseries #1\par}%
    \nopagebreak[4]%
    \vspace{0.7em plus 0.2em minus 0.1em}%
}

%% Structural commands with enhanced page management
\newcommand{\Part}[2]{%
    \clearpage%
    \constitutionalbreak{5}%
    \vspace{2\baselineskip}%
    {\centering\partsize\bfseries PART #1\\[0.5\baselineskip]#2\par}%
    \vspace{\baselineskip}%
    \def\@currentparttitle{#2}%
    \markboth{PART #1: #2}{PART #1: #2}%
    \addcontentsline{toc}{part}{PART #1: #2}%
}

%% Enhanced Article command with better page break management
\newcommand{\Article}[2]{%
    \needspace{6\baselineskip}% Ensure article and potential heading stay together
    \vspace{\baselineskip}%
    {\articlesize\bfseries\@currentarticledisplay. #1}\par%
    \nopagebreak[4]%
    \vspace{0.5\baselineskip}%
    #2\par%
    \def\@currentarticletitle{#1}%
    \markright{\@currentarticledisplay: #1}%
    \addcontentsline{toc}{subsection}{\@currentarticledisplay. #1}%
}

\newcommand{\Schedule}[3]{%
    \clearpage%
    \constitutionalbreak{5}%
    \vspace{2\baselineskip}%
    {\centering\partsize\bfseries #1 SCHEDULE\\[0.5\baselineskip]#2\par}%
    \vspace{\baselineskip}%
    #3\par%
    \addcontentsline{toc}{section}{#1 SCHEDULE: #2}%
}

%% Clause and sub-clause commands with enhanced page management
\newcounter{clausecounter}
\newcounter{subclausecounter}[clausecounter]
\newcounter{subsubclausecounter}[subclausecounter]

\newcommand{\Clause}[1]{%
    \needspace{3\baselineskip}%
    \stepcounter{clausecounter}%
    \par(\theclausecounter) #1\par%
}

\newcommand{\SubClause}[1]{%
    \needspace{2\baselineskip}%
    \stepcounter{subclausecounter}%
    \par(\alph{subclausecounter}) #1\par%
}

\newcommand{\SubSubClause}[1]{%
    \needspace{2\baselineskip}%
    \stepcounter{subsubclausecounter}%
    \par(\roman{subsubclausecounter}) #1\par%
}

%% Special amendment commands for clauses with bracket positioning

%% Inserted clause with clause number in brackets
\newcommand{\InsertedClause}[2]{%
    \if@showamendments
        \needspace{3\baselineskip}%
        \stepcounter{clausecounter}%
        \par\amendmentopen(\theclausecounter)\amendmentclose\ #1\footnote{Inserted by: #2}\par%
        \stepcounter{totalamendments}%
    \else
        \Clause{#1}%
    \fi
}

%% Omitted clause showing clause number in brackets
\newcommand{\OmittedClause}[1]{%
    \if@showomitted
        \needspace{2\baselineskip}%
        \stepcounter{clausecounter}%
        \par\amendmentopen(\theclausecounter)\amendmentclose\footnote{Omitted by: #1}\par%
        \stepcounter{totalomitted}%
    \fi
}

%% Two-sided header and footer setup
\pagestyle{fancy}
\fancyhf{}

%% Two-sided headers with article names on outer margins
\fancyhead[LE]{\small\leftmark}    % Left header on even pages (part info)
\fancyhead[RO]{\small\rightmark}   % Right header on odd pages (article info)
\fancyhead[LO,RE]{\small\itshape Constitution of India}  % Inner headers

%% Footer with page numbers
\fancyfoot[C]{\thepage}

\if@draftmode
    \fancyfoot[LE]{\tiny Articles: \thetotalarticles}
    \fancyfoot[RO]{\tiny Amendments: \thetotalamendments}
\fi

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

%% Table of contents customization
\renewcommand{\contentsname}{Contents}
\setcounter{tocdepth}{2}

%% Part entries in TOC
\titlecontents{part}[0pt]
    {\addvspace{1.5pc}\large\bfseries}
    {PART \thecontentslabel\quad}
    {}
    {\hfill\contentspage}
    [\addvspace{0.5pc}]

%% Section entries (for schedules)
\titlecontents{section}[1.5em]
    {\addvspace{0.5pc}\normalsize\bfseries}
    {\contentslabel{1.5em}}
    {\hspace*{-1.5em}}
    {\titlerule*[0.5pc]{.}\contentspage}

%% Subsection entries (for articles)
\titlecontents{subsection}[3.8em]
    {\normalsize}
    {\contentslabel{3.8em}}
    {\hspace*{-3.8em}}
    {\titlerule*[0.5pc]{.}\contentspage}

%% Hyperref setup
\AtEndOfClass{%
    \hypersetup{
        colorlinks=true,
        linkcolor=black,
        filecolor=black,
        urlcolor=black,
        citecolor=black,
        pdfpagemode=UseNone,
        pdfstartview=FitH,
        pdftitle={Constitution of India},
        pdfauthor={Government of India},
        pdfsubject={Constitutional Document},
        pdfkeywords={Constitution, India, Law, Legal}
    }
}

%% Warning and error commands
\newcommand{\soiwarning}[1]{\ClassWarning{soi}{#1}}
\newcommand{\soierror}[2]{\ClassError{soi}{#1}{#2}}

%% Boolean flags for user control
\newif\ifshowamendments
\newif\ifshowomitted

% Initialize based on class options
\if@showamendments\showamendmentstrue\else\showamendmentsfalse\fi
\if@showomitted\showomittedtrue\else\showomittedfalse\fi

%% Special constitutional formatting helpers
\newcommand{\Proviso}[1]{%
    \needspace{3\baselineskip}%
    \par\textit{Provided that} #1%
}

\newcommand{\Explanation}[1]{%
    \needspace{3\baselineskip}%
    \par\textit{Explanation.---}#1%
}

\newcommand{\Exception}[1]{%
    \needspace{3\baselineskip}%
    \par\textit{Exception.---}#1%
}

%% Special constitutional symbols and abbreviations
\newcommand{\etc}{\textit{etc.}}
\newcommand{\viz}{\textit{viz.}}
\newcommand{\ie}{\textit{i.e.}}
\newcommand{\eg}{\textit{e.g.}}

%% Date formatting for constitutional amendments
\newcommand{\wef}[1]{(w.e.f.~#1)}  % "with effect from"

%% List environment customization for constitutional text
\setlist[enumerate,1]{label=(\arabic*), leftmargin=2em}
\setlist[enumerate,2]{label=(\alph*), leftmargin=2em}
\setlist[enumerate,3]{label=(\roman*), leftmargin=2em}

%% Enhanced page break control for footnotes
\interfootnotelinepenalty=10000

%% Enhanced widow and orphan control
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

%% Enhanced space management between text and footnotes
\addtolength{\textheight}{-\footskip}
\addtolength{\textheight}{\footnotesep}

%% End of class