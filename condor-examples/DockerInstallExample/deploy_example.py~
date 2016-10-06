from __future__ import print_function
import sys, os

## Need to get list linux machines on pool, askoi is the linux pool at UMESC. 

os.system('condor_status -wide | grep askoi > koi.txt')

print("done")
exit()
## Loop through machines to install docker package
 
i=0
indat = open('koi.txt', 'r').readlines()

for line in indat:
    i+=1
    cmachine = line.strip().split('@')[1]
    cmachine = cmachine.split('.')[0]
    with open('deploy_run{0}.sub'.format(i),'w') as ofp:
        inbase = open('base.sub', 'r').readlines()
        for line in inbase:
            if 'special_machine_code' in line:
                line = line.replace('special_machine_code','"{0}.er.usgs.gov"'.format(cmachine))
            ofp.write(line)
    print('condor_submit deploy_run{0}.sub'.format(i))
    os.system('condor_submit deploy_run{0}.sub'.format(i))
