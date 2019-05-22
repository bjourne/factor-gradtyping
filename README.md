# Gradual typing in Factor

Supplementary code to my essay. Repeat my benchmarks like this:

1. Install Factor
2. Run Factor: `./factor -run=listener`
3. Save the test harness in the image using:
```
IN: scratchpad "/path/to/benchmark.factor" run-file
IN: scratchpad "/path/to/maybe-typed.factor" run-file
IN: scratchpad save
```
Replace `/path/to/` with the real path to these files. Exit Factor
using `CTRL-D`.

4. Run one of the benchmarks by issuing the shell command
```
$ ./factor -e="USE: benchmark 34 \"sieve\" run-bench"
```
The benchmark is either `sieve` or `spectral`. The typing config can
be selected by setting 34 to some other number.
