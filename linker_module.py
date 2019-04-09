import os


def linker(direc, name):
    os.system("gcc " + direc + " -o " + name)
    os.remove(direc)
