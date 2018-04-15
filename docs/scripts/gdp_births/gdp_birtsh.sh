#!/usr/bin/env bash

# Run

data=gdp_births.csv
result=result.csv

../../../cross-correlation $data $result 0


#Plot

gnuplot -e "filename='${data}'" -pc ./gdp-plot.gnu
gnuplot -e "filename='${data}'" -pc ./births-plot.gnu
gnuplot -e "filename='${result}'" -pc cross-correlation-plot.gnu
