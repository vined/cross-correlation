#!/usr/bin/env bash

# Run

data=refugees_war.csv
result=result.csv

../../../cross-correlation $data $result 40


#Plot

gnuplot -e "filename='${data}'" -pc ./refugees-plot.gnu
gnuplot -e "filename='${data}'" -pc ./war-plot.gnu
gnuplot -e "filename='${result}'" -pc cross-correlation-plot.gnu
