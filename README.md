# HTCondor examples

This file contains several examples for using
[HTCondor](https://research.cs.wisc.edu/htcondor/) to scale scientific
processing with cluster computing.
These examples assume that one has a functioning HTCondor pool with
the appropriate software installed and configured (e.g., Docker for
the Docker examples; R or Python for R or Python examples).
Installing these programs is beyond the scope of these examples.

The examples include:

  - _QuickStart_, which is HTCondor's quick start example for Windows.
  - _QuickStartLinux_, which is HTCondor's quick start example for Linux.
  - _LearnR_, which is a very simple R example. It assumes R is installed on
    the local Widnows machine.
  - _R-Rtools-sandbox_, which demonstrates how to sandbox R and Rtools
    on Windows.
  - _R-snow_, which demonstrates how to use HTCondor with R and the
    snow parallel package on Linux.
  - _RStanExample_, which demonstrates how to use RStan on HTCondor on
    Windows where R is locally installed.
  - _DockerExamples_, which demonstrates how to use Docker (these
    examples build up knowledge necessary to use Docker with
    HTCondor). These are Linux based examples.
  - _HTCondorDockerSimple_, which demonstrates how to run a simple
    Python job using Docker. This example requires a Linux pool with
    Docker installed.
  - _R_, which is an example developed by Luke Winslow. It uses R on a
    Linux pool (with R installed) to analyze lake data.
  - _R-Rtools-sandbox_, which is an example of using a sandboxed version of R
    and RTools on a Windows Machine.
  - _R-snow_, which is an example of using Condor to deploy jobs that
    run on parallel on the local machines.
  - _RStanExamples_, which is an example of using R Stan on Windows
    with HTCondor. It is a sandbox example. 
  - _DockerImages_, which discusses how to get images to nodes on the
    Condor flock.

The "sandbox" examples do not require R to be installed on the
machines in the HTCondor flock. Conversely, the "sandboxed" examples
are stand alone and do not require the local installation of R.

Some examples are written for Windows.
Others are written for Linux.
The biggest difference is that the Windows examples have
[batch](https://en.wikipedia.org/wiki/Batch_file) files that end with
`.bat`  whereas Linux
examples have
[shell scripts](https://en.wikipedia.org/wiki/Shell_script) that end
with `.sh`.
Additionally, the Docker examples will not run on a Windows Flock.

These examples may eventually be expanded to include more of a
"tutorial" format rather than only examples.

# Suggested course of self study

These examples assume fluency in the subject area programming languages
(e.g., Python, R), operating scripting languages (e.g., writing
Windows batch files, or Linux shell files), and Docker (for the Docker
examples).

Here is a suggested course of study:

0. Know your subject area programming language. This step can take
   years of study to be good at.
1. Know how to use your programming language from scripting files.
2. Learn the basics of running Docker (if you're going to use it).
3. Start with the
   [HTCondor Quick Start](https://research.cs.wisc.edu/htcondor/manual/quickstart.html)
   tutorial. Adapt this tutorial to your system and needs (e.g.,
   change the submit file to be Linux or Windows only). Also, explore
   how Condor works (e.g., change the sleep time or number of items
   in the queue). I (RAE) use the Quick Start Example to debug my
   HTCondor pool and code when I get stuck.
4. Start with simple examples in your subject area. E.g., printing
   "Hello World!" with Python or generating a random `data.frame` with
   R. Depending upon your Condor pool's software, you may need to do
   this step with Docker.
5. Learn how to use Docker Universe or another method to Sandbox your code.

# Tips for adapting code to run with HTCondor

Here is an outline for adapting your code to run with HTCondor:

0. Make sure HTCondor is the a workable solution to your
   problem. (Should you be using High-performance computing? Could you
   improve your code and run the tasks locally on your desktop?)
1. Understand your problem/code well enough to break it up into small
   parts that can run on HTCondor. Test run this code on small parts
   of your data.
2. Generate code to split your data/problem into small parts (if this
   step requires a lot of work, you may want to use HTCondor for this
   step as well!).
3. Run make sure a test case for HTCondor works. Start small. Rather
   than run 10,000 jobs, start small. Run 1 job then 10 etc.
4. Write code to tie together your results.

# Background, contact information, and acknowledgments

These examples were compiled by Richard Erickson (rerickson@usgs.gov).
Please contact him with Feedback on the example or feel free to "push"
other examples to him and he will include them on this repository or
include a link to your repository.

He gathered and developed them while teaching himself Condor.
Luke Winslow developed some of the example that are standalone.
I only had to add some comments and documentation to Luke's examples.
Mike Fienen, Joel Putman, the HTCondor Official documentation, and other
provided some of the basic examples.

Last, the author is thankful for the USGS CDI for funding that allowed
him the opportunity to write-up this documentation.


