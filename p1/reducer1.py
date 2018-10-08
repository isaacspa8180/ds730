#!/usr/bin/python

import sys
from collections import defaultdict


def main(argv):
    d = defaultdict(float)
    for line in sys.stdin:
        line = line.strip()
        key, value = line.split('\t', 1)
        month, country = key.split(',', 1)
        cust, spent = value.split(',', 1)
        spent = float(spent)
        d[(month, country, cust)] += spent


    d2 = defaultdict(list)
    for (month, country, cust), (spent) in d.items():
        d2[(month, country)].append((cust, round(spent, 2)))


    d3 = defaultdict(list)
    for k, v in d2.items():
        max_ = 0
        for cust, spent in v:
            if spent > max_:
                max_ = spent
        for cust, spent in v:
            if spent == max_:
                d3[k].append((cust, spent))


    for k in sorted(d3):
        for cust, spent in d3[k]:
            print('{0},{1}:{2}'.format(k[0], k[1], cust))


if __name__ == '__main__':
    main(sys.argv)
