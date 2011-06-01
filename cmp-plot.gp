set style line 1 pt 2 lt 1 lw 2;
set style line 2 pt 4 lt 2 lw 2;
set style line 3 pt 8 lt 5 lw 2;

set t po eps mono enhance "Helvetica, 24"
set out "ac-CEUp.eps"

set log x
set size 1, 0.9
set pointsize 1.5

set key bot right
set ytics 0.1
set xlab "# non-reference alleles"
set ylab "Accumulative Spearman's r"
plot "<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f5,6|luajit r-plot.lua" u 1:3 t 'Beagle imputation' w lp ls 1, \
	"<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f5,7|luajit r-plot.lua" u 1:3 t 'ML estimate' w lp ls 2

set out "ac-EUR1.eps"
plot "<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0'|cut -f5,6|luajit r-plot.lua" u 1:3 t 'Beagle imputation' w lp ls 1, \
	"<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0'|cut -f5,7|luajit r-plot.lua" u 1:3 t 'ML estimate' w lp ls 2

set ytics 0.05
set out "ld-CEUp.eps"
set xlab "maximum r-square to nearby SNPs"
plot "<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f3,5,6|luajit r-plot.ld.lua 40" u 1:2 t 'Beagle imputation' w lp ls 1, \
	"<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f3,5,7|luajit r-plot.ld.lua 40" u 1:2 t 'ML estimate' w lp ls 2

set out "ld-EUR1.eps"
plot "<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0'|cut -f3,5,6|luajit r-plot.ld.lua 40" u 1:2 t 'Beagle imputation' w lp ls 1, \
	"<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0'|cut -f3,5,7|luajit r-plot.ld.lua 40" u 1:2 t 'ML estimate' w lp ls 2

set out "at-CEU.eps"
unset log y
unset log x
set size 0.7, 0.9
set xtics 1
set ytics 1
set pointsize 1.5
set key top left
f(x) = x
set xlab "Expected -log10(P-value)"
set ylab "Observed -log10(P-value)"
plot "<cat bgl.qq|awk 'rand()<0.0001/(10**(-$1))'" t 'Imputation' ls 1, "<cat bcf.qq|awk 'rand()<0.0001/(10**(-$1))'" t 'LRT' ls 2, f(x) t '' 2
