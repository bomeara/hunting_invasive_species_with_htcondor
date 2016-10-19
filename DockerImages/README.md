# Docker images 

HTCondor require Docker images to be on the local machines being
used. 
Several different methods exist for getting the images to the
machines. 
These include:

- _DockerHub_: The easiest way to do this is to use an image that has been loaded to
DockerHub, the default image location.
The downside is that downloading large images from DockerHub can slow
down your internet connection.
Additionally, you may not want to publish your images publicly.
- _Local repository_: The Docker page has directions for hosting your
  own local repository. We have not been able to successfully setup our
  own repository due to USGS security settings.
- _Copy images over manually_: We have been able to compress images in
  tarballs, copy them over manually, and then load them:
  1. Use `docker save image > out.tar` to pack the tar file: e.g.,
     `docker save rerickson/r-custom | gzip > testRimage.tar.gz`
  2. Copy the file to the Condor machines (e.g., `scp`).
  3. Unzip and load the file with Docker: `zcat testRimage.tar.gz | docker load`
