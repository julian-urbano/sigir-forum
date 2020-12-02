\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{PhD}[2013/03/11 PhD Dissertation LaTeX class]
\LoadClass[12pt]{article}

\newif\if@dissertation\@dissertationfalse
\DeclareOption{dissertation}{\@dissertationtrue}

\ProcessOptions

\RequirePackage{lipsum} 
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{url}
\RequirePackage[colorlinks=true,allcolors=blue]{hyperref}
\RequirePackage{natbib}
\RequirePackage{fix-cm}
\RequirePackage{graphicx}
\RequirePackage[utf8]{inputenc}
\RequirePackage{color}
\RequirePackage{amsmath}
\RequirePackage{xspace}

\topmargin -0.8cm
\oddsidemargin -0.7cm
\textwidth 17.5cm
\textheight 22.6 cm

\pagestyle{fancyplain}
\fancyhead{}
\fancyfoot[L]{ACM SIGIR Forum}
\fancyfoot[C]{\thepage}
\fancyfoot[R]{\pubissue}
\renewcommand\plainheadrulewidth{1pt}
\renewcommand\plainfootrulewidth{1pt}
\renewcommand\headrulewidth{1pt}
\renewcommand\footrulewidth{1pt}

\def\@maketitle{%
	\if@dissertation
	\def\pubtype{DISSERTATION ABSTRACT}
	\fi
  \newpage
  \null
  \vskip 2em
  \begin{center}%
  \vspace{-2cm}%
  \textbf{\small{\pubtype}}\\\vspace{-0.2cm} \rule{17.5cm}{1pt}%
  \vskip 1cm%
  {\LARGE\bfseries \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large}%
  \end{center}%
  \par
  \vskip 1.5em}

\if@dissertation
\renewenvironment{abstract}{%
  \small
  \begin{center}%
    {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
  \end{center}%  
  \normalsize}
{\par
\vspace{0.3in}
\noindent\textbf{Awarded by:} \dissertationplace\xspace\textbf{on} \dissertationdate.

\noindent\textbf{Supervised by:} \dissertationsupervisor.

\noindent\textbf{Available at:} \url{\dissertationurl}.

}
\renewcommand{\refname}{Selected Publications}
\else
\renewenvironment{abstract}{%
  \small%
  \begin{center}%
    {\bfseries\abstractname\vspace{-.5em}\vspace{\z@}}%
  \end{center}%
  \quote}
{\endquote}
\fi

\bibliographystyle{unsrtnat}
\endinput