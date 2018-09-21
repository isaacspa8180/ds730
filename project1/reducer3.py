import sys 
from collections import defaultdict


def main(argv):
    d = defaultdict(list)
    for line in iter(sys.stdin.readline, ''):
        line = line.strip()
        k, vs = line.split('\t', 1)
        vs = vs.split(' ')
        vs = {int(v) for v in vs}
        d[k].append(vs)
    print(d)

if __name__ == '__main__':
    main(sys.argv)