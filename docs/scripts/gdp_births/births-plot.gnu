unset log
unset label
set terminal png size 300,300 enhanced font "Helvetica,14"
set output 'births.png'
set encoding utf8
set datafile separator ","

set tmargin 0.5
set lmargin 4.0
set rmargin 2.0
set bmargin 1.5

set xtics 3 offset 0, graph 0.03
set grid xtics lt 0 lw 1 lc rgb "#bbbbbb"
set xrange [2000:2013]

set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"
set ytics offset 1

plot filename using 1:($3/1000000.) notitle with lines lw 1 lt rgb "#000000"
