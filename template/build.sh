#! /bin/bash

mkdir zip
mkdir zip/samples

cp -f sample.tex zip/samples/
cp -f sample.pdf zip/samples/
cp -f sample_event.tex zip/samples/
cp -f sample_event.pdf zip/samples/
cp -f sample_phd.tex zip/samples/
cp -f sample_phd.pdf zip/samples/

cp -f checklist.pdf zip/
cp -f instructions.pdf zip/
cp -f sigirforum.bib zip/
cp -f sigirforum.cls zip/

echo 'Version? '
read version
7z a releases/template-${version}.zip ./zip/*
