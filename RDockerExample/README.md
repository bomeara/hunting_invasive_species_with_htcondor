# R with Docker and HTCondor Example

This example demonstrates how to use R with Docker and HTCondor. We
were motivated to R user with Docker because we have some difficult to
build packages that we did not want to locally deploy to our HTCondor
Flock. Initially, I though our Python tutorial could easily be
converted. However, this proved to be wrong after I worked with Emily
on her project. This example documents our efforts.

# Files

There are 3 files in this example:

- `test.R` the R script that prints some text to the screen and saves
  a CSV files;
- `test.sh` the shell file that calls the R script; and
- `test.sub` the HTCondor submit file that submits the job to
  HTCondor.

Initially, we tried only using the HTCondor submit file and the R
script file. However, we were unable to get this to work and we needed
a shell file to call the R script.

# How to use

To use this example, you will need HTCondor and Docker installed on
machines in your node. You will also need the `r-base` Docker image on
all of your HTCondor nodes. Other tutorials in this repository walk
through how to set these things up (although the ultimately point back
to the original documentation). After `git clone`ing this directory,
simply run:

    condor_submit test.sub

and everything should work.


# Acknowledgments

Emily Weiser helped me (RAE) work through this code.



