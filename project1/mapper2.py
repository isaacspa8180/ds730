import re
import sys
from collections import defaultdict


# def main(argv):
#     pat = re.compile(r'(\S+)')
#     line = sys.stdin.readline()
#     d = defaultdict(int)
#     while line:
#         for word in re.findall(pat, line):
#             vow = ''.join(sorted(filter(lambda x: x in 'aeiou', word.lower())))
#             d[vow] += 1
#         line = sys.stdin.readline()
#     for k in sorted(d):
#         print('{0}\t{1}'.format(k, d[k]))


def main(argv):
    pat = re.compile(r'(\S+)')
    line = sys.stdin.readline()
    while line:
        for word in re.findall(pat, line):
            vow = ''.join(sorted(filter(lambda x: x in 'aeiou', word.lower())))
            print('{0}\t1'.format(vow))
        line = sys.stdin.readline()


if __name__ == '__main__':
    main(sys.argv)