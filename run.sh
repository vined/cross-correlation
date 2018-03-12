#!/usr/bin/env bash

# Build

ghc -o cross-correlation cross-correlation.hs


# Run

data="test.dat"
if [ "$1" != "" ]; then
    data=$1
fi

./cross-correlation $data


#Plot

gnuplot -e "filename='${data}'" -pc signals-plot.gnu
gnuplot -pc cross-correlation-plot.gnu
