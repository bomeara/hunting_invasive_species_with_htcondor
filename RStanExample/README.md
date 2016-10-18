## RStan Example

This is an example of using RStan on Windows. The objective of this
example is to simulate data and then test the ability of Stan to
Recover the data. This steps for doing this are:

1. Simulate model parameter values using the `generateParameters.R`
   file.
2. Submit the job to HTCondor using `rstanExamples.sub` file.
   1. This calls the a Window's batch file, `rstanExample.bat`
   2. The batch file run the `htcondorFile.R`
3. Merge and plot the results using the `mergeDataAndPlot.R` file.

This example requires `R`, `RStan`, and `RTools` to be locally installed on
all Windows machines in the Condor Pool. A better method to implement
this example in actual production would be to sandbox the example. 
