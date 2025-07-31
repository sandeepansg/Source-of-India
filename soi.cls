%% Source of India (SoI) LaTeX Document Class
%% Copyright (c) 2025 Sandeepan Sengupta
%% 
%% This class provides specialized formatting for the Constitution of India
%% and similar legal documents with proper structure, amendment tracking,
%% and cross-referencing capabilities.
%%
%% Licensed under the BSD 3-Clause License

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{soi}[2025/01/31 v1.0 Source of India Constitutional Document Class]

%% ============================================================================
%% CLASS OPTIONS DECLARATION
%% ============================================================================

% Boolean flags for options
\newif\if@afoursizepaper\@afoursizepapertrue
\newif\if@afivesizepaper\@afivesizepaperfalse
\newif\if@tenpointsize\@tenpointsizefalse
\newif\if@elevenpointsize\@elevenpointsizefalse
\newif\if@twelvepointsize\@twelvepointsizetrue
\newif\if@showamendments\@showamendmentstrue
\newif\if@draftmode\@draftmodefalse

% Paper size options
\DeclareOption{a4paper}{\@afoursizepapertrue\@afivesizepaperfalse}
\DeclareOption{a5paper}{\@afivesizepapertrue\@afoursizepaperfalse}

% Font size options
\DeclareOption{10pt}{\@tenpointsizetrue\@elevenpointsizefalse\@twelvepointsizefalse}
\DeclareOption{11pt}{\@elevenpointsizetrue\@tenpointsizefalse\@twelvepointsizefalse}
\DeclareOption{12pt}{\@twelvepointsizetrue\@tenpointsizefalse\@elevenpointsizefalse}

% Amendment display options
\DeclareOption{showamendments}{\@showamendmentstrue}
\DeclareOption{hideamendments}{\@showamendmentsfalse}

% Draft mode options
\DeclareOption{draft}{\@draftmodetrue}
\DeclareOption{final}{\@draftmodefalse}

% Pass unknown options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Process options
\ProcessOptions\relax

%% ============================================================================
%% LOAD BASE CLASS AND REQUIRED PACKAGES
%% ============================================================================

% Load base article class
\LoadClass{article}

% Engine detection and font setup
\RequirePackage{iftex}

% Core packages
\RequirePackage{etoolbox}     % Advanced macro programming
\RequirePackage{xstring}      % String manipulation
\RequirePackage{needspace}    % Page break control
\RequirePackage{fancyhdr}     % Headers and footers
\RequirePackage{geometry}     % Page layout
\RequirePackage{titletoc}     % Table of contents formatting
\RequirePackage{hyperref}     % Cross-references and bookmarks
\RequirePackage{forloop}      % Loop constructs

% Font and encoding setup based on engine
\ifXeTeX
    \RequirePackage{fontspec}
    \RequirePackage{polyglossia}
    \setmainlanguage{english}
    % Try to use Libertinus Serif, fallback to Latin Modern
    \IfFontExistsTF{Libertinus Serif}{
        \setmainfont{Libertinus Serif}[
            Ligatures=TeX,
            Numbers=OldStyle
        ]
        \setsansfont{Libertinus Sans}[
            Ligatures=TeX
        ]
    }{
        \setmainfont{Latin Modern Roman}[
            Ligatures=TeX
        ]
        \setsansfont{Latin Modern Sans}[
            Ligatures=TeX
        ]
    }
\else\ifLuaTeX
    \RequirePackage{fontspec}
    \RequirePackage{polyglossia}
    \setmainlanguage{english}
    % Similar font setup for LuaTeX
    \IfFontExistsTF{Libertinus Serif}{
        \setmainfont{Libertinus Serif}[
            Ligatures=TeX,
            Numbers=OldStyle
        ]
        \setsansfont{Libertinus Sans}[
            Ligatures=TeX
        ]
    }{
        \setmainfont{Latin Modern Roman}[
            Ligatures=TeX
        ]
        \setsansfont{Latin Modern Sans}[
            Ligatures=TeX
        ]
    }
\else
    % pdfLaTeX setup
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{lmodern}
    \RequirePackage{microtype}
\fi\fi

%% ============================================================================
%% PAGE LAYOUT CONFIGURATION
%% ============================================================================

% Configure page geometry based on paper size
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
\fi

\if@afivesizepaper
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
\fi

%% ============================================================================
%% FONT SIZE CONFIGURATION
%% ============================================================================

% Apply font size settings
\if@tenpointsize
    \renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}
\fi

\if@elevenpointsize
    \renewcommand{\normalsize}{\fontsize{11}{13}\selectfont}
