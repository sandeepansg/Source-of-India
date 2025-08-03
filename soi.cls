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
\RequirePackage{needspace}
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

%% Page geometry
\geometry{
    top=2.5cm,
    bottom=2.5cm,
    left=3cm,
    right=2.5cm,
    headheight=14pt,
    headsep=20pt,
    footskip=25pt
}

%% Typography settings
\setlength{\parskip}{0.6em plus 0.1em minus 0.1em}
\setlength{\parindent}{0pt}
\renewcommand{\baselinestretch}{1.1}

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
}

%% Part declaration system
\newcommand{\DeclarePart}[3]{%
    \stepcounter{partnumber}%
    \def\@currentparttitle{#2}%
}

%% Schedule declaration system
\newcommand{\DeclareSchedule}[2]{%
    \stepcounter{schedulenumber}%
}

%% Amendment system
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
        \amendmentopen#1\amendmentclose\footnote{Inserted by #2}%
        \stepcounter{totalamendments}%
    \else
        #1%
    \fi
}

\newcommand{\Substituted}[3]{%
    \if@showamendments
        \amendmentopen#1\amendmentclose\footnote{Substituted for "#2" by #3}%
        \stepcounter{totalamendments}%
    \else
        #1%
    \fi
}

\newcommand{\Omitted}[1]{%
    \if@showomitted
        \textit{Omitted by #1}%
        \stepcounter{totalomitted}%
    \fi
}

\newcommand{\Repealed}[1]{%
    \if@showomitted
        \textit{Repealed by #1}%
        \stepcounter{totalomitted}%
    \fi
}

%% Structural commands
\newcommand{\Part}[3][]{%
    \needspace{5\baselineskip}%
    \vspace{2\baselineskip}%
    {\centering\partsize\bfseries PART #1\\[0.5\baselineskip]#2\par}%
    \vspace{\baselineskip}%
    \def\@currentparttitle{#2}%
    \markboth{PART #1: #2}{PART #1: #2}%
}

\newcommand{\Article}[3][]{%
    \needspace{3\baselineskip}%
    \vspace{\baselineskip}%
    {\articlesize\bfseries\@currentarticledisplay. #1}\par%
    \vspace{0.5\baselineskip}%
    #2\par%
    \def\@currentarticletitle{#1}%
    \markright{\@currentarticledisplay: #1}%
}

\newcommand{\Schedule}[4][]{%
    \needspace{5\baselineskip}%
    \vspace{2\baselineskip}%
    {\centering\partsize\bfseries #1 SCHEDULE\\[0.5\baselineskip]#2\par}%
    \vspace{\baselineskip}%
    #3\par%
}

%% Clause and sub-clause commands
\newcounter{clausecounter}[articlenumber]
\newcounter{subclausecounter}[clausecounter]
\newcounter{subsubclausecounter}[subclausecounter]

\newcommand{\Clause}[1]{%
    \stepcounter{clausecounter}%
    \par(\theclausecounter) #1\par%
}

\newcommand{\SubClause}[1]{%
    \stepcounter{subclausecounter}%
    \par(\alph{subclausecounter}) #1\par%
}

\newcommand{\SubSubClause}[1]{%
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

%% Footnote configuration
\if@globalfootnotes
    % Global footnote numbering (default)
\else
    \@addtoreset{footnote}{page}
\fi

%% Table of contents customization
\renewcommand{\contentsname}{Contents}
\setcounter{tocdepth}{2}

%% Hyperref setup
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

%% Warning and error commands
\newcommand{\soiwarning}[1]{\ClassWarning{soi}{#1}}
\newcommand{\soierror}[2]{\ClassError{soi}{#1}{#2}}

%% File inclusion helpers
\newcommand{\articlefilename}[2]{%
    \StrLower{#2}[\lowersuffix]%
    article_#1\lowersuffix.tex%
}

\newcommand{\partfilename}[2]{%
    \StrLower{#1#2}[\lowerpart]%
    part_\lowerpart.tex%
}

\newcommand{\schedulefilename}[1]{%
    \StrLower{#1}[\lowerschedule]%
    schedule_\lowerschedule.tex%
}

%% Boolean flags for user control
\newif\ifshowamendments
\newif\ifshowomitted

% Initialize based on class options
\if@showamendments\showamendmentstrue\else\showamendmentsfalse\fi
\if@showomitted\showomittedtrue\else\showomittedfalse\fi

%% End of class