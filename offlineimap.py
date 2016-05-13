#! /usr/bin/env python2

from subprocess import check_output

def get_pass():
    return check_output("give_pass mail user", shell=True).strip("\n")
