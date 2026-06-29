%%
% Class Identification
%%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{SSSongbook}
[2010/03/19 Stretton Strummers Songbook]

%%
% Options inherited from book.cls and songbook.cls
%%
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{book}}
\DeclareOption{a5paper}{\PassOptionsToClass{a5paper}{book}}
\DeclareOption{wordbk}{\PassOptionsToClass{wordbk}{songbook}}
\DeclareOption{chordbk}{\PassOptionsToClass{chordbk}{songbook}}
% Option of Caroline's baritone
\newif\ifBaritone \Baritonefalse
\DeclareOption{baritone}{\Baritonetrue}
\ProcessOptions

%%
% Packages
%%
\LoadClass{book}
% `fancyhdr` clashes withe `songbook` if it is loaded after `songbook`,
% so it has to be loaded first.  Previously this wasn't the case but
% `fancyhdr` was updated in 2019 so the change might have happened then.
\RequirePackage{fancyhdr} % Nicer headers for the revision information
\RequirePackage{songbook} % Songbook layouts
\RequirePackage{gchords} % Layout the ukulele chords
\RequirePackage{hyperref} % Hyperlinks in the PDFs
\RequirePackage[british]{babel} % UK style dates
\RequirePackage[T1]{fontenc} % Required for superscripts for ordinals, don't know why
\RequirePackage{ulem} % Provides the strike out
\RequirePackage{ifthen} % Used to do conditional transpositions
\RequirePackage{makeidx} % Needed to create an index

%%
% The copyright area is going to be used for the factoids so....
%%
\renewcommand{\copyright}{}% Remove the Copyright symbol
\renewcommand{\SBUnknownTag}{} % and remove the unknown tag
\renewcommand{\SBWAndMTag}{} % Words and music tag
\newcommand{\ukuleleSize}{Soprano Ukulele GCEA}
\ifBaritone
\renewcommand{\ukuleleSize}{Baritone Ukulele DGBE}%
\fi
%%
% Don't stretch to fill the pages and don't indent
%%
\raggedbottom
\parindent 0pt

%%
% Header layout for revision and head url for each song.
%%
\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[C]{}% Remove default page number

