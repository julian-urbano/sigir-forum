#! /bin/bash

# set path to pdflatex and bibtex for compilation
PDFLATEX='/mnt/c/Program Files/MiKTeX/miktex/bin/x64/pdflatex.exe'
BIBTEX='/mnt/c/Program Files/MiKTeX/miktex/bin/x64/bibtex.exe'

# ask for template's version and date
echo 'Version? '
read sigirforumversion
echo 'Date? '
read sigirforumdate

embed () { # source, target
	sed "s/{{SIGIRFORUMVERSION}}/${sigirforumversion}/g" $1 | sed "s/{{SIGIRFORUMDATE}}/${sigirforumdate}/g" > $2
}

# initialize folders
rm -f -R zip/*
mkdir -p zip/samples

# class file and bib
echo "##### template #####"

embed sigirforum.cls zip/sigirforum.cls
cp sigirforum.bib zip/

# instructions: pdflatex+bibtex -> pdf
# checklist: pdflatex -> pdf
# samples: pdflatex+bibtex -> tex+pdf
for f in instructions checklist sample sample_event sample_keynote sample_manyauthors sample_phd
do
	echo "##### $f #####"
	embed $f.tex zip/$f.tex
	"${PDFLATEX}" -quiet -output-directory=zip zip/$f
	if [[ $f != "checklist" ]]
	then
		"${BIBTEX}" -quiet zip/$f
		"${PDFLATEX}" -quiet -output-directory=zip  zip/$f
		"${PDFLATEX}" -quiet -output-directory=zip  zip/$f
	fi

	if [[ $f == sample* ]]
	then
		mv zip/$f.tex zip/$f.pdf zip/samples/
	else
		rm zip/$f.tex
	fi
done

rm -f zip/*.aux zip/*.bbl zip/*.blg zip/*.log zip/*.out zip/*.synctex.gz

# pack into a zip and release
echo "##### zip #####"

mkdir -p releases

rm -f releases/template-${sigirforumversion}.zip
7z a -bb0 releases/template-${sigirforumversion}.zip ./zip/*
7z l releases/template-${sigirforumversion}.zip
