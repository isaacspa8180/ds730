#!/usr/bin/env python

import sys

def main(argv):
    costs = {}
    for i, line in enumerate(iter(sys.stdin.readline, '')):
        head, tail = line.strip().split("\t")
        arc, cost = tail.split(" ")
        arc = tuple(arc.split(","))
        print((int)cost)

if __name__ == '__main__':
    main(sys.argv)
