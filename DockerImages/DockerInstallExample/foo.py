import os

cwd = os.getcwd()

target = open(cwd + "/out.txt", 'w')

target.write("Hello world!")

target.close()

