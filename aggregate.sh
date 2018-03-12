#!/usr/bin/env bash

# Build

ghc -o aggregator aggregator.hs


# Run
./aggregator $1 $2
