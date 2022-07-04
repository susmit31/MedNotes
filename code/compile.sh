echo "require(rmarkdown); require(tinytex); render('medicine.Rmd', output_file='medicine.tex'); pdflatex('medicine.tex')" | R --vanilla
find . -maxdepth 1 -name "*.pdf" -exec mv {} ../pdfs \;
