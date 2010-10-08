#!/bin/sh

executable=`basename $0`

BLUE="\033[34m"
LBLUE="\033[34;1m"
RED="\033[31m"
LRED="\033[31;1m"
YELLOW="\033[33m"
LYELLOW="\033[33;1m"
GREEN="\033[32m"
LGREEN="\033[32;1m"
RST="\033[0m"



usage()
{
cat << EOF
Usage: $executable name
This script is intended to generate basic LaTeX Makefile and source.

Report bug at <remi.chaintron@gmail.com>
EOF
}

CMD=latex
ERROR=false
FILENAME=$1
# Get filename
if [ $# -gt 0 ]; then
	FILENAME=$1
else
	usage
	exit 1
fi

# Get latex binary
case `uname` in
	Darwin)
		LATEXBIN=pdflatex;;
	Linux)
		LATEXBIN=`which $CMD`;;
esac

if [[ $? != 0 ]]; then
	echo "${RED}[KO]${RST}		$CMD"
	exit 1
else
	echo "${GREEN}[OK]${RST}		$CMD"
fi


# Generate Makefile
if [ -e Makefile ]; then
	echo "$RED[KO]$RST		Makefile: already existing"
fi
cat > Makefile << EOF
SRC 		= $FILENAME
AUX_SRC 	=
TARGET 		= \$(SRC:.tex=.pdf)
TARGETS 	= \$(TARGET)
JUNK 		= tags *~ .*.swp *.log *.aux *.dvi

BUILD_DIR 	= _build
LATEX 		= $LATEXBIN

all: latex

latex: \$(SRC)
	test -e \$(BUILD_DIR) || mkdir \$(BUILD_DIR)
	\$(LATEX) -output-directory \$(BUILD_DIR) \$(SRC)
	cp \$(BUILD_DIR)/\$(TARGET) .

clean:
	find . -name "*~" -exec rm -rf {} \;
	rm -rf \$(BUILD_DIR)
	rm -rf \$(JUNK)
EOF
if [[ $? -eq 0 ]]; then
	echo "$GREEN[OK]$RST		Makefile"
fi

# Generate source
if [ -e $FILENAME ]; then
	echo "${RED}[KO]${RST}		$FILENAME: already exists"
	exit 1
fi

cat > $FILENAME << EOF
\documentclass[a4paper,10pt,titlepage]{scrartcl} 
\input{$HOME/conf/latex/templates/FIXME}

\stitle{FIXME: title}{FIXME: author}
\date{FIXME: Date}

\begin{document}

\maketitle
\newpage


\end{document}
EOF
if [[ $? -eq 0 ]]; then
	echo "${GREEN}[OK]${RST}		$FILENAME"
fi


