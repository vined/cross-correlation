#!/usr/bin/env bash

# Build

ghc -o merger merger.hs


# Run
./merger $1 $2 $3 $4 $5
