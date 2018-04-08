#!/usr/bin/env bash

# Build

ghc -o reducer reducer.hs


# Run
./reducer $1
