#! /bin/bash
# file name: foo.sh

docker run -it -v /home/rerickson/DockerInstallExample:/home/rerickson -w /home/rerickson python python foo.py
