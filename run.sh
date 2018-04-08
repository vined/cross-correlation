#!/usr/bin/env bash

# Build

ghc -o cross-correlation cross-correlation.hs


# Run

data="test.csv"
if [ "$1" != "" ]; then
    data=$1
fi

result="result.csv"
if [ "$2" != "" ]; then
    result=$2
fi

n=0
if [ "$3" != "" ]; then
    n=$3
fi

./cross-correlation $data $result $n


#Plot

gnuplot -e "filename='${data}'" -pc signal1-plot.gnu
gnuplot -e "filename='${data}'" -pc signal2-plot.gnu
gnuplot -e "filename='${result}'" -pc cross-correlation-plot.gnu
