%% cascadilla-xelatex-biblatex.cls
%% Copyright 2020 András Bárány
%% Version 0.1
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is András Bárány.
%
% This work consists of the files cascadilla-xelatex-biblatex.cls,
% example.tex, example.bib.

% This (Xe)LaTeX class provides a document class that aims to conform to the
% requirements of the Cascadilla Proceedings Project
% (http://www.lingref.com/cpp/authors/style.html), used for WCCFL proceedings,
% for example. In contrast to Max Bane's existing cascadilla.cls, it is
% intended to be used with XeLaTeX and biblatex.
%
% Changes:
% Version 0.1: Initial release.
%   -   First implementation of style CCP style sheet.

%%% Identification

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cascadilla-xelatex-biblatex}[2020/04/07 v0.1 Class for
Cascadilla Proceedings Project articles by András Bárány]

%%% Declarations

\LoadClass[10pt,numbers=enddot]{scrartcl}

\RequirePackage{polyglossia}
\setdefaultlanguage{english}

%% biblatex

\RequirePackage[%
        sortlocale=auto,
        backend=biber,
        dashed=false,
        citestyle=sp-authoryear-comp,
        bibstyle=biblatex-sp-unified,
        doi=true,
        useprefix=true,
        mincrossrefs=3,
        backref=false,
        maxbibnames=9,
        sortcites,
        maxcitenames=2]{biblatex}

%% fontspec and unicode-math

\RequirePackage{mathtools}
\RequirePackage[warnings-off={mathtools-colon,mathools-overbracket}]{unicode-math}
\RequirePackage{fontspec}
\defaultfontfeatures{Mapping=tex-text}
\usepackage{xltxtra}

\RequirePackage{geometry}
\RequirePackage{indentfirst}
\setlength{\parindent}{.25in}
\RequirePackage{scrlayer-scrpage}

%% For dealing with options

\RequirePackage{xifthen}

%%% Class options

\newboolean{a4paper}
\setboolean{a4paper}{true}
\newboolean{letter}
\setboolean{letter}{false}

\newboolean{termes}
\setboolean{termes}{true}
\newboolean{timesnewroman}
\setboolean{timesnewroman}{false}

\DeclareOption{timesnewroman}{\setboolean{termes}{false}\setboolean{timesnewroman}{true}}
\DeclareOption{letter}{\setboolean{a4paper}{false}\setboolean{letter}{true}}

\ProcessOptions*

%%% Class commands and other properties

% french spacing (no double space after ".")

\frenchspacing

\ifthenelse{\boolean{a4paper}}{%
    \geometry{a4paper,
              left=3.15cm,
              right=3.15cm,
              top=2.54cm,
          bottom=4.29cm}
}

\ifthenelse{\boolean{letter}}{%
    \geometry{letterpaper,
              left=1.38in,
              right=1.38in,
              top=1in,
          bottom=1in}
}

% Typefaces

\ifthenelse{\boolean{termes}}{%
    \setromanfont[Numbers=Lining]{TeXGyreTermes-Regular}
    \setmathfont{texgyretermes-math.otf}
}

\ifthenelse{\boolean{timesnewroman}}{%
    \setromanfont[Numbers=Lining]{Times New Roman}
    \setmathfont{texgyretermes-math.otf}
    \renewcommand{\textsc}[1]{{\addfontfeatures{FakeStretch=1.1,Scale=0.7}\MakeUppercase{#1}}}
}

% biblatex tweaks

%% indentation
\setlength{\bibhang}{.25in}

%% use filename.bib as default source

\addbibresource{\jobname.bib}

%% add citeposs command: Lastname's (year)

\NewDocumentCommand{\citeposs}{O{}m}{%
    {\ifthenelse{\isempty{#1}}%
        {\citeauthor{#2}'s (\citeyear{#2})}%
        {\citeauthor{#2}'s (\citeyear{#2}: #1)}%
    }%
}

%% Allow the use of pubstates

\DeclareSourcemap{%
    \maps[datatype=bibtex]{%
        \map[overwrite=true]{% Notice the overwrite: replace one field with another
            \step[fieldsource=pubstate]
            \step[fieldset=year, origfieldval]
        }
    }
}

\AtEveryBibitem{%
    \clearfield{pubstate}%
}

\NewBibliographyString{toappear}
\DefineBibliographyStrings{english}{%
    toappear = {to appear},
}

% Change bibliography font to 9pt

\renewcommand{\bibfont}{\small}

% Headers and footers

\pagestyle{empty}

% Headers according to style sheet

\setkomafont{title}{\bfseries}

% adapted from https://tex.stackexchange.com/questions/82850/change-the-title-size-in-scrartcl
\makeatletter
\renewcommand\maketitle{
    \noindent The text and figures in this PDF are approved by the author(s) for
    publication. Any mistakes in this PDF will not be corrected by the
    publisher. This PDF was created on \today.\par
    \begin{center}
        {\fontsize{18pt}{18pt}\bfseries\@title\par\vspace{1\baselineskip}}
        {\Large\bfseries\@author\vspace{1\baselineskip}}
   \end{center}
}
\makeatother

% Section and subsection headings
\setcounter{secnumdepth}{3}
\DeclareSectionCommand[
    afterindent=true,
    beforeskip=10pt,
    afterskip=10pt,
]{section}

\setkomafont{section}{\large\normalfont\bfseries}
\renewcommand*{\sectionformat}{\thesection\autodot\ \relax}

\DeclareSectionCommand[
    afterindent=true,
    beforeskip=10pt,
    afterskip=10pt,
]{subsection}

\DeclareSectionCommand[
    afterindent=true,
    beforeskip=10pt,
    afterskip=10pt,
]{subsubsection}

\setkomafont{subsection}{\fontsize{11pt}{13pt}\normalfont\bfseries\itshape}
\renewcommand*{\subsectionformat}{\thesubsection\autodot\ \relax}
\setkomafont{subsubsection}{\fontsize{11pt}{13pt}\normalfont\bfseries\itshape}
\renewcommand*{\subsubsectionformat}{\thesubsubsection\autodot\ \relax}

\newcommand{\imsubsection}[1]{
    \vspace{-10pt}
    \subsection{#1}
}

\newcommand{\imsubsubsection}[1]{
    \vspace{-10pt}
    \subsubsection{#1}
}

% Footnotes
\renewcommand{\footnotesize}{\small}
\deffootnote[.75em]{0pt}{0pt}{%
    \makebox[.75em][l]{\textsuperscript{\thefootnotemark}}%
}
% adapted from https://tex.stackexchange.com/questions/183516/footnote-with-no-footnotemark
\renewcommand{\thanks}[1]{{%
    \renewcommand{\thefootnote}{*}%
    \footnotetext[0]{#1}
}}

% Captions
\setkomafont{captionlabel}{\bfseries}
