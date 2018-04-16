#!/usr/bin/env bash

# Run

data=low-gamma-2-and-8.csv
result=result.csv

../../../cross-correlation $data $result 0


#Plot

gnuplot -e "filename='${data}'" -pc ./brainwave1-plot.gnu
gnuplot -e "filename='${data}'" -pc ./brainwave2-plot.gnu
gnuplot -e "filename='${result}'" -pc cross-correlation-plot.gnu