%%
% Add a table of contents entry to the Song Environment, then
% set the headers with the revision and file tracking information
% and finally rename the environment to be consistent
%%
\newenvironment{SBSong}[4][Y]%
{%
  \phantomsection % required by hyperref
  \begin{samepage}
    \ifChordBk
    \fancyhead[RO,LE]{\thepage}% Page number
    \begin{song}[#1]{#2}% Title
      {}%
      {#3}% Factoid
      {#4}% Author
      {}{}%
      \fi
      \ifWordBk
      \fancyfoot[R]{}%
      \fancyhead[RO,LE]{}%
      \renewcommand{\SBWAndMTag}{} % No author
      \renewcommand{\SpaceAfterTitleBlk}{-2.75ex} % Close space after title bit
      \begin{song}[#1]{#2}% Title
        {#2}% Key
        {~ \vspace{-3.5ex}}% close up the factoid space
        {}% No author
        {}{}%
        \fi
        \addcontentsline{toc}{section}{\theSBSongCnt\ #2}\index{#2}%
      }%
      {%
      \end{song}%
    \end{samepage}
    \fancyhead[LO,RE]{}% blank the headers
    \CBPageBrk %
  }%

  %%
  % Hack to remove the square brackets around the key.
  %%
  \renewcommand{\STitle}[3][Y]{%
    \setcounter{SBVerseCnt}{0}%
    \setcounter{SBSectionCnt}{0}%
    \vspace{\SpaceAboveSTitle}%
    \if#1Y
    \begin{center}\fi
      {\STitleNumberFont\theSBSongCnt}{\STitleFont\ --- #2}%
      \if#1Y
    \end{center}\fi
    \STitleMarkboth{#2}{\relax}%
  }

  %%
  % Provide stage direction and song notes which don't come out in
  % the words only version
  %%
  \newcommand\SBDirection[1]{\ifChordBk {\ChFont #1}  \fi}

  %%
  % Title page layout
  %%
  \newcommand\SBTitlePage[2]{
    \title{#1}
    \author{#2}
    \maketitle
  }%

  %%
  % Each song on same page if possible
  %%
  \let\OldSBSong\SBSong
  \let\endOldSBSong\endSBSong
  \renewenvironment{SBSong}{
    \begin{samepage}
    \begin{OldSBSong}}{
      \end{OldSBSong}
  \end{samepage}\pagebreak}

  %%
  % Convenient superscripts for ordinals
  %%
  \newcommand{\superscript}[1]{\ensuremath{^{\textrm{#1}}}}
  \renewcommand{\th}[0]{\superscript{th}}
  \newcommand{\st}[0]{\superscript{st}}
  \newcommand{\nd}[0]{\superscript{nd}}
  \newcommand{\rd}[0]{\superscript{rd}}

  %%
  % Line breaks for the word book
  %%
  \newcommand{\WBLineBrk}{%
    \ifWordBk%
    \linebreak
  \fi}
  \newcommand{\CBLineBrk}{%
    \ifChordBk%
    \hfill\strut\linebreak
  \fi}

  %%
  % Alter the chord diagram defaults to suit the ukulele.
  %%
  \renewcommand\strings{4}
  \newcounter{defaultFrets}
  \setcounter{defaultFrets}{5}
  \renewcommand\numfrets{\value{defaultFrets}}
  \smallchords

  %%
  % Put the chord in the margin using the Songbook margin note.
  %%
  \newcommand\ChordInMargin[2]
  {%
    \SBMargNote{\chord{t}{#1}{#2}}%
  }%

  \newcommand\LetterToDiagram[3]
  {%
    \ifthenelse{\equal{#1}{#2}}{\ChordInMargin{#3}{#1}}{}%
  }%

  % http://www.ukulele.nl/chordfinder.php
  \newcommand{\SBChord}[1] % Soprano chord diagrams
  {%
    \LetterToDiagram{#1}{A}{p2,p1,n,n}
    \LetterToDiagram{#1}{A7}{n,p1,n,n}
    \LetterToDiagram{#1}{A9}{n,p1,n,p2}
    \LetterToDiagram{#1}{Am}{p2,n,n,n}
    \LetterToDiagram{#1}{Am7}{n,n,n,n}
    \LetterToDiagram{#1}{A$\flat$maj7}{n,p3,p4,p3}
    \LetterToDiagram{#1}{Aminadd9}{p2,n,n,p2}
    \LetterToDiagram{#1}{Asus4}{p2,p2,n,n}
    \LetterToDiagram{#1}{B}{p4,p3,p2,p2}
    \LetterToDiagram{#1}{B7}{p2,p2p3,p2,p2}
    \LetterToDiagram{#1}{B$\flat$}{p3,p2,p1,p1}
    \LetterToDiagram{#1}{B$\flat$maj7}{p3,p2,p1,n}
    \LetterToDiagram{#1}{B$\flat$m}{p3,n,p1,p1}
    \LetterToDiagram{#1}{Bm}{p2p4,p2,p2,p2}
    \LetterToDiagram{#1}{C}{n,n,n,p3}
    \LetterToDiagram{#1}{Bar C}{p3p5,p3p4,p3,p3}
    \LetterToDiagram{#1}{C+}{p1,n,n,p3}
    \renewcommand\numfrets{8}\LetterToDiagram{#1}{C\#m}{p7,p4,p4,p4}\renewcommand\numfrets{\value{defaultFrets}}
    \LetterToDiagram{#1}{C\#7}{p1,p1,p1,p2}
    \LetterToDiagram{#1}{C6}{n,n,n,n}
    \LetterToDiagram{#1}{C7}{n,n,n,p1}
    \LetterToDiagram{#1}{C7sus}{n,n,p1,p1}
    \LetterToDiagram{#1}{CB}{n,n,n,p2}
    \LetterToDiagram{#1}{Cm6}{n,p3,p3,n}
    \LetterToDiagram{#1}{Cmaj7}{n,n,n,p2}
    \LetterToDiagram{#1}{D}{p2,p2,p2,n}
    \LetterToDiagram{#1}{Bar D}{p2,p2,p2,p2p5}
    \renewcommand\numfrets{8}\LetterToDiagram{#1}{Bar D alt}{p5p7,p5p6,p5,p5}\renewcommand\numfrets{\value{defaultFrets}}
    \LetterToDiagram{#1}{Dsus4}{p2,p2,p2p3,p2p5}
    \LetterToDiagram{#1}{D7}{p2,p2,p2,p3}
    \LetterToDiagram{#1}{D$\flat$7}{p1,p1,p1,p2}
    \LetterToDiagram{#1}{Hawaiian D7}{p2,n,p2,n}
    \LetterToDiagram{#1}{Dm7}{p2,p2,p1,p3}
    \LetterToDiagram{#1}{Dm}{p2,p2,p1,n}
    \renewcommand\numfrets{8}\LetterToDiagram{#1}{Bar Dm}{p5p7,p5,p5,p5}\renewcommand\numfrets{\value{defaultFrets}}
    \renewcommand\numfrets{8}\LetterToDiagram{#1}{Bar Dm7}{p5,p5,p5,p5}\renewcommand\numfrets{\value{defaultFrets}}
    \LetterToDiagram{#1}{E}{p4,p4,p4,p2}
    \LetterToDiagram{#1}{E7}{p1,p2,n,p2}
    \LetterToDiagram{#1}{E7+5}{p1,p2,n,p2p3}
    \LetterToDiagram{#1}{Em}{n,p4,p3,p2}
    \LetterToDiagram{#1}{Em7}{n,p2,n,p2}
    \LetterToDiagram{#1}{E$\flat$}{n,p3,p3,p1}
    \LetterToDiagram{#1}{Ebm}{n,p3,p2,p1}
    \LetterToDiagram{#1}{F}{p2,n,p1,n}
    \LetterToDiagram{#1}{F7}{p2,p3,p1,n}
    \LetterToDiagram{#1}{Fmaj7}{p5,p5,n,n}
    \LetterToDiagram{#1}{Fm}{p1,n,p1,p3}
    \LetterToDiagram{#1}{F\#}{p1p3,p1,p1p2,p1}
    \LetterToDiagram{#1}{F\#m}{p2,p1,p2,n}
    \LetterToDiagram{#1}{G}{n,p2,p3,p2}
    \LetterToDiagram{#1}{Gmaj7}{n,p2,p2,p2}
    \LetterToDiagram{#1}{G$\flat$}{p3,p1,p2,p1}
    \LetterToDiagram{#1}{G\#7}{p1,n,p2,p3}
    \LetterToDiagram{#1}{Bar G}{p2p4,p2,p2p3,p2}
    \LetterToDiagram{#1}{G7}{n,p2,p1,p2}
    \LetterToDiagram{#1}{G+7-5}{n,p1,p2,p2}
    \LetterToDiagram{#1}{Gm}{n,p2,p3,p1}
  }%
  \ifBaritone
  \renewcommand{\SBChord}[1] % Baritone chord diagrams
  {%
    \LetterToDiagram{#1}{A}{p2,p2,p2,n}
    \LetterToDiagram{#1}{Am}{p2,p2,p1,n}
    \LetterToDiagram{#1}{A7}{p2,n,p2,n}
    \LetterToDiagram{#1}{Am7}{p2,p2,p1,p3}
    \LetterToDiagram{#1}{B}{p4,p4,p4,p2}
    \LetterToDiagram{#1}{B7}{p1,p2,n,p2}
    \LetterToDiagram{#1}{B$\flat$}{p3,p3,p3,p1}
    \LetterToDiagram{#1}{B$\flat$maj7}{p3,p3,p3,p3p5}
    \LetterToDiagram{#1}{B$\flat$m}{p3,p3,p2,p1}
    \LetterToDiagram{#1}{Bm}{n,p4,p3,p2}
    \LetterToDiagram{#1}{C}{p2,n,p1,n}
    \LetterToDiagram{#1}{C6}{p2,p2,p1,p3}
    \LetterToDiagram{#1}{C7}{p2,p3,p1,n}
    \LetterToDiagram{#1}{C7sus}{p3,p3,p1,p3}
    \LetterToDiagram{#1}{D}{n,p2,p3,p2}
    \LetterToDiagram{#1}{D7}{n,p2,p1,p2}
    \LetterToDiagram{#1}{Dm7}{n,p2,p1,p1}
    \LetterToDiagram{#1}{D$\flat$7}{p3,p4,n,p4}
    \LetterToDiagram{#1}{Dm}{p3,p2,p3,p1}
    \LetterToDiagram{#1}{E}{p2,p1,n,n}
    \LetterToDiagram{#1}{E7}{n,p1,n,n}
    \LetterToDiagram{#1}{Em}{p2,n,n,n}
    \LetterToDiagram{#1}{Em7}{n,n,n,n}
    \LetterToDiagram{#1}{Ebm}{p3,p2,p3,p1}
    \LetterToDiagram{#1}{F}{p3,p2,p1,p1}
    \LetterToDiagram{#1}{F7}{p1,p2,p1,p1}
    \LetterToDiagram{#1}{Fmaj7}{p3,p2,p1,n}
    \LetterToDiagram{#1}{Fm}{p1p3,p1,p1,p1}
    \LetterToDiagram{#1}{F\#}{p4,p3,p2,p2}
    \LetterToDiagram{#1}{F\#m}{p2p4,p2,p2,p2}
    \LetterToDiagram{#1}{G}{n,n,n,p3}
    \LetterToDiagram{#1}{G$\flat$}{p4,p3,p2,p2}
    \LetterToDiagram{#1}{G7}{n,n,n,p1}
    \LetterToDiagram{#1}{Gm}{n,p3,p3,p3}
    \LetterToDiagram{#1}{G\#7}{p1,p1,p1,p1p2}
  }%
  \fi
