\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sigirforum}[2021 SIGIR Forum LaTeX class]

% CLASS OPTIONS FOR PUBLICATION TYPE
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=forum,
	prefix=forum@
}
\DeclareBoolOption{news}
\DeclareBoolOption{keynote}
\DeclareBoolOption{paper}
\DeclareBoolOption{event}
\DeclareBoolOption{opinion}
\DeclareBoolOption{dissertation}
\ProcessKeyvalOptions*

\ifforum@news\def\pubtype{SIGIR NEWS}\else
\ifforum@keynote\def\pubtype{KEYNOTE EXTENDED ABSTRACT}\else
\ifforum@paper\def\pubtype{PAPER}\else
\ifforum@event\def\pubtype{EVENT REPORT}\else
\ifforum@opinion\def\pubtype{OPINION PAPER}\else
\ifforum@dissertation\def\pubtype{DISSERTATION ABSTRACT}\else
\ClassError{sigirforum}{No publication type defined.}{You need to define a publication type as a class options: news, keynote, paper, event, opinion or dissertation.}
\fi\fi\fi\fi\fi\fi

% LOAD BASE CLASS AND REQUIRED PACKAGES
\LoadClass[12pt]{article}
\ProcessOptions

\RequirePackage{etoolbox}
\RequirePackage{lipsum} 
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{url}
\RequirePackage[colorlinks=true,allcolors=blue]{hyperref}
\RequirePackage[square]{natbib}
\RequirePackage{fix-cm}
\RequirePackage{graphicx}
\RequirePackage[utf8]{inputenc}
\RequirePackage{color}
\RequirePackage{amsmath}
\RequirePackage{xspace}
\RequirePackage{enumitem}

% SET PAGE SIZE AND REMOVE BETWEEN-ITEM SPACES
\topmargin -0.8cm
\oddsidemargin -0.7cm
\textwidth 17.5cm
\textheight 22.6 cm

\setlist[enumerate,itemize]{topsep=0.25\baselineskip,noitemsep,after=\vspace{0.5\baselineskip}}

% PAGE HEAD AND FOOT
\pagestyle{fancyplain}
\fancyhead{}
\fancyfoot[L]{ACM SIGIR Forum}
\fancyfoot[C]{\thepage}
\fancyfoot[R]{\pubissue}
\renewcommand\plainheadrulewidth{1pt}
\renewcommand\plainfootrulewidth{1pt}
\renewcommand\headrulewidth{1pt}
\renewcommand\footrulewidth{1pt}

% TITLE
\def\@maketitle{%
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
  \vskip 1.5em%
}

% DISSERTATION ABSTRACTS REDEFINE THE ABSTRACT ENVIRONMENT, ADD METADATA AND RENAME THE BIBLIOGRAPHY SECTION
\ifforum@dissertation
	\renewenvironment{abstract}{%
		\small\begin{center}%
			{\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
		\end{center}\normalsize
	}
	{%
		\par\vspace{1.5\baselineskip}%
		\noindent\textbf{Awarded by:} \dissertationplace\xspace\textbf{on} \dissertationdate.\par%
		\noindent\textbf{Supervised by:} \dissertationsupervisor.%
		\ifdefstring{\dissertationurl}{}{}{%
			\par\noindent\textbf{Available at:} \url{\dissertationurl}.%
		}%
	}
	\renewcommand{\refname}{Selected Publications}
\else
	\renewenvironment{abstract}{%
		\small\begin{center}%
			{\bfseries\abstractname\vspace{-.5em}\vspace{\z@}}%
		\end{center}\quote%
	}
	{%
		% EVENT REPORTS ADD METADATA
		\ifforum@event
			\par%
			\noindent\textbf{Date:} \eventdate.%
			\ifdefstring{\eventurl}{}{}{%
				\par\noindent\textbf{Website:} \url{\eventurl}.%
			}%
		\fi
		\endquote%
	}
\fi

\bibliographystyle{plainnat}
\endinput