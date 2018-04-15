#!/usr/bin/env bash

# Run

data=oil_gold.csv
result=result.csv

../../../cross-correlation $data $result 0


#Plot

gnuplot -e "filename='${data}'" -pc ./oil-plot.gnu
gnuplot -e "filename='${data}'" -pc ./gold-plot.gnu
gnuplot -e "filename='${result}'" -pc cross-correlation-plot.gnu
