\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{styles/ucthesis-CA2021}

% ==============================================================================
% |                                   OPTIONS                                  |
% ==============================================================================

\newcommand\@ptsize{}
\newcommand\@draftmark{}

\newif\if@openright
\newif\if@mainmatter \@mainmattertrue

\DeclareOption{10pt}{\renewcommand\@ptsize{0}}  % font-size 10
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}  % font-size 11
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}  % font-size 12

\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}

\DeclareOption{draft}{\setlength\overfullrule{5pt}\renewcommand\@draftmark{1}}
\DeclareOption{final}{\setlength\overfullrule{0pt}\renewcommand\@draftmark{0}}

\DeclareOption{openright}{
    \if@twoside
        \@openrighttrue
    \else
        \@openrightfalse
    \fi
}
\DeclareOption{openany}{\@openrightfalse}

\ExecuteOptions{12pt,oneside,final}
\ProcessOptions

% choose the font size, default=12
\input styles/uct1\@ptsize.clo\relax

% definitions
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.65}\large\normalsize}
\def\smallssp{\def\baselinestretch{1.0}\large\small}
\def\scriptsizessp{\def\baselinestretch{1.0}\large\scriptsize}


\def\vitaename{Curriculum Vit\ae}
\def\abstractname{Abstract}
\def\contentsname{Table of Contents}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
\def\bibname{Bibliography}
\def\indexname{Index}
\def\figurename{Figure}
\def\tablename{Table}
\def\chaptername{Chapter}
\def\appendixname{Appendix}
\def\partname{Part}

\def\disclaimername{Disclaimer}
\def\@chapapp{\chaptername}

% ==============================================================================
% |                                PAGE STYLES                                 |
% ==============================================================================

\def\thepage {\roman{page}}

