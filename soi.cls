%% Source of India (SoI) LaTeX Class
%% Version 1.0
%% A specialized LaTeX class for typesetting the Constitution of India
%% 
%% This class provides structured commands for constitutional documents
%% with proper formatting, amendment tracking, and cross-referencing

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{soi}[2025/01/31 v1.0 Source of India Constitution Class]

%% ================================================================
%% CLASS OPTIONS
%% ================================================================

% Paper size options
\newif\if@afoursizepaper\@afoursizepaperfalse
\newif\if@afivesizepaper\@afivesizepaperfalse

\DeclareOption{a4paper}{\@afoursizepapertrue\@afivesizepaperfalse}
\DeclareOption{a5paper}{\@afivesizepapertrue\@afoursizepaperfalse}

% Font size options
\newif\if@tenpointsize\@tenpointsizefalse
\newif\if@elevenpointsize\@elevenpointsizefalse
\newif\if@twelvepointsize\@twelvepointsizefalse

\DeclareOption{10pt}{\@tenpointsizetrue\@elevenpointsizefalse\@twelvepointsizefalse}
\DeclareOption{11pt}{\@elevenpointsizetrue\@tenpointsizefalse\@twelvepointsizefalse}
\DeclareOption{12pt}{\@twelvepointsizetrue\@tenpointsizefalse\@elevenpointsizefalse}

% Amendment display options
\newif\if@showamendments\@showamendmentstrue
\DeclareOption{hideamendments}{\@showamendmentsfalse}
\DeclareOption{showamendments}{\@showamendmentstrue}

% Draft mode
\newif\if@draftmode\@draftmodefalse
\DeclareOption{draft}{\@draftmodetrue}
\DeclareOption{final}{\@draftmodefalse}

% Default options
\ExecuteOptions{a4paper,12pt,showamendments,final}
\ProcessOptions\relax

%% ================================================================
%% BASE CLASS AND PACKAGES
%% ================================================================

% Load base article class
\if@tenpointsize
  \LoadClass[10pt]{article}
\else\if@elevenpointsize
  \LoadClass[11pt]{article}
\else
  \LoadClass[12pt]{article}
\fi\fi

% Essential packages
\RequirePackage{iftex}
\RequirePackage{etoolbox}
\RequirePackage{xstring}
\RequirePackage{needspace}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{titletoc}
\RequirePackage{hyperref}

%% ================================================================
%% FONT CONFIGURATION
%% ================================================================

% Font setup based on engine
\ifXeTeX
    \RequirePackage{fontspec}
    \RequirePackage{polyglossia}
    \setmainlanguage{english}
    % Try to load Libertinus Serif, fallback to Latin Modern
    \IfFontExistsTF{Libertinus Serif}{%
        \setmainfont{Libertinus Serif}%
        \setsansfont{Libertinus Sans}%
    }{%
        \setmainfont{Latin Modern Roman}%
        \setsansfont{Latin Modern Sans}%
    }%
\else\ifLuaTeX
    \RequirePackage{fontspec}
    \RequirePackage{polyglossia}
    \setmainlanguage{english}
    \IfFontExistsTF{Libertinus Serif}{%
        \setmainfont{Libertinus Serif}%
        \setsansfont{Libertinus Sans}%
    }{%
        \setmainfont{Latin Modern Roman}%
        \setsansfont{Latin Modern Sans}%
    }%
\else
    % pdfLaTeX fallback
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{lmodern}
    \RequirePackage{microtype}
\fi\fi

%% ================================================================
%% PAGE LAYOUT
%% ================================================================

\if@afoursizepaper
    \geometry{
        a4paper,
        top=2.5cm,
        bottom=2cm,
        left=2.5cm,
        right=2cm,
        headheight=1cm,
        headsep=0.5cm,
        footskip=1cm
    }
\else\if@afivesizepaper
    \geometry{
        a5paper,
        top=2cm,
        bottom=1.5cm,
        left=2cm,
        right=1.5cm,
        headheight=0.8cm,
        headsep=0.4cm,
        footskip=0.8cm
    }
\fi\fi

%% ================================================================
%% COUNTERS AND VARIABLES
%% ================================================================

