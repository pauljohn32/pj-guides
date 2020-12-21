#!/bin/bash

base=`basename $1 .tex`

pdflatex $base.tex

convert -quality 100 -density 600 -flatten -strip $base.pdf $base.png
