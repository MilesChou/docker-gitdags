#!/bin/sh

if [ "$1" = "sh" ]; then
  exec sh
  exit 0
fi

if [ -f Makefile ]; then
  make $1
else
  for f in $(ls *.tex)
  do
    pdflatex ${f}
    basef=$(echo $f | sed 's/.tex//g')
    rm -f *.log
    rm -f *.aux
    convert -density 300 ${basef}.pdf -quality 100 ${basef}.png
  done
fi
