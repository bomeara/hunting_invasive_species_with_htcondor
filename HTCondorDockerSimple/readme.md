# Simple Docker example 

This example demonstrates how to use Docker with Python and HTCondor. 
Note that Condor requires Docker to be installed on all machines in
the pool.

The submit file goes out to the pool and downloads the Python
container to the local machines. 
This requires that the local machines have internet access.

You will also want to make sure that your flock has Docker installed
and configured correctly:

    condor_config_val docker

The HTCondor [Docker Universe](http://research.cs.wisc.edu/htcondor/manual/latest/2_12Docker_Universe.html) page has more details about this.
