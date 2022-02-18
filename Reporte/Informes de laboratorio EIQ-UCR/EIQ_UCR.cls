% Este archivo configura el documento. Se recomienda no modificarlo.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{EIQ_UCR}[2018/01/19 Clase formato EIQ]
\LoadClassWithOptions{elsarticle}


% Márgenes y balance de columnas
\RequirePackage{geometry}
\geometry{verbose,tmargin=2.5cm,bmargin=2.5cm,lmargin=2cm,rmargin=2cm}
\RequirePackage{flushend}
% \RequirePackage{balance} % alternativa

% Texto e idioma
\RequirePackage[utf8x]{inputenc}
\RequirePackage[english, main=spanish]{babel}
\RequirePackage{microtype}

% Matemáticas y unidades
\RequirePackage{amsmath, amssymb, mathtools}
% 	\numberwithin{equation}{section}
\RequirePackage{siunitx}

% Símbolos, reacciones y ecuaciones químicas
\usepackage[version=4,arrows=pgf-filled]{mhchem}

% Nomenclatura
\RequirePackage{nomencl}
\makenomenclature
\renewcommand{\nomname}{Nomenclatura}

% Cuadros y figuras
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{supertabular}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{caption}
	\captionsetup{format=hang, skip=3pt, labelfont=bf, labelsep=period}
    \captionsetup[figure]{textformat=period}
    

% Bibliografía y referencias cruzadas
\RequirePackage{apalike}
\RequirePackage[colorlinks=true,
                linkcolor=black, 
                citecolor=blue, 
                urlcolor=blue
                ]{hyperref}
\bibliographystyle{apalike-es}
\biboptions{authoryear}

% Herramientas de programación
\RequirePackage{etoolbox}
\RequirePackage{xparse}

% Encabezado: título y resúmenes
\newcommand{\encabezado}{%
	\makeatletter
    % No se especificó curso
	\ifx\@journal\@empty%
    	\ClassWarningNoLine{EIQ_UCR}{Recuerde especificar el nombre del curso} 
    \fi%
	\ifx\fechaEncabezado\@empty%
       \else%
       \renewcommand*\hoy{\fechaEncabezado}%
       \fi%
	\makeatother
    \begin{frontmatter}
        \begin{abstracts}
            \input{0_Preliminar}
        \end{abstracts}
    \end{frontmatter}
}

% % Modificar pie de la primera página
% \def\ps@pprintTitle{%
%    	\let\@oddhead\@empty
%    	\let\@evenhead\@empty
%    	\def\@oddfoot{}
% 	\let\@evenfoot\@oddfoot
% }

% Comandos para encabezado
\newcommand\fecha[1]{
	\expandafter\gdef\csname fechaEncabezado\endcsname{#1}
}
\def\fechaEncabezado{}
\newcommand{\curso}[1]{\journal{#1}}
\newcommand{\autor}[1]{\author{#1}}
\newcommand{\titulo}[1]{\title{#1}}
\def\hoy{\today}
\newcommand\direccion[1]{\address{#1}}

% Pie de página con nombre de curso
\patchcmd{\ps@pprintTitle}{\footnotesize\itshape
       Preprint submitted to \ifx\@journal\@empty Elsevier
       \else\@journal\fi\hfill\today}{% Texto nuevo
       \footnotesize\itshape
       \ifx\@journal\@empty
       \else Informe para el curso \@journal\fi\hfill\hoy
       }{}{}
       
% Permitir resumen en dos idiomas
\newenvironment{abstracts}
 	{% Inicio
    	\global\setbox\absbox=\vbox\bgroup%
		\hsize=\textwidth%
    	\linespread{1}\selectfont%
    }
 	{% Final
    	\vspace{-\bigskipamount}\egroup%
    }
    
% Macro para procesar listas
\newcommand{\palabrasClave}[2][\sep]{%
	\def\nextitem{\def\nextitem{#1}}% separador
    \renewcommand*{\do}[1]{\nextitem##1}% cómo procesar
    \docsvlist{#2}% procesar
}

% Resumen en español
\NewDocumentEnvironment{resumen}{m}
  	{% Inicio
    	\selectlanguage{spanish}\noindent%
    	\textbf{\abstractname}\par\medskip\ignorespaces%
    }
  	{% Final
    	\par\bigskip\vspace{-0.17cm}%
        \noindent\textit{Palabras clave: }%
        \raggedright%
        \ignorespaces
          	\def\sep{\unskip, }%
			\palabrasClave{#1}%
    	\par\bigskip%
	}

% Resumen en inglés
\RenewDocumentEnvironment{abstract}{m}
  	{% Inicio
    	\selectlanguage{english}\noindent%
    	\textbf{\abstractname}\par\medskip\noindent\ignorespaces%
    }
  	{% Final
    	\par\bigskip\vspace{-0.17cm}%
        \noindent\textit{Keywords: }%
        \raggedright%
        \ignorespaces
          	\def\sep{\unskip, }%
			\palabrasClave{#1}%
    	\par\bigskip%
	}
    
% Corregir numeración de apéndices
\newcommand{\apendice}{%
    \renewcommand{\thesection}{\Alph{section}}
    \setcounter{section}{0}
}