% Main structural counters
\newcounter{partcounter}
\newcounter{chaptercounter}[partcounter]
\newcounter{articlecounter}
\newcounter{clausecounter}[articlecounter]
\newcounter{subclausecounter}[clausecounter]
\newcounter{subsubclausecounter}[subclausecounter]
\newcounter{schedulecounter}
\newcounter{amendmentcounter}

% Counter formatting
\renewcommand{\theclausecounter}{(\arabic{clausecounter})}
\renewcommand{\thesubclausecounter}{(\alph{subclausecounter})}
\renewcommand{\thesubsubclausecounter}{(\roman{subsubclausecounter})}

% Current context variables
\newcommand{\currentpart}{}
\newcommand{\currentchapter}{}
\newcommand{\currentarticle}{}

%% ================================================================
%% DOCUMENT STRUCTURE COMMANDS
%% ================================================================

% Part command
\newcommand{\Part}[2]{%
    \addtocounter{partcounter}{1}%
    \setcounter{chaptercounter}{0}%
    \renewcommand{\currentpart}{Part \Roman{partcounter}: #2}%
    \soipart{\Roman{partcounter}}{#2}%
    \addcontentsline{toc}{part}{Part \Roman{partcounter}: #2}%
    \markboth{Part \Roman{partcounter}}{#2}%
}

% Chapter command
\newcommand{\Chapter}[2]{%
    \addtocounter{chaptercounter}{1}%
    \renewcommand{\currentchapter}{Chapter \Roman{chaptercounter}: #2}%
    \soichapter{\Roman{chaptercounter}}{#2}%
    \addcontentsline{toc}{chapter}{Chapter \Roman{chaptercounter}: #2}%
}

% Article command
\newcommand{\Article}[3]{%
    \renewcommand{\currentarticle}{Article #1}%
    \soiarticle{#1}{#2}{#3}%
    \addcontentsline{toc}{section}{Article #1: #2}%
}

% Group and SubGroup commands
\newcommand{\Group}[1]{\soigroup{#1}}
\newcommand{\SubGroup}[1]{\soisubgroup{#1}}

%% ================================================================
%% TYPOGRAPHY COMMANDS
%% ================================================================

% Part typography
\newcommand{\soipart}[2]{%
    \needspace{10\baselineskip}%
    \newpage%
    \begin{center}%
        {\fontsize{18}{22}\selectfont\bfseries PART #1}\\[0.5em]%
        {\fontsize{16}{20}\selectfont\bfseries #2}%
    \end{center}%
    \vspace{2em}%
}

% Chapter typography
\newcommand{\soichapter}[2]{%
    \needspace{6\baselineskip}%
    \vspace{1.5em}%
    {\fontsize{14}{18}\selectfont\bfseries CHAPTER #1---#2\par}%
    \vspace{1em}%
}

% Group typography
\newcommand{\soigroup}[1]{%
    \needspace{4\baselineskip}%
    \vspace{1.5em}%
    {\fontsize{14}{18}\selectfont\bfseries\centering #1\par}%
    \vspace{1em}%
}

% SubGroup typography
\newcommand{\soisubgroup}[1]{%
    \needspace{3\baselineskip}%
    \vspace{1em}%
    {\fontsize{12}{16}\selectfont\bfseries\centering #1\par}%
    \vspace{0.75em}%
}

% Article typography
\newcommand{\soiarticle}[3]{%
    \needspace{8\baselineskip}%
    \vspace{0.75em}%
    {\fontsize{11}{14}\selectfont\bfseries #1. #2.---}%
    {\fontsize{10}{13}\selectfont #3\par}%
    \vspace{0.5em}%
}

%% ================================================================
%% CLAUSE SYSTEM
%% ================================================================

% Main clause
\newcommand{\Clause}[1]{%
    \addtocounter{clausecounter}{1}%
    \par\vspace{0.5em}%
    {\fontsize{10}{13}\selectfont \theclausecounter\enskip #1\par}%
}

% Sub-clause
\newcommand{\SubClause}[1]{%
    \addtocounter{subclausecounter}{1}%
    \par\vspace{0.25em}%
    {\fontsize{10}{13}\selectfont \hspace{1em}\thesubclausecounter\enskip #1\par}%
}

% Sub-sub-clause
\newcommand{\SubSubClause}[1]{%
    \addtocounter{subsubclausecounter}{1}%
    \par\vspace{0.25em}%
    {\fontsize{10}{13}\selectfont \hspace{2em}\thesubsubclausecounter\enskip #1\par}%
}

%% ================================================================
%% SCHEDULE SYSTEM
%% ================================================================

% Schedule command
\newcommand{\Schedule}[2]{%
    \addtocounter{schedulecounter}{1}%
    \newpage%
    \begin{center}%
        {\fontsize{16}{20}\selectfont\bfseries SCHEDULE \Roman{schedulecounter}}\\[0.5em]%
        {\fontsize{14}{18}\selectfont\bfseries #2}%
    \end{center}%
    \addcontentsline{toc}{part}{Schedule \Roman{schedulecounter}: #2}%
    \markboth{Schedule \Roman{schedulecounter}}{#2}%
    \vspace{2em}%
}

%% ================================================================
%% AMENDMENT SYSTEM
%% ================================================================

% Amendment footnote
\newcommand{\AmendmentFootnote}[2]{%
    \if@showamendments%
        \footnote{#2}%
    \fi%
}

% Inline amendment marker
\newcommand{\AmendText}[2]{%
    \if@showamendments%
        \textit{[#1]}\footnote{#2}%
    \else%
        #1%
    \fi%
}

% Amendment insertion
\newcommand{\Amendment}[2]{%
    \if@showamendments%
        \ifstrequal{#2}{[omitted]}{%
            \textit{[Article #1 omitted by amendment]}%
        }{%
            \textit{[#2]}%
        }%
    \fi%
}

%% ================================================================
%% FRONT MATTER
%% ================================================================

% Front cover
\newcommand{\soifrontcover}{%
    \newpage\thispagestyle{empty}%
    \begin{center}%
        \vspace*{3cm}%
        {\fontsize{24}{30}\selectfont\bfseries THE CONSTITUTION}\\[1em]%
        {\fontsize{20}{25}\selectfont\bfseries OF}\\[1em]%
        {\fontsize{24}{30}\selectfont\bfseries INDIA}\\[2em]%
        {\fontsize{14}{18}\selectfont\itshape As amended up to the 105th Amendment Act, 2021}\\[4cm]%
        {\fontsize{12}{15}\selectfont\bfseries GOVERNMENT OF INDIA}\\[0.5em]%
        {\fontsize{12}{15}\selectfont\bfseries MINISTRY OF LAW AND JUSTICE}\\[0.5em]%
        {\fontsize{12}{15}\selectfont\bfseries LEGISLATIVE DEPARTMENT}%
    \end{center}%
    \newpage%
}

% Back cover
\newcommand{\soibackcover}{%
    \newpage\thispagestyle{empty}%
    \null\vfill%
    \begin{center}%
        {\footnotesize This document was typeset using the Source of India LaTeX class.\\%
            Available at: https://github.com/source-of-india/soi-latex}%
    \end{center}%
    \newpage%
}

% Preamble
\newcommand{\soipreamble}{%
    \newpage%
    \begin{center}%
        {\fontsize{16}{20}\selectfont\bfseries PREAMBLE}%
    \end{center}%
    \vspace{2em}%
    
    \begin{center}%
        {\fontsize{11}{15}\selectfont%
            WE, THE PEOPLE OF INDIA, having solemnly resolved to constitute India into a\\%
            SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC and to secure to all its citizens:\\[1em]%
            
            JUSTICE, social, economic and political;\\[0.5em]%
            LIBERTY of thought, expression, belief, faith and worship;\\[0.5em]%
            EQUALITY of status and of opportunity;\\[0.5em]%
            and to promote among them all\\[0.5em]%
            FRATERNITY assuring the dignity of the individual and the unity and integrity of the Nation;\\[1em]%
            
            IN OUR CONSTITUENT ASSEMBLY this twenty-sixth day of November, 1949, do\\%
            HEREBY ADOPT, ENACT AND GIVE TO OURSELVES THIS CONSTITUTION.%
        }%
    \end{center}%
    \newpage%
}

% Table of contents
\newcommand{\soitableofcontents}{%
    \newpage%
    \begin{center}%
        {\fontsize{18}{22}\selectfont\bfseries CONTENTS}%
    \end{center}%
    \vspace{2em}%
    \tableofcontents%
    \newpage%
}

%% ================================================================
%% HEADER AND FOOTER SETUP
%% ================================================================

\pagestyle{fancy}
\fancyhf{}

% Headers
\fancyhead[LE]{\small\currentpart}
\fancyhead[RO]{\small\currentarticle}
\fancyhead[LO]{\small Constitution of India}
\fancyhead[RE]{\small Constitution of India}

% Footers
\fancyfoot[LE,RO]{\thepage}

% Header rule
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% Plain page style for chapter/part starts
\fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyfoot[LE,RO]{\thepage}%
    \renewcommand{\headrulewidth}{0pt}%
}

%% ================================================================
%% ARTICLE INCLUSION UTILITIES
%% ================================================================

% Include single article
\newcommand{\includeArticle}[1]{%
    \IfFileExists{includes/articles/article-#1.tex}{%
        \input{includes/articles/article-#1.tex}%
    }{%
        \PackageWarning{soi}{Article #1 file not found}%
    }%
}

% Include article range
\RequirePackage{forloop}
\newcounter{articleloop}
\newcommand{\includeArticleRange}[2]{%
    \forloop{articleloop}{#1}{\value{articleloop} < #2}{%
        \includeArticle{\arabic{articleloop}}%
    }%
}

%% ================================================================
%% INPUT VALIDATION
%% ================================================================

% Validate article number format
\newcommand{\validatearticlenumber}[1]{%
    \IfInteger{#1}{}{%
        \IfEndWith{#1}{A}{}{%
            \IfEndWith{#1}{B}{}{%
                \IfEndWith{#1}{C}{}{%
                    \IfEndWith{#1}{D}{}{%
                        \PackageWarning{soi}{%
                            Unusual article number format: #1
                        }%
                    }%
                }%
            }%
        }%
    }%
}

%% ================================================================
%% DISABLE STANDARD SECTIONING
%% ================================================================

% Disable standard LaTeX sectioning to enforce structure
\renewcommand{\section}[1]{%
    \PackageError{soi}{%
        Use \string\Part, \string\Chapter, or \string\Article\space instead of \string\section
    }{%
        Standard sectioning commands are disabled in the soi class.%
        Use \string\Part{}{} for parts, \string\Chapter{}{} for chapters, %
        or \string\Article{}{}{} for articles.
    }%
}

\renewcommand{\subsection}[1]{%
    \PackageError{soi}{%
        Use \string\Group, \string\SubGroup, or \string\Clause\space instead of \string\subsection
    }{%
        Standard sectioning commands are disabled in the soi class.
    }%
}

\renewcommand{\subsubsection}[1]{%
    \PackageError{soi}{%
        Use \string\SubClause\space or \string\SubSubClause\space instead of \string\subsubsection
    }{%
        Standard sectioning commands are disabled in the soi class.
    }%
}

%% ================================================================
%% HYPERREF CONFIGURATION
%% ================================================================

\hypersetup{
    pdftitle={Constitution of India},
    pdfauthor={Government of India},
    pdfsubject={Constitutional Law},
    pdfkeywords={Constitution, India, Law, Government},
    colorlinks=true,
    linkcolor=black,
    urlcolor=blue,
    citecolor=black,
    bookmarks=true,
    bookmarksnumbered=true,
    pdfstartview=FitH
}

%% ================================================================
%% DRAFT MODE FEATURES
%% ================================================================

\if@draftmode
    \RequirePackage{draftwatermark}
    \SetWatermarkText{DRAFT}
    \SetWatermarkScale{1}
    \SetWatermarkColor[gray]{0.8}
    
    % Show overfull boxes
    \overfullrule=5pt
    
    % Fast mode - disable some features
    \renewcommand{\soifrontcover}{\newpage}
    \renewcommand{\soibackcover}{\newpage}
\fi

%% ================================================================
%% END OF CLASS
%% ================================================================

\endinput