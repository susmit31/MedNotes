echo "require(rmarkdown); require(tinytex); render('$1.Rmd', output_file='$1.tex'); pdflatex('$1.tex')" | R --vanilla
#find . -maxdepth 1 -name "*.pdf" -exec mv {} ../pdfs \;
ls | grep *.pdf | xargs -I _ mv _ ../pdfs/_

echo "Done!"
