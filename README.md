# Cross-correlation algorithm


## Running

To build and run cross-correlation on example data use:

```bash
./run.sh file
```

This should run cross-correlation algorithm on data in provided file,
output results to _result.csv_ and open gnu plots for both input and output.
Test data can be found in _test.dat_ file.


## Aggregator

Counts term occurrences for each key.
Puts results to _aggregated.dat_ file.

```bash
./aggregate.sh file word
```


## Reducer

Sums values for each key.
Puts results to _reduced.dat_ file.

```bash
./reduce.sh file
```


## Merger

Merges two data sets.
If key is missing in one of the data sets then default value is used.
Puts results to _merged.dat_ file.

```bash
./merge.sh data1 data2 defaultValue1 defaultValue2
```
