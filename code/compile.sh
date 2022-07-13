echo "require(rmarkdown); render('$1.Rmd', output_file='$1.tex')" | R --vanilla
#sed "s#begin{document}#begin{document}\n\\\includepdf\[pages=1,fitpaper\]{../pdfs/cover-$1.pdf}\n#" "$1.tex" | grep -A4 "begin{document}"

sed "s#\\\frontmatter#\\\frontmatter\n\\\includepdf\[pages=1,fitpaper\]{../pdfs/cover-$1.pdf}#" "$1.tex" > tmp && mv tmp $1.tex && rm tmp
sed "s#pgfplots}#pgfplots}\n\\\usetikzlibrary{positioning,arrows.meta}#" "$1.tex" > tmp && mv tmp $1.tex && rm tmp

echo "require(tinytex); pdflatex('$1.tex')" | R --vanilla
#find . -maxdepth 1 -name "*.pdf" -exec mv {} ../pdfs \;
ls | grep *.pdf | xargs -I _ mv _ ../pdfs/_

echo "Done!"
