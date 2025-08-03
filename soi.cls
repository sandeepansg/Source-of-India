%% Source of India LaTeX Document Class v1.0
%% For typesetting the Constitution of India
%% Author: Sandeepan Sengupta
%% License: LaTeX Project Public License v1.3c

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{soi}[2023/08/01 v1.0 Source of India Constitution Class]

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

%% Load base class
\LoadClass[12pt,a4paper]{article}

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

%% Page geometry with optimized footnote space
\geometry{
    top=2.5cm,
    bottom=2.5cm,
    left=3cm,
    right=2.5cm,
    headheight=14pt,
    headsep=20pt,
    footskip=25pt,
    heightrounded
}

%% Typography settings
\setlength{\parskip}{0.6em plus 0.1em minus 0.1em}
\setlength{\parindent}{0pt}
\renewcommand{\baselinestretch}{1.1}

%% Footnote configuration for optimal page space usage
\setlength{\footnotesep}{0.7em}
\setlength{\skip\footins}{1em plus 0.3em minus 0.1em}
\renewcommand{\footnoterule}{%
    \kern-3pt
    \hrule width 0.4\columnwidth
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

%% Page break management for constitutional elements
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

%% Enhanced amendment system with page management
\newcommand{\Amendment}[3][]{%
    \if@showamendments
        #2\footnote{#3}%
        \stepcounter{totalamendments}%
    \else
        #2%
    \fi
}

\newcommand{\Inserted}[2]{%
    \if@showamendments
        \amendmentopen#2\amendmentclose\footnote{Inserted: #1}%
        \stepcounter{totalamendments}%
    \else
        #2%
    \fi
}

\newcommand{\Substituted}[3]{%
    \if@showamendments
        \amendmentopen#1\amendmentclose\footnote{Substituted for ``#2'' by #3}%
        \stepcounter{totalamendments}%
    \else
        #1%
    \fi
}

\newcommand{\Omitted}[1]{%
    \if@showomitted
        \textit{[Omitted by #1]}%
        \stepcounter{totalomitted}%
    \fi
}

\newcommand{\Repealed}[1]{%
    \if@showomitted
        \textit{[Repealed by #1]}%
        \stepcounter{totalomitted}%
    \fi
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

\newcommand{\Article}[2]{%
    \constitutionalbreak{4}%
    \vspace{\baselineskip}%
    {\articlesize\bfseries\@currentarticledisplay. #1}\par%
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

%% Clause and sub-clause commands with page management
\newcounter{clausecounter}
\newcounter{subclausecounter}[clausecounter]
\newcounter{subsubclausecounter}[subclausecounter]

\newcommand{\Clause}[1]{%
    \constitutionalbreak{2}%
    \stepcounter{clausecounter}%
    \par(\theclausecounter) #1\par%
}

\newcommand{\SubClause}[1]{%
    \constitutionalbreak{2}%
    \stepcounter{subclausecounter}%
    \par(\alph{subclausecounter}) #1\par%
}

\newcommand{\SubSubClause}[1]{%
    \constitutionalbreak{2}%
    \stepcounter{subsubclausecounter}%
    \par(\roman{subsubclausecounter}) #1\par%
}

%% Header and footer setup
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\leftmark}
\fancyhead[R]{\small\itshape Constitution of India}
\fancyfoot[C]{\thepage}

\if@draftmode
    \fancyfoot[L]{\tiny Articles: \thetotalarticles}
    \fancyfoot[R]{\tiny Amendments: \thetotalamendments}
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
    \constitutionalbreak{2}%
    \par\textit{Provided that} #1%
}

\newcommand{\Explanation}[1]{%
    \constitutionalbreak{2}%
    \par\textit{Explanation.---}#1%
}

\newcommand{\Exception}[1]{%
    \constitutionalbreak{2}%
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

%% Widow and orphan control
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

%% Enhanced space management between text and footnotes
\addtolength{\textheight}{-\footskip}
\addtolength{\textheight}{\footnotesep}

%% End of class