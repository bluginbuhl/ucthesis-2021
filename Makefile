filename=dissertation
outputdir=output/
SHELL=/bin/bash

all:
	pdflatex -output-directory ${outputdir} ${filename}