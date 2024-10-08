#! /bin/bash

# set path to pdflatex and bibtex for compilation
PDFLATEX='/mnt/c/Program Files/MiKTeX/miktex/bin/x64/pdflatex.exe'
BIBTEX='/mnt/c/Program Files/MiKTeX/miktex/bin/x64/bibtex.exe'

# cleanup
rm -f *.pdf *.aux *.bbl *.blg *.log *.out *.synctex.gz

# initialize folders
rm -f -R zip/*
mkdir -p zip/samples

# instructions: pdflatex+bibtex -> pdf
# checklist: pdflatex -> pdf
# samples: pdflatex+bibtex -> tex+pdf
for f in instructions checklist sample sample_event sample_keynote sample_manyauthors sample_phd
do
	echo "##### $f #####"
	"${PDFLATEX}" -quiet $f
	if [[ $f != "checklist" ]]
	then
		"${BIBTEX}" -quiet $f
		"${PDFLATEX}" -quiet $f
		"${PDFLATEX}" -quiet $f
	fi

	if [[ $f == sample* ]]
	then
		cp -f $f.tex $f.pdf zip/samples/
	else
		cp -f $f.pdf zip/
	fi
done


# class file and bib
cp -f sigirforum.cls sigirforum.bib zip/

echo "##### zip #####"

# pack into a zip and release
mkdir -p releases

echo 'Version? '
read version
rm -f releases/template-${version}.zip
7z a -bb0 releases/template-${version}.zip ./zip/*
7z l releases/template-${version}.zip