\fi

\if@twelvepointsize
    \renewcommand{\normalsize}{\fontsize{12}{14}\selectfont}
\fi

%% ============================================================================
%% COUNTER SYSTEM
%% ============================================================================

% Document structure counters
\newcounter{partcounter}
\newcounter{chaptercounter}[partcounter]
\newcounter{articlecounter}
\newcounter{clausecounter}[articlecounter]
\newcounter{subclausecounter}[clausecounter]
\newcounter{subsubclausecounter}[subclausecounter]
\newcounter{schedulecounter}
\newcounter{amendmentcounter}

% Loop counter for utilities
\newcounter{articleloop}

%% ============================================================================
%% INTERNAL VARIABLES
%% ============================================================================

% Current document element tracking
\newcommand{\currentpart}{}
\newcommand{\currentchapter}{}
\newcommand{\currentarticle}{}

%% ============================================================================
%% DRAFT MODE CONFIGURATION
%% ============================================================================

\if@draftmode
    \RequirePackage{draftwatermark}
    \SetWatermarkText{DRAFT}
    \SetWatermarkScale{1}
    \SetWatermarkColor{gray}
    \overfullrule=5pt
\fi

%% ============================================================================
%% TYPOGRAPHY AND SPACING COMMANDS
%% ============================================================================

