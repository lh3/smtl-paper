.SUFFIXES: .gp .tex .eps .pdf .eps.gz

.eps.pdf:
		epstopdf --outfile $@ $<

.eps.gz.pdf:
		gzip -dc $< | epstopdf --filter > $@

all:samtools.pdf

samtools.pdf:samtools.tex samtools.bib
		pdflatex samtools; bibtex samtools; pdflatex samtools; pdflatex samtools;

clean:
		rm -fr *.toc *.aux *.bbl *.blg *.idx *.log *.out *~ samtools.pdf samtools.ps samtools.dvi

distclean:clean
		rm -f samtools.pdf
