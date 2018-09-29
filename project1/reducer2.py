#!/usr/bin/python

import sys
from collections import defaultdict


def main(argv):
    d = defaultdict(int)
    for line in sys.stdin:
        # line = line.strip()
        vow, cnt = line.split('\t', 1)
        d[vow] += int(cnt)
    for k in sorted(d):
        print('{0}:{1}'.format(k, d[k]))


if __name__ == '__main__':
    main(sys.argv)
