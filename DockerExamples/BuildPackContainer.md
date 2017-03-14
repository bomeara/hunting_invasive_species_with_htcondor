# Building Images

Building images allows up to create your own image that has the
packages you need to complete your job. 

The [Docker Image](https://docs.docker.com/engine/tutorials/dockerimages/)
is where I got most of this information I adapted for this example. 

This file includes example of building images that are used by Docker.

## Useful commands before starting

Here are useful commands that I will review before going through the
tutorial:

    docker images 
	
shows what images are currently locally installed. The images can also
be removed: 

	docker rmi -f hello-world
	
The force flag `-f` is necessary because this image is still running
in the background. To stop all currently running docker images:

    docker stop $(docker ps -a -q)

To remove all images: 

    docker rm $(docker ps -a -q)

I found these [here](https://coderwall.com/p/ewk0mq/stop-remove-all-docker-containers).

## Creating new images

There are two methods for creating images. Update existing images
through the terminal _or_ use a `Dockerfile` to create an image.

## Updating an existing image through the terminal

One can create an image by updating an existing package in the
terminal and then committing the updates.
This methods is easier, but not preferred because it does not
reproducible. 

As an example, perhaps I want to install an R package. Here the steps
to commit to an existing Dockerfile:

 - Run the Docker Image interactively

        docker run -t -i r-base /bin/bash
	
 - launch R, install the package, and quit R:
  
         R
	     install.packages("MARSS", repos='http://cran.us.r-project.org')
	     q()
	 
 - Exit the Docker image (with `exit`)
 - Commit the image. Note that the container ID number (e.g.,
   `674cff43dbfd`) needs to be changed by the user. 

	     docker commit -m "Added in MARSS" -a "Richard Erickson" \
         674cff43dbfd rerickson/r-base:marss
	
 - We may then run the image:
  
        docker run -t -i rerickson/r-base:marss
	 
### Build a docker images from a Dockerfile

We may also build an image from a Dockerfile. This methods is
 preferred because it is reproducible. 
 I initially tried to Jessie
 Frazelle's Blog
 [post](https://blog.jessfraz.com/post/r-containers-for-data-science/),
 but got confused because I did not understand Docker well and had
 other local machine problems.
 However, I found a longer
 [tutorial on howtoforge.com](https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile/)
 that helped me understand Frazelle's example.
 I was able to adapt her example for the MARSS package (note that this
 package takes a _long_ time to build.
 
 **My problem ended up being that I did not have tabs correct on new
    lines. I would suggest using my Dockerfile rather than messing
    with copying and pasting.** 
 
 
 - We need a docker file with this information (this is placed in an
   Dockerfile, but my example doesn't yet work):

        # our R base image
        FROM r-base
    
        # install MARSS packages
        # first, we create a script files and then we run the script file.
        RUN echo 'install.packages(c("MARSS"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    		&& Rscript /tmp/packages.R
    
        # create an R user
        ENV HOME /home/user
        RUN useradd --create-home --home-dir $HOME user \
			&& chown -R user:user $HOME

        WORKDIR $HOME
        USER user
    
        # set the command
        CMD ["R"]

 - We then build the image (make sure to include the period at the
     end).
	 
	     docker build --rm --force-rm -t rerickson/r-custom .

 - This may be run and used:
   
        docker run -it -v /home/rerickson:/opt/rerickson -w /opt/rerickson rerickson/r-custom 
