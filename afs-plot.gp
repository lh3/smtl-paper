set style line 1 pt 2 lt 1 lw 2;
set style line 2 pt 4 lt 2 lw 2;
set style line 3 pt 8 lt 5 lw 2;

set t po eps mono "Helvetica, 24"
set out "afs-cmp.eps"

set size 1, 0.9
set pointsize 1.5
set ytics 0.05
set xlab "# derived alleles conditional on NA18507 hets"
set ylab 'Frequency'

plot "cg.9.afs" u 1:2 t "Complete Genomics" w lp ls 1, \
	"NA18507-A.s9.afs" u 1:2 t "1000G pilot (EM-AFS)" w lp ls 2, \
	"NA18507-A.s9.cntafs" u 1:2 t "1000G pilot (site-AFS)" w lp ls 3
