%% Source of India LaTeX Document Class v1.0
%% For typesetting the Constitution of India
%% Author: Sandeepan Sengupta
%% License: LaTeX Project Public License v1.3c

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{soi}[2025/08/01 v1.0 Source of India Constitution Document Class]

%% Class options processing
\newif\if@soishowamendments\@soishowamendmentstrue
\newif\if@soidraftmode\@soidraftmodefalse
\newif\if@soivalidpapersize\@soivalidpapersizefalse

%% Paper size validation
\DeclareOption{a4paper}{\@soivalidpapersizetrue\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{a5paper}{\@soivalidpapersizetrue\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{letterpaper}{\ClassWarning{soi}{Only A4 and A5 paper sizes supported. Using A4 instead.}\PassOptionsToClass{a4paper}{article}}
\DeclareOption{legalpaper}{\ClassWarning{soi}{Only A4 and A5 paper sizes supported. Using A4 instead.}\PassOptionsToClass{a4paper}{article}}
\DeclareOption{executivepaper}{\ClassWarning{soi}{Only A4 and A5 paper sizes supported. Using A4 instead.}\PassOptionsToClass{a4paper}{article}}

%% Amendment and mode options
\DeclareOption{showamendments}{\@soishowamendmentstrue}
\DeclareOption{hideamendments}{\@soishowamendmentsfalse}
\DeclareOption{draft}{\@soidraftmodetrue\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{final}{\@soidraftmodefalse\PassOptionsToClass{\CurrentOption}{article}}

%% Pass other options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

%% Issue warning if no valid paper size was specified
\if@soivalidpapersize\else
    \ClassWarning{soi}{No valid paper size specified. Only A4 and A5 are supported. Using A4.}
    \PassOptionsToClass{a4paper}{article}
\fi

%% Load base class
\LoadClass[12pt,twoside]{article}

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
\RequirePackage{needspace}
\RequirePackage{footmisc}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{enumitem}
\RequirePackage{titletoc}
\RequirePackage{hyperref}
\RequirePackage{afterpage}
\RequirePackage{changepage}
\RequirePackage{ifthen}

%% Geometry setup for two-sided layout
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

%% Enhanced footnote configuration
\setlength{\footnotesep}{0.8em}
\setlength{\skip\footins}{1.2em plus 0.4em minus 0.2em}

%% Improved footnote rule
\renewcommand{\footnoterule}{%
    \kern-3pt
    \vspace{0.5em}%
    \hrule width 0.4\columnwidth height 0.4pt
    \vspace{0.3em}%
    \kern 2.6pt
}

%% Counters
\newcounter{soipartnumber}
\newcounter{soiarticlenumber} 
\newcounter{soischedulenumber}
\newcounter{soiamendmentcounter}

%% Current context variables for headers (two-sided aware)
\def\@soicurrentpart{}
\def\@soicurrentarticle{}
\def\@soicurrentschedule{}
\def\@soicurrentcontext{}

%% Amendment footnote counter
\newcounter{soiamendmentfootnote}

%% Clause counters with proper resetting
\newcounter{soiclausecounter}
\newcounter{soisubclausecounter}[soiclausecounter]
\newcounter{soisubsubclausecounter}[soisubclausecounter]

%% Core amendment system with modern naming
\newcommand{\soiAmendment}[1]{%
    \if@soishowamendments
        \stepcounter{soiamendmentfootnote}%
        [{#1}\footnotemark[\thesoiamendmentfootnote]%
    \else
        #1%
    \fi
}

\newcommand{\soiAmendmentData}[1]{%
    \if@soishowamendments
        \footnotetext[\thesoiamendmentfootnote]{#1}%
    \fi
}

%% Sophisticated page management for amendments
\newcommand{\soiAmendmentBlock}[2]{%
    \if@soishowamendments
        \needspace{4\baselineskip}%
        \stepcounter{soiamendmentfootnote}%
        [{#1}\footnotemark[\thesoiamendmentfootnote]]%
        \footnotetext[\thesoiamendmentfootnote]{#2}%
    \else
        #1%
    \fi
}

%% Utility for space management
\newcommand{\soiNeedSpace}[1]{\needspace{#1}}

%% Part command with header updating
\newcommand{\soiPart}[2]{%
    \cleardoublepage
    \stepcounter{soipartnumber}%
    \def\@soicurrentpart{PART #1}%
    \def\@soicurrentarticle{}%
    \def\@soicurrentschedule{}%
    \def\@soicurrentcontext{PART #1}%
    \vspace*{2\baselineskip}%
    {\centering\LARGE\bfseries PART #1\\[0.5\baselineskip]#2\par}%
    \vspace{\baselineskip}%
    \markboth{PART #1}{PART #1}%
    \addcontentsline{toc}{part}{PART #1: #2}%
}

%% Article command with header updating and page management
\newcommand{\soiArticle}[2]{%
    \needspace{6\baselineskip}%
    \stepcounter{soiarticlenumber}%
    \def\@soicurrentarticle{Art. \thesoiarticlenumber}%
    \vspace{\baselineskip}%
    {\normalsize\bfseries\thesoiarticlenumber. #1}\par%
    \nopagebreak[4]%
    \vspace{0.5\baselineskip}%
    \setcounter{soiclausecounter}{0}% Reset clause counter for each article
    #2\par%
    \markright{Art. \thesoiarticlenumber}%
    \addcontentsline{toc}{subsection}{Article \thesoiarticlenumber. #1}%
}

%% Schedule command with header updating
\newcommand{\soiSchedule}[2]{%
    \cleardoublepage
    \stepcounter{soischedulenumber}%
    \def\@soicurrentschedule{Sch. \soiToRoman{\thesoischedulenumber}}%
    \def\@soicurrentarticle{}%
    \def\@soicurrentcontext{#1 SCHEDULE}%
    \vspace*{2\baselineskip}%
    {\centering\LARGE\bfseries #1 SCHEDULE\\[0.5\baselineskip]#2\par}%
    \vspace{\baselineskip}%
    \markboth{#1 SCHEDULE}{#1 SCHEDULE}%
    \addcontentsline{toc}{section}{#1 SCHEDULE: #2}%
}

%% Roman numeral converter for schedules
\newcommand{\soiToRoman}[1]{%
    \ifcase#1\or I\or II\or III\or IV\or V\or VI\or VII\or VIII\or IX\or X%
    \or XI\or XII\or XIII\or XIV\or XV\or XVI\or XVII\or XVIII\or XIX\or XX%
    \else\@ctrerr\fi%
}

%% Clause commands with proper indentation
\newcommand{\soiClause}[1]{%
    \needspace{3\baselineskip}%
    \stepcounter{soiclausecounter}%
    \par\hangindent=2em\hangafter=1 (\thesoiclausecounter) #1\par%
}

\newcommand{\soiSubClause}[1]{%
    \needspace{2\baselineskip}%
    \stepcounter{soisubclausecounter}%
    \par\hangindent=3em\hangafter=1\hspace{1em}(\alph{soisubclausecounter}) #1\par%
}

\newcommand{\soiSubSubClause}[1]{%
    \needspace{2\baselineskip}%
    \stepcounter{soisubsubclausecounter}%
    \par\hangindent=4em\hangafter=1\hspace{2em}(\roman{soisubsubclausecounter}) #1\par%
}

%% Special constitutional elements
\newcommand{\soiProviso}[1]{%
    \needspace{3\baselineskip}%
    \par\hangindent=2em\hangafter=1\textit{Provided that} #1\par%
}

\newcommand{\soiExplanation}[1]{%
    \needspace{3\baselineskip}%
    \par\hangindent=2em\hangafter=1\textit{Explanation.---}#1\par%
}

\newcommand{\soiException}[1]{%
    \needspace{3\baselineskip}%
    \par\hangindent=2em\hangafter=1\textit{Exception.---}#1\par%
}

%% Header and footer setup with proper two-sided layout
\pagestyle{fancy}
\fancyhf{}

%% Two-sided header system - left page (even) and right page (odd)
\fancyhead[LE]{%
    \small\ifx\@soicurrentpart\empty%
        \ifx\@soicurrentschedule\empty%
            Constitution of India%
        \else%
            \@soicurrentschedule%
        \fi%
    \else%
        \@soicurrentpart%
    \fi%
}

\fancyhead[RE]{\small\itshape Constitution of India}

\fancyhead[LO]{\small\itshape Constitution of India}

\fancyhead[RO]{%
    \small\ifx\@soicurrentarticle\empty%
        \ifx\@soicurrentcontext\empty%
            Constitution of India%
        \else%
            \@soicurrentcontext%
        \fi%
    \else%
        \@soicurrentarticle%
    \fi%
}

%% Page number at bottom center
\fancyfoot[C]{\thepage}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

%% Enhanced page break control
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\interfootnotelinepenalty=10000

%% List environment setup for constitutional clauses
\setlist[enumerate,1]{label=(\arabic*), leftmargin=2em, itemsep=0.2em}
\setlist[enumerate,2]{label=(\alph*), leftmargin=3em, itemsep=0.2em}
\setlist[enumerate,3]{label=(\roman*), leftmargin=4em, itemsep=0.2em}

%% Table of contents customization
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\setcounter{tocdepth}{2}

%% Part entries in TOC
\titlecontents{part}[0pt]
    {\addvspace{1.5pc}\large\bfseries}
    {}
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
        colorlinks=false,
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

%% Utility commands with soi prefix
\newcommand{\soiWef}[1]{(w.e.f.~#1)}
\newcommand{\soiEtc}{\textit{etc.}}
\newcommand{\soiViz}{\textit{viz.}}
\newcommand{\soiIe}{\textit{i.e.}}

%% Path detection for independent compilation
\newcommand{\soiInputPath}[1]{%
    \IfFileExists{#1}{%
        \input{#1}%
    }{%
        \IfFileExists{../#1}{%
            \input{../#1}%
        }{%
            \IfFileExists{../../#1}{%
                \input{../../#1}%
            }{%
                \ClassError{soi}{Cannot find file #1}{Check the file path and directory structure}%
            }%
        }%
    }%
}

%% Independent compilation helper
\newcommand{\soiIfStandalone}[2]{%
    \ifx\@currname\@empty#1\else#2\fi%
}

%% End of class