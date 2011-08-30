set style line 1 pt 2 lt 1 lw 2;
set style line 2 pt 4 lt 2 lw 2;
set style line 3 pt 8 lt 5 lw 2;

set t po eps mono enhance "Helvetica, 24"
set out "ac-CEUp.eps"

set log x
set size 1, 0.9
set pointsize 1.5

#set yran [0:*]
#set key bot left
#set ytics 0.2
#set xlab "# non-reference alleles computed from Omni genotypes"
#plot "<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f5,6|luajit rms-ac.lua 15" t 'Beagle imputation' w lp ls 1, \
#	"<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f5,7|luajit rms-ac.lua 15" t 'ML estimate' w lp ls 2

#set out "ac-EUR1.eps"
#plot "<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0'|cut -f5,6|luajit rms-ac.lua 15|awk 'NR>1'" t 'Beagle imputation' w lp ls 1, \
#	"<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0'|cut -f5,7|luajit rms-ac.lua 15|awk 'NR>1'" t 'ML estimate' w lp ls 2

unset log x
set yran [*:*]
set ytics 1
set key top right
set out "ld-CEUp.eps"
set xlab "maximum imputed r-square to nearby SNPs"
set ylab "Root-mean-square deviation"
plot "<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f3,5,6|luajit rms-ld.lua" t 'Beagle imputation' w lp ls 1, \
	"<bzip2 -dc pilot-cmp.txt.bz2|awk '$4==98&&$5>0'|cut -f3,5,7|luajit rms-ld.lua" t 'ML estimate' w lp ls 2

set yran [*:*]
set out "ld-EUR1.eps"
plot "<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0{print $3,$5,$6}'|luajit rms-ld.lua" t 'Beagle imputation' w lp ls 1, \
	"<bzip2 -dc EUR.tab.bz2|awk '$4==670&&$5>0{if($7==0)$7=1;print $3,$5,$7}'|luajit rms-ld.lua" t 'ML estimate' w lp ls 2

set out "at-CEU.eps"
set size 1.25, 0.9
set multiplot
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
set origin 0.0, 0.0
plot "<gzip -dc impute.qq.gz|awk 'rand()<0.001/(10**(-$1))'" t 'Imputation' ls 1, "<gzip -dc LRT.qq.gz|awk 'rand()<0.001/(10**(-$1))'" t '1-degree LRT' ls 2, f(x) t '' 2
set origin 0.65, 0.0
set noytics
set yran [0:7]
set size 0.6, 0.9
set noytics
set noylab
plot "<gzip -dc LRT2.qq.gz|awk 'rand()<0.001/(10**(-$1))'" t '2-degree LRT' ls 6, f(x) t '' 2
