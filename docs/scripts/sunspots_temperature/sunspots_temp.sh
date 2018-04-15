#!/usr/bin/env bash

# Run

data=sunspots_temp_gcag.csv
result=result.csv

#../../../cross-correlation $data $result 0


#Plot

gnuplot -e "filename='${data}'" -pc ./sunspots-plot.gnu
gnuplot -e "filename='${data}'" -pc ./temp-plot.gnu
gnuplot -e "filename='${result}'" -pc cross-correlation-plot.gnu
