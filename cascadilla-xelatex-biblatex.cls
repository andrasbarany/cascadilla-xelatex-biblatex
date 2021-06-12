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
%   -   First implementation of CPP style sheet.
% Version 1.0:
%   -   Added automatic XeLaTeX / pdfLaTeX recognition.
%   -   Added options for packages.
%   -   Tweaked margins and spacing (raggedbottom).
%   -   Updated documentation.
%   -   Checked with CPP for approval.

%%% Identification

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cascadilla-xelatex-biblatex}[2021/01/08 v1.0 Class for
Cascadilla Proceedings Project articles by András Bárány]

%%% Declarations

\LoadClass[10pt,numbers=enddot]{scrartcl}

%% checking for XeLaTeX

\usepackage{iftex}
\ifxetex
    \RequirePackage[warnings-off={mathtools-colon}]{unicode-math}
    \RequirePackage{fontspec}
    \defaultfontfeatures{Mapping=tex-text}
    \usepackage[no-sscript]{xltxtra}
\else
    \usepackage[utf8]{inputenc}
\fi

%% language(s)

\usepackage[english]{babel}

%% biblatex

\RequirePackage[%
        sortlocale=auto,
        backend=biber,
        dashed=false,
        style=unified,
        doi=true,
        useprefix=true,
        mincrossrefs=3,
        backref=false,
        maxbibnames=9,
%        sortcites,     % uncomment for automatic sorting of citations
        sorting=nyt,
        natbib=true,
        maxcitenames=2]{biblatex}

% Remove "p(p)." prefix
\DeclareFieldFormat{postnote}{#1} % no postnote prefix in "normal" citation commands

\newcommand{\blx@nowarnpolyglossia}{}

%% fontspec and unicode-math

\usepackage{hologo}

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

\newboolean{xits}
\setboolean{xits}{true}
\newboolean{times}
\setboolean{times}{false}

\newboolean{noexpex}
\setboolean{noexpex}{false}
\newboolean{uselinguex}
\setboolean{uselinguex}{false}
\newboolean{usegb4e}
\setboolean{usegb4e}{false}

\DeclareOption{times}{\setboolean{xits}{false}\setboolean{times}{true}}
\DeclareOption{letter}{\setboolean{a4paper}{false}\setboolean{letter}{true}}
\DeclareOption{uselinguex}{\setboolean{noexpex}{true}\setboolean{usegb4e}{false}\setboolean{uselinguex}{true}}
\DeclareOption{usegb4e}{\setboolean{noexpex}{true}\setboolean{uselinguex}{false}\setboolean{usegb4e}{true}}

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

\raggedbottom

% Typefaces

\ifxetex
    \ifthenelse{\boolean{xits}}{%
        \setmainfont[BoldFont = XITS-Bold.otf,
                     BoldItalicFont = XITS-BoldItalic.otf,
                     ItalicFont = XITS-Italic.otf]{XITS-Regular.otf}
        \setmathfont[BoldFont = XITSMath-Bold.otf]{XITSMath-Regular.otf}
    }

    \ifthenelse{\boolean{times}}{%
        \setromanfont[Numbers=Lining]{Times New Roman}
        \setmathfont{XITSMath-Regular.otf}
        \renewcommand{\textsc}[1]{{\addfontfeatures{FakeStretch=1.1,Scale=0.7}\MakeUppercase{#1}}}
    }
\else
    \usepackage{newtxtext}
    \usepackage{newtxmath}
\fi

% Example packages

\ifthenelse{\boolean{noexpex}}{}{%
    \RequirePackage{expex}
	\lingset{numoffset=1em,everygla=,aboveglftskip=0ex,belowglpreambleskip=0ex}
    \usepackage{etoolbox}
    % Fixing expex and unicode-math
    \let\expexgla\gla                   % unicode-math has a “gla” command ---
    \AtBeginDocument{\let\gla\expexgla} % we redefine the expex one, and define
                                        % it back at the beginning of the document

}

\ifthenelse{\boolean{usegb4e}}{%
	\RequirePackage{gb4e}
	\def\glt{}
	\def\trans{}

	\def\@exe[#1]{%
		\ifnum \@xnumdepth >0%
	    	\if@xrec\@exrecwarn\fi%
	        \if@noftnote\@exrecwarn\fi%
	        \@xnumdepth0\@listdepth0\@xrectrue%
	        \save@counters%
	    \fi%
	    \advance\@xnumdepth \@ne \@@xsi%
	    \begin{list}{(\thexnumi)}%
	    	{\usecounter{xnumi}\@subex{#1}{1em}%
	        \if@noftnote%
	           \setcounter{xnumi}{\value{exx}}%
	        \else%
	           \setcounter{xnumi}{\value{fnx}}%
	        \fi
	        \setlength{\topsep}{\baselineskip}\relax
	        \setlength{\itemsep}{\baselineskip}\relax
	    	}
	}
}

\ifthenelse{\boolean{uselinguex}}{%
	\RequirePackage{linguex}
    \renewcommand{\resetExdefaults}{%
        \setlength{\Exlabelsep}{0.6em}%
        \setlength{\Extopsep}{\baselineskip}%
        \setlength{\SubSubExleftmargin}{2.4em}%
        \setlength{\SubExleftmargin}{2em}%
        \setlength{\Exindent}{1em}%
        \setlength{\Exlabelwidth}{3em}%
        \setlength{\alignSubExnegindent}{\Exlabelsep}%
        \ifalignSubEx\addtolength{\Exlabelsep}{.7em}%
            \addtolength{\alignSubExnegindent}{.7em}\fi
        \setlength{\Exredux}{-\baselineskip}%
    }
}

% biblatex tweaks

%% indentation
\setlength{\bibhang}{.25in}

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
    beforeskip=\baselineskip,
    afterskip=\baselineskip,
]{section}

\setkomafont{section}{\large\normalfont\bfseries}
\renewcommand*{\sectionformat}{\thesection\autodot\ \relax}

\DeclareSectionCommand[
    afterindent=true,
    beforeskip=\baselineskip,
    afterskip=\baselineskip,
]{subsection}

\DeclareSectionCommand[
    afterindent=true,
    beforeskip=\baselineskip,
    afterskip=\baselineskip,
]{subsubsection}

\setkomafont{subsection}{\fontsize{11pt}{13pt}\normalfont\itshape}
\renewcommand*{\subsectionformat}{\thesubsection\autodot\ \relax}
\setkomafont{subsubsection}{\fontsize{11pt}{13pt}\normalfont\itshape}
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

% No links
\usepackage[unicode,hidelinks,draft]{hyperref}

% Other packages
\usepackage{booktabs}
\usepackage{csquotes}
\usepackage{cleveref}
