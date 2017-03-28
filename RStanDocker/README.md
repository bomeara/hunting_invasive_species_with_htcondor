## RStan Dockerfile

This file contains a `dockerfile` to build a docker container with
RStan.
It also contains files necessary to test the RStan, both locally and
on a HTCondor pool.
Note that the Docker image will need to be shared across the nodes.

The example is generating simulating a linear regression and then
recovering the parameters using RStan. 2 different models are
generated, but the data can be fit multiple times using the query
option in the submit file. This option was selected to allow for
debugging and running large HTCondor jobs.

The file paths will need to be updated in these examples files.
Additionally, the output folders `output` and `dataOut` will need to
be locally created. 

Overall, this tutorial assumes a working understanding of Docker,
HTCondor, R, and RStan. However, it is a worked example of how to use
the four programs together.


The specific files include:
- `Dockerfile`: the Dockerfile necessary to build a docker image.
- `ExamineDataLocally.R`: An R file for examining the outputs.
- `example.sh`: a shell file needed to run the R script.
- `FitDataToModel.R`: The R code that runs RStan.
- `model.stan`: The Stan model that gets run.
- `RStanDemo.sub`: The HTCondor submit file.
- `SimulateData.R`: The R file that generates the simulated data.


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
   - Get Docker images over to machines in HTCondor Pool (see
     [this tutorial](https://my.usgs.gov/bitbucket/projects/CDI/repos/hunting_invasive_species_with_htcondor/browse/DockerImages/README.md#21)
     for help).
   - condor submit
   - view results