% Internal formatting commands
\newcommand{\soi@parttitle}[1]{%
    \fontsize{18}{22}\selectfont\bfseries\MakeUppercase{#1}%
}

\newcommand{\soi@chaptertitle}[1]{%
    \fontsize{14}{18}\selectfont\bfseries\MakeUppercase{#1}%
}

\newcommand{\soi@articletitle}[1]{%
    \fontsize{11}{14}\selectfont\bfseries#1%
}

\newcommand{\soi@articletext}[1]{%
    \fontsize{10}{13}\selectfont#1%
}

%% ============================================================================
%% DOCUMENT STRUCTURE COMMANDS
%% ============================================================================

% Part command
\newcommand{\Part}[2]{%
    \needspace{8\baselineskip}%
    \addtocounter{partcounter}{1}%
    \setcounter{chaptercounter}{0}%
    \renewcommand{\currentpart}{Part \Roman{partcounter}: #2}%
    \vspace{2\baselineskip}%
    \begin{center}%
        \soi@parttitle{Part \Roman{partcounter}}\\[0.5\baselineskip]%
        \soi@parttitle{#2}%
    \end{center}%
    \vspace{1.5\baselineskip}%
    \addcontentsline{toc}{part}{Part \Roman{partcounter}: #2}%
}

% Chapter command (optional within parts)
\newcommand{\Chapter}[2]{%
    \needspace{6\baselineskip}%
    \addtocounter{chaptercounter}{1}%
    \renewcommand{\currentchapter}{Chapter \Roman{chaptercounter}: #2}%
    \vspace{1.5\baselineskip}%
    \begin{center}%
        \soi@chaptertitle{Chapter \Roman{chaptercounter}}\\[0.3\baselineskip]%
        \soi@chaptertitle{#2}%
    \end{center}%
    \vspace{1\baselineskip}%
    \addcontentsline{toc}{section}{Chapter \Roman{chaptercounter}: #2}%
}

% Article command - main content unit
\newcommand{\Article}[3]{%
    \needspace{4\baselineskip}%
    \renewcommand{\currentarticle}{Article #1}%
    \setcounter{clausecounter}{0}%
    \vspace{1\baselineskip}%
    \noindent%
    \soi@articletitle{#1. #2.}\quad%
    \soi@articletext{#3}%
    \par\vspace{0.5\baselineskip}%
    \addcontentsline{toc}{subsection}{Article #1: #2}%
}

% Clause system for complex articles
\newcommand{\Clause}[1]{%
    \addtocounter{clausecounter}{1}%
    \par\vspace{0.3em}%
    \noindent%
    \makebox[2em][l]{(\arabic{clausecounter})}%
    \soi@articletext{#1}%
}

\newcommand{\SubClause}[1]{%
    \addtocounter{subclausecounter}{1}%
    \par\vspace{0.2em}%
    \noindent%
    \makebox[1em]{}%
    \makebox[2em][l]{(\alph{subclausecounter})}%
    \soi@articletext{#1}%
}

\newcommand{\SubSubClause}[1]{%
    \addtocounter{subsubclausecounter}{1}%
    \par\vspace{0.2em}%
    \noindent%
    \makebox[2em]{}%
    \makebox[2em][l]{(\roman{subsubclausecounter})}%
    \soi@articletext{#1}%
}

% Group and SubGroup for organizational headings
\newcommand{\Group}[1]{%
    \needspace{4\baselineskip}%
    \vspace{1.5\baselineskip}%
    \begin{center}%
        \fontsize{12}{15}\selectfont\bfseries\MakeUppercase{#1}%
    \end{center}%
    \vspace{1\baselineskip}%
}

\newcommand{\SubGroup}[1]{%
    \needspace{3\baselineskip}%
    \vspace{1\baselineskip}%
    \begin{center}%
        \fontsize{11}{14}\selectfont\bfseries#1%
    \end{center}%
    \vspace{0.5\baselineskip}%
}

% Schedule command for appendices
\newcommand{\Schedule}[2]{%
    \needspace{6\baselineskip}%
    \addtocounter{schedulecounter}{1}%
    \newpage%
    \begin{center}%
        \soi@parttitle{Schedule \Roman{schedulecounter}}\\[0.5\baselineskip]%
        \soi@parttitle{#1}%
    \end{center}%
    \vspace{1.5\baselineskip}%
    \soi@articletext{#2}%
    \addcontentsline{toc}{part}{Schedule \Roman{schedulecounter}: #1}%
}

%% ============================================================================
%% AMENDMENT SYSTEM
%% ============================================================================

% Amendment footnote command
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

% Amendment status indicator
\newcommand{\Amendment}[2]{%
    \if@showamendments%
        \marginpar{\tiny Amendment #1}%
        \footnote{#2}%
    \fi%
}

%% ============================================================================
%% FRONT MATTER COMMANDS
%% ============================================================================

% Front cover command
\newcommand{\soifrontcover}{%
    \begin{titlepage}%
        \centering%
        \vspace*{2cm}%
        {\Huge\bfseries THE CONSTITUTION}\\[0.5cm]%
        {\huge\bfseries OF}\\[0.5cm]%
        {\Huge\bfseries INDIA}\\[2cm]%
        \vfill%
        {\large As on \today}%
    \end{titlepage}%
    \cleardoublepage%
}

% Preamble command
\newcommand{\soipreamble}{%
    \chapter*{PREAMBLE}%
    \addcontentsline{toc}{chapter}{PREAMBLE}%
    \begin{center}%
        \textit{WE, THE PEOPLE OF INDIA, having solemnly resolved to constitute India into a SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC and to secure to all its citizens:}%
        
        \vspace{1em}%
        
        \textit{JUSTICE, social, economic and political;}%
        
        \vspace{0.5em}%
        
        \textit{LIBERTY of thought, expression, belief, faith and worship;}%
        
        \vspace{0.5em}%
        
        \textit{EQUALITY of status and of opportunity;}%
        
        \vspace{0.5em}%
        
        \textit{and to promote among them all}%
        
        \vspace{0.5em}%
        
        \textit{FRATERNITY assuring the dignity of the individual and the unity and integrity of the Nation;}%
        
        \vspace{1em}%
        
        \textit{IN OUR CONSTITUENT ASSEMBLY this twenty-sixth day of November, 1949, do HEREBY ADOPT, ENACT AND GIVE TO OURSELVES THIS CONSTITUTION.}%
    \end{center}%
    \cleardoublepage%
}

% Table of contents command
\newcommand{\soitableofcontents}{%
    \tableofcontents%
    \cleardoublepage%
}

% Back cover command
\newcommand{\soibackcover}{%
    \cleardoublepage%
    \thispagestyle{empty}%
    \vspace*{\fill}%
    \begin{center}%
        {\Large\bfseries THE CONSTITUTION OF INDIA}\\[1cm]%
        {\large Generated using the Source of India \LaTeX\ Class}\\[0.5cm]%
        {\normalsize \today}%
    \end{center}%
    \vspace*{\fill}%
}

%% ============================================================================
%% HEADER AND FOOTER SETUP
%% ============================================================================

\pagestyle{fancy}
\fancyhf{} % Clear all header and footer fields

% Header setup
\fancyhead[LE,RO]{\thepage}
\fancyhead[LO]{\rightmark}
\fancyhead[RE]{\leftmark}

% Footer setup (empty by default)
\fancyfoot{}

% Redefine plain page style for chapter pages
\fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyfoot[C]{\thepage}%
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
}

% Header rule width
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

%% ============================================================================
%% HYPERREF CONFIGURATION
%% ============================================================================

\hypersetup{
    pdftitle={The Constitution of India},
    pdfauthor={Source of India LaTeX Class},
    pdfsubject={Constitutional Document},
    pdfkeywords={Constitution, India, Legal Document},
    colorlinks=true,
    linkcolor=black,
    filecolor=black,
    urlcolor=blue,
    citecolor=black,
    bookmarks=true,
    bookmarksopen=true,
    bookmarksnumbered=true
}

%% ============================================================================
%% UTILITY COMMANDS AND VALIDATION
%% ============================================================================

% Article number validation (basic)
\newcommand{\validatearticlenumber}[1]{%
    \IfInteger{#1}{}{%
        \IfEndWith{#1}{A}{}{%
            \IfEndWith{#1}{B}{}{%
                \PackageWarning{soi}{%
                    Unusual article number format: #1. %
                    Expected format: number, numberA, numberB, etc.%
                }%
            }%
        }%
    }%
}

% File existence check for includes
\newcommand{\soi@inputifexists}[1]{%
    \IfFileExists{#1}{%
        \input{#1}%
    }{%
        \PackageWarning{soi}{File #1 not found. Creating placeholder.}%
        \vspace{1em}%
        \noindent\textit{[Content for #1 not available]}%
        \vspace{1em}%
    }%
}

%% ============================================================================
%% TABLE OF CONTENTS CUSTOMIZATION
%% ============================================================================

% Customize TOC formatting
\renewcommand{\contentsname}{CONTENTS}

% Part entries in TOC
\titlecontents{part}[0em]
    {\addvspace{1em}\large\bfseries}
    {}
    {}
    {\titlerule*[0.5em]{.}\contentspage}

% Section entries in TOC (Chapters)
\titlecontents{section}[1.5em]
    {\addvspace{0.5em}\normalsize\bfseries}
    {}
    {}
    {\titlerule*[0.5em]{.}\contentspage}

% Subsection entries in TOC (Articles)
\titlecontents{subsection}[3em]
    {\addvspace{0.25em}\small}
    {}
    {}
    {\titlerule*[0.5em]{.}\contentspage}

%% ============================================================================
%% ERROR HANDLING AND DEBUGGING
%% ============================================================================

% Debug information in draft mode
\if@draftmode
    \AtBeginDocument{%
        \typeout{SoI Class: Draft mode enabled}%
        \typeout{SoI Class: Paper size: \if@afoursizepaper A4\fi\if@afivesizepaper A5\fi}%
        \typeout{SoI Class: Font size: \if@tenpointsize 10pt\fi\if@elevenpointsize 11pt\fi\if@twelvepointsize 12pt\fi}%
        \typeout{SoI Class: Amendments: \if@showamendments shown\else hidden\fi}%
    }%
\fi

% Warning for missing soi.cls features
\AtEndDocument{%
    \if@draftmode%
        \typeout{SoI Class: Document compiled successfully in draft mode}%
    \fi%
}

%% ============================================================================
%% COMPATIBILITY AND FINAL SETUP
%% ============================================================================

% Ensure proper spacing after class loading
\AtBeginDocument{%
    \normalsize%
    \setlength{\parindent}{0pt}%
    \setlength{\parskip}{0.5em plus 0.1em minus 0.1em}%
}

% End of class file
\endinput

%% ============================================================================
%% DOCUMENTATION
%% ============================================================================
%%
%% This class provides the following main commands:
%%
%% Document Structure:
%%   \Part{number}{title}                 - Create a constitutional part
%%   \Chapter{number}{title}              - Create a chapter within a part
%%   \Article{number}{title}{content}     - Create an article
%%   \Clause{content}                     - Create a numbered clause
%%   \SubClause{content}                  - Create a sub-clause
%%   \SubSubClause{content}               - Create a sub-sub-clause
%%   \Group{title}                        - Create a group heading
%%   \SubGroup{title}                     - Create a subgroup heading
%%   \Schedule{title}{content}            - Create a schedule
%%
%% Front Matter:
%%   \soifrontcover                       - Generate front cover
%%   \soipreamble                         - Generate preamble
%%   \soitableofcontents                  - Generate table of contents
%%   \soibackcover                        - Generate back cover
%%
%% Amendment System:
%%   \AmendmentFootnote{number}{text}     - Add amendment footnote
%%   \AmendText{text}{amendment}          - Mark amended text
%%   \Amendment{number}{description}      - Show amendment status
%%
%% Class Options:
%%   a4paper, a5paper                     - Paper size
%%   10pt, 11pt, 12pt                     - Font size
%%   showamendments, hideamendments       - Amendment display
%%   draft, final                         - Draft mode
%%
%% For detailed usage instructions, see the User Guide.
%% For technical implementation details, see the Developer Guide.
%%
%% ============================================================================