.SUFFIXES: .gp .tex .eps .pdf .eps.gz

.eps.pdf:
		epstopdf --outfile $@ $<

.eps.gz.pdf:
		gzip -dc $< | epstopdf --filter > $@

all:samtools.pdf

samtools.pdf:samtools.tex samtools.bib afs-cmp.pdf ac-CEUp.pdf ld-CEUp.pdf ac-EUR1.pdf ld-EUR1.pdf at-CEU.pdf
		pdflatex samtools; bibtex samtools; pdflatex samtools; pdflatex samtools;

afs-cmp.eps:afs-plot.gp
		gnuplot afs-plot.gp

ac-CEUp.eps ld-CEUp.eps ac-EUR1.eps ld-EUR1.eps at-CEU.eps:cmp-plot.gp
		gnuplot cmp-plot.gp

clean:
		rm -fr *.toc *.aux *.bbl *.blg *.idx *.log *.out *~ samtools.pdf samtools.ps samtools.dvi

distclean:clean
		rm -f samtools.pdf
