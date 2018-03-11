unset log
unset label
set encoding utf8
set title "Signals"
#set timefmt '%Y-%m-%d'
#set xdata time
#set xrange ['2018-03-12':'2018-04-10']
plot filename using 1:2 title 'Signal 1' with lines, filename using 1:3 title 'Signal 2' with lines
