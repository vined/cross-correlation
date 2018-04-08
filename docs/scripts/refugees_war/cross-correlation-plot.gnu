unset log
unset label
set terminal png size 300,300 enhanced font "Helvetica,14"
set output 'result.png'
set encoding utf8
set datafile separator ","

set tmargin 0.5
set lmargin 3.5
set rmargin 1.5
set bmargin 1.5

set xtics 20 offset 0, graph 0.05
set grid xtics lt 0 lw 1 lc rgb "#bbbbbb"

set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"
set ytics 0.25 offset 1
#set yrange [0:1]

stats filename using 2 nooutput name 'Y_'
stats filename using 1 every ::Y_index_max::Y_index_max nooutput
X_max = STATS_max
set label 2 sprintf("d=%d r=%.2f", X_max, Y_max) center at first X_max,Y_max point pt 7 ps 1 offset 1.5,0.5


plot filename notitle with lines lw 1 lt rgb "#000000"
