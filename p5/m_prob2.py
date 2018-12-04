#!/usr/bin/env python

import sys

def main(argv):
    for i, line in enumerate(iter(sys.stdin.readline, '')):
        _, tail = line.strip().split(" : ")
        costs = tail.split(" ")
        for j, cost in enumerate(costs):
            if i == j:
                continue
            elif i == 0:
                print(f"start\t{i},{j} {cost}")
            elif j == 0:
                print(f"end\t{i},{j} {cost}")
            else:
                print(f"middle\t{i},{j} {cost}")

if __name__ == '__main__':
    main(sys.argv)
