% ==============================================================================
% Document Class for ucthesis-CA2021
%
% Released 2021 Apr 30
% author: Benjamin R. Luginbuhl
%
% modified from previous versions by:
%    Chris Martin
%    Mathias Kolsch
%    Jerry Leichter
%    Curtis Asplund
%    ... and probably others.
% ==============================================================================


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{styles/ucthesis-CA2021}

% ==============================================================================
% |                                   OPTIONS                                  |
% ==============================================================================

% options: Xpt [X=12], final/draft, oneside/twoside

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

% choose the font size
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

\if@twoside
  \def\ps@headings{
        \def\@oddfoot{\rm\hfil\thepage\hfil}
        \def\@evenfoot{\rm\hfil\thepage\hfil}
        \def\@evenhead{\hfil\slshape\leftmark}%
        \def\@oddhead{{\slshape\rightmark}\hfil}%
        \let\@mkboth\markboth
        \def\chaptermark##1{%
            \markboth {\MakeUppercase{%
                \ifnum \c@secnumdepth >\m@ne
                    \if@mainmatter
                        \@chapapp\ \thechapter. \ %
                    \fi
                \fi
                ##1
                    }
                }{}
        }%
        \def\sectionmark##1{%
            \markright {\MakeUppercase{%
                \ifnum \c@secnumdepth >\z@
                    \thesection. \ %
                \fi
                ##1}}}}
\else
    \def\ps@headings{%
        \def\@oddfoot{\rm\hfil\thepage\hfil}
        \def\@oddhead{{\slshape\rightmark}\hfil}%
        \let\@mkboth\markboth
        \def\chaptermark##1{%
            \markright {\MakeUppercase{%
                \ifnum \c@secnumdepth >\m@ne
                    \if@mainmatter
                        \@chapapp\ \thechapter. \ %
                    \fi
                \fi
                ##1}}}}
\fi

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
    \renewcommand{\thepage}{\roman{page}}\setcounter{page}{1}
    {\pagestyle{plain}}
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
        \input content/frontmatter/acknowledgements.tex 
    \end{acknowledgements}
}


% CURRICULUM VITAE

% define environment for vitae
\newenvironment{vitae}{%
    \if@openright \cleardoublepage \else \clearpage \fi
    \ssp
    \begin{center}
        {\large \bfseries \vitaename} \par
        {\small \@author}
    \end{center}\hfil
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


% ABSTRACT

% define environment for abstract
\newenvironment{abstract}{%
    \if@openright \cleardoublepage \else \clearpage \fi
    \begin{center}
        {\fmfont {\bfseries \abstractname}\par
        \vspace{0.3in}
        \@title\par
        \vspace{0.1in}by\par
        \vspace{0.1in}\@author\par
        }
    \end{center}
    \hfil
    \dsp
}{\par\vfil\null}

% ==============================================================================
% |                             TABLE OF CONTENTS                              |
% ==============================================================================

% variables
\newif\if@restonecol
\def\@pnumwidth{1.55em}
\def\@tocrmarg{2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{2}

\def\tableofcontents{
    \@restonecolfalse
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \fi
    \chapter*{
        \contentsname
        \@mkboth{\uppercase{\contentsname}}
        {\uppercase{\contentsname}}
    }%
    {\ssp\@starttoc{toc}}
    \if@restonecol
        \twocolumn
    \fi
}

\def\l@part#1#2{
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em plus\p@}
    \begingroup
    \@tempdima 3em
    \parindent \z@ \rightskip \@pnumwidth 
    \parfillskip -\@pnumwidth
    {\large \bfseries
        \leavevmode
        #1\hfil \hbox to\@pnumwidth{\hss #2}
    }\par
    \nobreak
    \global\@nobreaktrue
    \everypar{
        \global\@nobreakfalse\everypar{}
    }
   \endgroup
}

\def\l@chapter#1#2{
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em plus\p@   % space above chapter line
    \@tempdima 1.5em       % width of box holding chapter number
    \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \bfseries
        \leavevmode          
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
        \penalty\@highpenalty
    \endgroup
}

\def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

% LIST OF FIGURES
\def\listoffigures{
    \@restonecolfalse
    \if@twocolumn\@restonecoltrue\onecolumn\fi
    \chapter*{
        \listfigurename\@mkboth{\uppercase{\listfigurename}}%
        {\uppercase{\listfigurename}}
    }
    \addcontentsline{toc}{chapter}{\listfigurename}
    {\ssp\@starttoc{lof}}
    \if@restonecol\twocolumn\fi
}

\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

% LIST OF TABLES

\def\listoftables{
    \@restonecolfalse
    \if@twocolumn\@restonecoltrue\onecolumn\fi
    \chapter*{
        \listtablename\@mkboth{\uppercase{\listtablename}}%
        {\uppercase{\listtablename}}
    }
    \addcontentsline{toc}{chapter}{\listtablename}
    {\ssp\@starttoc{lot}}
    \if@restonecol\twocolumn\fi
}

\let\l@table\l@figure

% ==============================================================================
% |                                 MAINMATTER                                 |
% ==============================================================================

\newenvironment{mainmatter}{%
    \if@openright\cleardoublepage \else\clearpage\fi
    \dsp
    \pagestyle{headings}
    \setcounter{page}{1}
    \pagenumbering{arabic}
}{}

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

% CHAPTERS
\renewcommand\chapter{
    \if@openright\cleardoublepage \else\clearpage \fi
    \thispagestyle{plain}
    \global\@topnum\z@
    \@afterindentfalse
    \secdef\@chapter\@schapter
}

% redefine startsection so there is always indentation
\def\@startsection#1#2#3#4#5#6{
    \if@noskipsec \leavevmode \fi
    \par \@tempskipa #4\relax
    \@afterindenttrue
    \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \relax\fi
    \if@nobreak
        \everypar{}
    \else
        \addpenalty{\@secpenalty}\addvspace{\@tempskipa}
    \fi
    \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}


% redefine @sect
\def\@sect#1#2#3#4#5#6[#7]#8{
    \ifnum #2>\c@secnumdepth
        \let@svsec\@empty
    \else
        \refstepcounter{#1}%
        \let\@@protect\protect
        \def\protect{
            \noexpand
            \protect
            \noexpand
        }%
        \edef\@svsec{
            \@seccntformat{#1}
        }%
        \let\protect\@@protect
    \fi
    \@tempskipa #5\relax
    \ifdim \@tempskipa>\z@
        \begingroup #6\relax
        \@hangfrom{
            \hskip #3\relax\@svsec
        }{\interlinepenalty \@M #8\par}
        \endgroup
        \csname #1mark\endcsname{#7}\addcontentsline{toc}{#1}{
            \ifnum #2>\c@secnumdepth
            \else
                \protect
                \numberline{
                    \csname the#1\endcsname
                }
            \fi
            #8
        }
    \else
        \def\@svsechd{
            #6\hskip #3\relax
            \@svsec #8\csname #1mark\endcsname
            {#7}\addcontentsline{toc}{#1}{
                \ifnum #2>\c@secnumdepth
                \else
                    \protect
                    \numberline{
                        \csname the#1\endcsname
                    }%
                \fi
                #8
            }
        }
    \fi
    \@xsect{#5}
}

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

\def\part{\cleardoublepage
    \thispagestyle{plain}
    \if@twocolumn
        \onecolumn
        \@tempswatrue
    \else
        \@tempswafalse
    \fi
    \hbox{}\vfil
    \secdef\@part\@spart
}

\def\@part[#1]#2{
    \ifnum \c@secnumdepth >-2\relax
        \refstepcounter{part}
        \addcontentsline{toc}{part}{\partname~\thepart}
        \hspace{1em}#1
    \else
        \addcontentsline{toc}{part}{#1}
    \fi
    \markboth{}{}
    {\centering
        \interlinepenalty \@M
        \ifnum \c@secnumdepth >-2\relax
            \huge\bfseries \parname~\thepart
            \par
            \vskip 20\p@
        \fi
        \Huge \bfseries #2\par
    }\@endpart
}

\def\@endpart{
    \vfil\newpage
    \if@twoside
        \hbox{}
        \thispagestyle{empty}
        \newpage
    \fi
    \if@tempswa
        \twocolumn
    \fi
}


% ==============================================================================
% |                              FIGURES & TABLES                              |
% ==============================================================================

\setcounter{topnumber}{2}
\def\topfraction{0.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{0.3}
\setcounter{totalnumber}{3}
\def\textfraction{0.2}
\def\floatpagefraction{0.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{0.7}
\def\dblfloatpagefraction{0.5}

\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}

% define makecaption macro
% TODO: fix page break on large captions
\long\def\@makecaption#1#2{
    \vskip\abovecaptionskip
    \sbox\@tempboxa{
        \smallssp 
        \bfseries{#1}: 
        \normalfont{#2}
    }
    \ifdim \wd\@tempboxa >\hsize
        \hbox to\hsize{
            {\parbox{0.9\textwidth}
                {\smallssp\unhbox\@tempboxa\hfil}
            }
        }
    \else
        \hbox to\hsize{
            \box\@tempboxa\hfil
        }
    \fi
    \vskip\belowcaptionskip
}


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

\arraycolsep 5pt
\tabcolsep 6pt
\arrayrulewidth 0.4pt
\doublerulesep 2pt

\def\array{
    \let\@acol\@arrayacol
    \let\@classz\@arrayclassz
    \let\@classiv\@arrayclassiv
    \let\\\@arraycr\let\@halignto\@empty\@tabarray
}

% TABBING
\tabbingsep \labelsep

\def\tabular{
    \par
    \ssp
    \let\@halignto\@empty\@tabular
}

\expandafter \def\csname tabular*\endcsname #1%

{\par\ssp\def\@halignto{to#1}\@tabular}


% ==============================================================================
% |                                 FOOTNOTES                                  |
% ==============================================================================

\def\footnoterule{
    \kern-3\@p
    \hrule width 0.4\columnwidth
    \kern 2.5\p@
}

\@addtoreset{footnote}{chapter}

\long\def\@makefntext#1{
    \parindent 1em
    \noindent
    \hbox to 1.8em
    {\hss$\m@th^{\@thefnmark}$}
    #1
}

\long\def\@footnotetext#1{
    \insert
    \footins{
        \ssp
        \reset@font
        \footnotesize
        \splittopskip
        \footnotesep
        \splitmaxdepth
        \dp\strutbox
        \floatingpenalty
        \@MM
        \hsize
        \columnwidth
        \@parboxrestore
        \edef\@currentlabel{
            \csname p@footnote
            \endcsname
            \@thefnmark
        }
        \@makefntext
        {\rule{\z@}{\footnotesep}
        \ignorespaces
        #1
        \strut
        }
    }
}

% ==============================================================================
% |                                   LISTS                                    |
% ==============================================================================

% TODO: clean this up
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}


% define description environment
\newenvironment{description}{
    \list{}{
        \labelwidth\z@ \itemindent-\leftmargin
        \let\makelabel\descriptionlabel
        }
    }
    {\endlist}

\newcommand*\descriptionlabel[1]{
    \hspace\labelsep
    \normalfont
    \bfseries #1
}

% define quotation environment
\newenvironment{quotation}{
    \list{}{
        \listparindent 1.5em
        \itemindent\listparindent
        \rightmargin\leftmargin
        \parsep\z@ \@plus\p@
    }\item\relax}
    {\endlist}

% define quote environment
\newenvironment {quote}
    {\list{}{\rightmargin\leftmargin}\item\relax}
    {\endlist}

% ==============================================================================
% |                               BIBLIOGRAPHY                                 |
% ==============================================================================

\def\thebibliography#1{
    \chapter*{
        \bibname\@mkboth{
            \uppercase{
                \bibname
            }
        }
        {\uppercase{\bibname}}
    }
    \list{
        \@biblabel{
            \arabic{enumiv}
        }
    }
    {\settowidth\labelwidth{\@biblabel{#1}}
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \usecounter{enumiv}
        \let\p@enumiv\@empty
        \def\theenumiv{
            \arabic{enumiv}
        }
    }
    \def\newblock{
        \hskip 0.11em plus 0.33em minus 0.07em
    }
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=\@m
    \ssp
}

\def\endthebibliography{
    \def\@noitemerr{
        \@warning{Empty 'thebibiolography' environment}
    }
    \endlist
    \dsp
}

% ==============================================================================
% |                               MISCELLANEOUS                                |
% ==============================================================================

% reset equation counter with each chapter
\@addtoreset{equation}{chapter}

\def\theequation{
    \thechapter.\arabic{equation}
}

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