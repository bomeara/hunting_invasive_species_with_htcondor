## RStan Dockerfile

This file contains a `dockerfile` to build a docker container with
RStan.
It also contains files necessary to test the RStan, both locally and
on a HTCondor pool.
Note that the Docker image will need to be shared across the nodes.

The specific files include:
- `Dockerfile`: the Dockerfile necessary to build a docker image.
- ``


Steps to use this example:

1. Build the Docker image using the Dockerfile with
`docker build --rm --force-rm -t rerickson/r-stan .` (Make sure to include the
   period at the end!)
2. Make sure we can load the docker files "by hand". This step is
optional, but can be helpful to build confidence in your code and
debug if it does not work for some reason.

   - Start the image: `docker run -it rerickson/r-stan /bin/bash`
   - start R: `R`
   - load RStan: `library(rstan)`.
3. Check to make sure the image works locally from the terminal with
   Docker (if need be, you might want to try running this code without
   Docker as a troubleshooting step.

	- Simulate data locally:
	- Fit the Stan model locally using Docker. Note that Docker lives
      in 0 based world and R lives in 1 based world and the R file
      accounts for this.
	  - First, fit the model to parameter set 1: `docker run -it -v
        /Users/rerickson/Documents/HTCondorFiles/condor-examples/RStanDocker:/opt/rerickson/
        -w /opt/rerickson/ rerickson/r-stan Rscript FitDataToModel.R
        0`
	  - Second, fit the model to parameters set 2: `docker run -it -v /Users/rerickson/Documents/HTCondorFiles/condor-examples/RStanDocker:/opt/rerickson/ -w /opt/rerickson/ rerickson/r-stan Rscript FitDataToModel.R 1`
	- Examine results (I used the Docker image in case R is not
      installed Locally): `rerickson$ docker run -it -v /Users/rerickson/Documents/HTCondorFiles/condor-examples/RStanDocker:/opt/rerickson/ -w /opt/rerickson/ rerickson/r-stan Rscript ExamineDataLocally.R`

4. Repeat previous step using HTCondor

   - Simulate data
   - Get Docker images over to machines in HTCondor Pool
   - condor submit
   - view results