% one-sided printing
\def\ps@headings{
    \def\@oddfoot{\rm\hfil\thepage\hfil}
    \def\@oddhead{{\slshape\rightmark}\hfil}
    \let\@mkboth\markboth
    \def\chaptermark##1{
        \markright {\MakeUppercase{
            \ifnum \c@secnumdepth >\m@ne
                \if@mainmatter
                    \@chapapp\ \thechapter. \ 
                \fi
            \fi
        ##1}}}}

% "plain" page style
\def\ps@plain{\let\@mkboth\markboth
    \def\@oddfoot{\rm\hfil\thepage\hfil}
    \def\@evenfoot{\rm\hfil\thepage\hfil}
    \def\@oddhead{}\def\@evenhead{}
}

% "empty" page style
\def\ps@empty{\let\@mkboth\markboth
    \def\@oddfoot{}\def\@evenfoot{}\def\@oddhead{}\def\@evenhead{}
}


% ==============================================================================
% |                                FRONTMATTER                                 |
% ==============================================================================

% DECLARATIONS
% get variables defined in content/frontmatter/*.tex files
\def\seal#1{\gdef\@seal{#1}}
\def\campus#1{\gdef\@campus{#1}}
\def\thesistitle#1{\gdef\@title{#1}}
\def\report#1{\gdef\@report{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\field#1{\gdef\@field{#1}}

\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\defensemonth#1{\gdef\@defensemonth{#1}}
\def\defenseyear#1{\gdef\@defenseyear{#1}}

\def\chair#1{\gdef\@chair{#1}}
\def\committeememberA#1{\gdef\@committeememberA{#1}}
\def\committeememberB#1{\gdef\@committeememberB{#1}}
\def\committeememberC#1{\gdef\@committeememberC{#1}}
% \def\othermembers#1{\gdef\@othermembers{#1}}


% FRONTMATTER ENVIRONMENT
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont} 
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

\newenvironment{frontmatter}{
    \renewcommand{\thepage}{\roman{page}}
    {\pagestyle{plain}}
    {\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}
    \pagenumbering{roman}
}{}


% TITLE PAGE
% define title page layout
\def\maketitlepage{{
    \ssp
    \let\footnotesize\small
    \let\footnoterule\relax
    \thispagestyle{empty}
    \setcounter{page}{1}

    \null\vfil

    \begin{center}
        \includegraphics[scale=0.40]{\@seal}\par
        \medskip
        University of California\par
        \@campus\par
        \bigskip \medskip \vspace{6ex}
        \fmfont {\bfseries \Large {\@title}\par}
        \bigskip \medskip \vspace{6ex}
        A dissertation submitted in partial satisfaction\par
        \smallskip
        of the requirements for the degree\par
        \bigskip{\@degree}\par
        \smallskip in\par
        \smallskip{\@field}\par
        \bigskip \medskip by\par
        \bigskip \medskip {\@author}\par
    \end{center}
    \raggedright

    {
        \vspace{6ex}
        Committee in charge:
        \begin{quote}
            {\@chair}, Chair \\
            {\@committeememberA} \\
            {\@committeememberB} \\
            {\@committeememberC} \\
            % TODO: implement extra members function
        \end{quote}
        \medskip
        \begin{center}
            {\@degreemonth~\@degreeyear}
        \end{center}
    }
    \vfil\null
    \setcounter{footnote}{0}

    % TODO: see if this is necessary
    \if@openright
        \clearpage
        \thispagestyle{empty}
        \mbox{}
        \newpage
    \fi
}}


% APPROVAL PAGE
% variables
\def\@approvalspace{0.75in}
\def\@approvaladjust{-1\@ptsize pt}

% define approval page layout (UC approved format)
\def\makeapprovalpage{
    \newpage
    \thispagestyle {empty}
    \null\vfill  % TODO: check diff between vfil and vfill
    \begin {center}
        {\fmfont The Dissertation of {\@author} is approved.} \\

        \vspace{.25in} \vspace{\@approvalspace}
        $\:\overline{~~~~ \mbox{\rule{0in}{0.16in} \hspace{3.5in}}}\:$ \\
        \vspace{\@approvaladjust} {\@committeememberA} \\

        \vspace{\@approvalspace}
        $\:\overline{~~~~ \mbox{\rule{0in}{0.16in} \hspace{3.5in}}}\:$ \\
        \vspace{\@approvaladjust} {\@committeememberB} \\

        \vspace{\@approvalspace}
        $\:\overline{~~~~ \mbox{\rule{0in}{0.16in} \hspace{3.5in}}}\:$ \\
        \vspace{\@approvaladjust} {\@committeememberC} \\

        \vspace{\@approvalspace}
        $\:\overline{~~~~ \mbox{\rule{0in}{0.16in} \hspace{3.5in}}}\:$ \\
        \vspace{\@approvaladjust} {\@chair}, Committee Chair \\
        \vspace{\@approvalspace}
        \vspace{-.25in}
        \vspace{\@approvalspace}
        {\fmfont \@defensemonth~\@defenseyear}
    \end {center}
    \vfill\null
}

% COPYRIGHT PAGE
% define copyright page layout
\def\makecopyrightpage{
    \newpage
    \thispagestyle {empty}
    \null\vfill
    \begin {center}
        {\fmfont {\@title}}\par
        \vspace {1in}
        Copyright \copyright~\@degreeyear\par
        \vspace {0.1in}
        by \par
        \vspace {0.1in}
        \@author
    \end {center}
}


% DEDICATION PAGE

% get dedication variables
\def\dedication#1{\gdef\@dedication{#1}}
\def\quotetext#1{\gdef\@quotetext{#1}}
\def\quoteauthor#1{\gdef\@quoteauthor{#1}}

% define dedication page layout
\def\makededicationpage{
    \newpage
    \thispagestyle{plain}
    \begin {center}
        {\fmfont \Large{\@dedication}}\par
    \end {center}
    \bigskip\bigskip\bigskip
    \begin{quote}
        \null\hfill{\fmfont \textit{\@quotetext}}\par
        \null\hfill\textemdash \@quoteauthor
    \end{quote}
    \vfill\null
}

% ACKNOWLEDGEMENTS

% get acknowledgement variables
\def\acknowledgename{Acknowledgements}
\def\acknowledgementstext#1{\gdef\@acknowledgementstext{#1}}

\newenvironment{acknowledgements}{%
    \if@openright
        \cleardoublepage
    \else
        \clearpage
    \fi
    \ifnum
        \@draftmark = 1
        \ssp
    \else
        \dsp
    \fi
}{}

% define acknowledgement section layout
\def\makeacknowledgements{
    \begin{acknowledgements}
        \newpage
        \begin{center}
            {\large \bfseries \acknowledgename}
        \end{center}
        % {\dsp {\@acknowledgementstext}}
        \input{content/frontmatter/acknowledgements.tex}
    \end{acknowledgements}
}


% CURRICULUM VITAE

% define environment for vitae
\newenvironment{vitae}{%
    \if@openright \cleardoublepage \else \clearpage \fi
    \ssp
    \begin{center}
        {\large \bfseries \vitaename} \par
        {\large \@author}
    \end{center}
    \begin{list}{}{\leftmargin 0in \itemsep 0.2in}}{\end{list}}{\par\vfil\null}

\newcommand{\vitaelabels}[1]{#1 \hfil}

\newenvironment{vitaesection}[1]{
    \item {\bfseries #1}
    \begin{list}{}{
        \leftmargin 1.5in
        \labelwidth 1.3in
        \labelsep 0.2in
        \parsep 0in
        \let\makelabel\vitaelabels
    }}{\end{list}}

% ==============================================================================
% |                             TABLE OF CONTENTS                              |
% ==============================================================================



% ==============================================================================
% |                                 MAINMATTER                                 |
% ==============================================================================



% ==============================================================================
% |                           CHAPTERS & SECTIONS                              |
% ==============================================================================

% define chapter and section counters
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]

% macros for counters
\def\thepart          {\Roman{part}}
\def\thechapter       {\arabic{chapter}}
\def\thesection       {\thechapter.\arabic{section}}
\def\thesubsection    {\thesection.\arabic{subsection}}
\def\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\def\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\def\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

% ==============================================================================
% |                                   PART                                     |
% ==============================================================================

% define part counter
\newcounter {part}


% ==============================================================================
% |                              FIGURES & TABLES                              |
% ==============================================================================

% FIGURES

% define figure counter
\newcounter {figure}[chapter]

% macro for figures
\def\thefigure{\thechapter.\@arabic\c@figure}

\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\def\figure{\@float{figure}}
\def\endfigure{\end@float}
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}


% TABLES

% define table counter
\newcounter {table}[chapter]

% macro for tables
\def\thetable{\thechapter.\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\def\table{\@float{table}}
\def\endtable{\end@float}
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}


% ==============================================================================
% |                                 FOOTNOTES                                  |
% ==============================================================================



% ==============================================================================
% |                                   LISTS                                    |
% ==============================================================================

% define quote environment
\newenvironment {quote}
    {\list{}{\rightmargin\leftmargin}\item\relax}
    {\endlist}

% ==============================================================================
% |                               BIBLIOGRAPHY                                 |
% ==============================================================================



% ==============================================================================
% |                               MISCELLANEOUS                                |
% ==============================================================================



% ==============================================================================
% |                              INITIALIZATION                                |
% ==============================================================================

\ps@plain
\pagenumbering {arabic}

\if@twoside
\else
    \raggedbottom
\fi

\setlength\lineskip {0.8\p@}
\setlength\parindent {0.25in}
\setlength\paperheight {11in}
\setlength\paperwidth {8.5in}

\endinput