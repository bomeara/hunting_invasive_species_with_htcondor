from __future__ import print_function
import sys, os, subprocess

## This script installs a docker contain on all the linux machines in a pool.

## First, we need to get the names of linux machines on pool and save them to a text file.

linuxMachineFile = "LinuxMachines.txt"
outfile = open(linuxMachineFile, "w")
subprocess.call(['condor_status', '-autoformat', 'Name', '-constraint', 'OpSys==\"LINUX\"'], stdout = outfile)



## Then we remove the slots from the names and also remove duplicate machine names
indat = open(linuxMachineFile, 'r').readlines()
machines = set([machine.strip('\n').split('@')[1] for machine in indat])

## Machines are hardcoded in as a temporary fix until our flock is back up and running
# machines = ['igsarfebaskoi03', 'igsarfebaskoi00']

## Next, we loop over all machines, create a submit file, and submit the submit file
i=0
for machine in machines:
    i+=1  
    # Create suumit file by adapting the existing "base" submit file
    with open('deploy_run{0}.sub'.format(i),'w') as ofp:
        inbase = open('base.sub', 'r').readlines()
        for line in inbase:
            if 'special_machine_code' in line:
                line = line.replace('special_machine_code','"{0}.er.usgs.gov"'.format(machine))
            ofp.write(line)
    # Print current machine to see loop status
    print(machine)
    print('condor_submit deploy_run{0}.sub'.format(i))
    # Submit submit file to Condor:
    # os.system('condor_submit deploy_run{0}.sub'.format(i))

print("Done submitting jobs. Monitor their status with 'condor_q'.")
