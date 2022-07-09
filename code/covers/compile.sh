echo "require(tinytex); pdflatex('cover-$1.tex')" | R --vanilla
ls | grep *.pdf | xargs -I _ mv _ ../../pdfs/_
