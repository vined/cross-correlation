unset log
unset label
set terminal png size 300,300 enhanced font "Helvetica,14"
set output 'war.png'
set encoding utf8
set datafile separator ","

set tmargin 0.5
set lmargin 3.5
set rmargin 1.5
set bmargin 1.5
set timefmt '%Y%m'

set format x '%Y'
set xdata time
set xtics 128000000 offset 0, graph 0.05
set grid xtics lt 0 lw 1 lc rgb "#bbbbbb"
#set xrange ["200302":"2001702"]

set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"
set ytics 100 offset 1

plot filename using 1:3 notitle with lines lw 1 lt rgb "#000000"
