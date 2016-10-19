# HTCondor set up Procedures for UMESC

Here at the UMESC we are using Red Hat enterprise 7.2 Linux to run our HTCondor pool. It would be
good to have someone accustomed to working with Linux to setup and Administer HTCondor on a
Linux pool.

## Linux considerations
Make sure the “hosts” file on all pool machines reflect what is in the pool. Open port 9618 for 
Condor traffic.

## Installation
Decide on version of Condor you want to use. We have installed the stable version 8.4.8 on our
production pool as of the writing of this article. When making references to the HTCondor manual we
will be referring to 8.4.8. The manual can be downloaded here:
http://research.cs.wisc.edu/htcondor/manual/

You will typically want to install the latest stable
release. This site is helpful when installing Condor for the first time on Linux:
https://research.cs.wisc.edu/htcondor/yum/

When using the example commands in this link you will want to change the command to associate with 
the version of Linux you are using. i.e. change rhel6 to rhel7.

Once you have installed HTCondor you will want to look at the below roles of each type of machine to
understand what types of machines (hardware) is needed to do what. You will need to choose what
machine you want to be your CM (Central Manager), Execute, and Submit machines.

## Machine Roles
There are 3 standard role types for machines in a Condor pool. One machine can be setup to run all
three roles or each role can be on different machines. The following is an overview of what each 
role is.

__Central Manager (CM):__ There can be only one CM for the pool. This machine is the collector of
information, and the negotiator between resources and resource requests. This machine plays a very
important part in the HTCondor pool and should be reliable. This machine does not need to be as
powerful as your submit machine.

__Execute:__ Any machine in the pool, including the CM, can be configured to execute jobs or not. In
general the more resources a machine has in terms of swap space, memory, number of CPUs, the
larger variety of resource requests it can serve.

__Submit:__ Any machine in the pool, including the CM, can be configured as to whether or not it should
allow HTCondor jobs to be submitted. The resource requirements for a submit machine are actually
much greater than the resource requirements for an execute machine.

## HTCondor Daemons and Config files
Each role above will need certain daemons (services) running to be able to perform that role. The
following is a list of daemons we have running on our pool at the UMESC. These daemons are only
started if defined in a config file under ```/etc/condor/config.d```. We created new config files for
configurations of like manner. This way you can copy config files to other machines with like roles, so
you don’t have to recreate the config files on every machine. These can be created and removed as
needed. More or less can be used to manage a functional pool. Based on recommendations from the
HTCondor team in Madison WI, we have started naming our config files with numbers as the first 2
characters of the file name. i.e. ```00Daemon_Resources```

__00Daemon_Resources__ This is the config file that defines what role a machine will take on.
Daemon list options on each machine within the pool.
1. condor\_master – Runs on all machines in the pool and is responsible for keeping all
other daemons running. 1
2. condor\_collector – Runs on the CM, collects all information about the status of the
pool. 2
3. condor\_negotiator - is responsible for all the match making within the HTCondor
system. 3
4. condor\_startd - This daemon represents a given resource to the HTCondor pool, as a
machine capable of running jobs. 4
5. condor\_schedd - This daemon represents resource requests to the HTCondor pool.
Any machine that is to be a submit machine needs to have a condor_schedd running.
```DAEMON_LIST = MASTER, STARTD```...or any combination from the list above. 5

__01_IP__ (defines the CM and network interface being used if more than one)
Most of our current machines have 2 or more NICs. There are different setting if you have one
NIC or if you have more than one. Section 3.3.5 in the Condor manual. As of this writing we
have ```CONDOR_HOST``` and ```NETWORK_INTERFACE``` defined in this config file. ```CONDOR_HOST``` defines
who the CM is and ```NETWORK_INTERFACE``` defines what local IP to use for Condor
communication.
Our config file has the 2 following lines.
```CONDOR_HOST = xxx.xxx.xxx.xxx
NETWORK_INTERFACE = xxx.xxx.xxx.xxx
```

__02Access__ (Defines who is allowed to do what on this machine) Section 3.6.7 in the Condor
manual. We have ```ALLOW_READ```, ```ALLOW_WRITE``` and ```HOSTALLOW_WRITE``` defined in
this config file.

__03Flocking__ (Who has rights, outside of our local domain, to use resources in our pool?) Defined by 
IP addresses. The firewall has to be open to allow certain IPs from other centers. The following 
is what we are using to define how flocking works at the UMESC.
```FLOCK_TO = xxx.xxx.xxx.xxx (IP address/s)
FLOCK_FROM = $(FLOCK_T0)
USE_SHARED_PORT = TRUE
Site = "LACROSSEWI-B"
Port_consolidated = TRUE
STARTD_ATTRS = STARTD_ATTRS, Site, Port_consolidated
```

__04Docker__ (Does this machine have a usable Docker installation?)
If Docker is installed correctly all that is needed in this config file is ```Hasdocker = true```
Understanding Docker (Overview) Link
https://docs.docker.com/engine/understanding-docker/
Docker-Engine
Easy step by step instructions for installing the Docker Engine.
https://docs.docker.com/engine/installation/linux/rhel/
Our Central Manager’s config files look like this.

```00condor_config_Daemon_Resources
# Resources used
SLOT_TYPE_1 = cpus=1
NUM_SLOTS_TYPE_1 = 40
SLOT_TYPE_1_PARTITIONABLE = True
DAEMON_LIST = COLLECTOR, MASTER, NEGOTIATOR, SCHEDD, STARTD
```

Our CM has 48 core available but we are restricting Condor use to 40 so there are resources (8 core) for the OS
and Condor back-end processes.

```01condor_config_IP
CONDOR_HOST = 159.xxx.xxx.xxx
NETWORK_INTERFACE = 159.xxx.xxx.xxx
```

02condor\_config_Access We are also using this config file:
```ALLOW_READ = xxx.xxx.xxx.xxx, *@er.usgs.gov, *@gs.doi.net
ALLOW_WRITE = xxx.xxx.xxx.xxx, xxx.xxx.xxx.xxx
HOSTALLOW_WRITE = xxx.xxx.xxx.xxx, xxx.xxx.xxx.xxx, *@er.usgs.gov, *@gs.doi.net
TRUST_UID_DOMAIN = True
STARTER_ALLOW_RUNAS_OWNER = True
BIND_ALL_INTERFACES = True
```

##Commands useful for testing and monitoring your HTCondor Pool
```condor_status``` (you can add, -wide, -total) ie. condor_status –wide –total
One or both in any combination
```condor_status -const HasDocker
condor_q
condor_q –analyse (job ID #)
condor_q –claimed
condor_q –submitter “*submitter username*”
```

Adding ```-help``` to the end of any of the above will give you an idea of how powerful the command 
can be. To restart the condor service after configuration changes run ```service condor stop``` then 
```service condor start```. ```Service condor status``` will show what services/daemons are running.
