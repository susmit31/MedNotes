BEGIN {
	starting = "\\renewcommand{\\arraystretch}{1.5}\n\\rowcolors{2}{gray!20}{gray!40}\n\\begin{table}[h!]\n\\centering\n\\begin{tabular}"
	heading = "\\cellcolor{violet!60}\\color{white}"
	print "Enter the caption: "
	getline caption < "/dev/stdin"
	ending = sprintf("\\end{tabular}\\caption{%s}\n\\label{table:%s}\n\\end{table}", caption, ARGV[2])
	output = ""
	format = ""
	FS = "|"
}

{
	if (NR == 1){
		format = $0
		output = output starting "{" format "}\n"
	}
	else if (NR == 2){
		for (i = 1; i <= NF; i++){
			output = output heading $i
			if (i != NF)
				 output = output " &\n"
			else
				output = output " \\\\\n"
		}
	}
	else {
		for (i = 1; i <= NF; i++){
			output = output $i
			if (i != NF)
				output = output " & "
			else
				output = output " \\\\\n" 
		}
	}
}

END{
	output = output ending
	print output
	print output > "out.table"
	system("xclip -sel clip out.table")
	system("rm out.table")
	print "\n"
	print "Done!"
}
