import re
import sys
from collections import defaultdict


# def main(argv):
#     pat = re.compile(r'(\S+)')
#     line = sys.stdin.readline()
#     while line:
#         for word in re.findall(pat, line):
#             vow = ''.join(sorted(filter(lambda x: x in 'aeiou', word.lower())))
#             print('{0}\t1'.format(vow))
#         line = sys.stdin.readline()


def main(argv):
    pat = re.compile(r'(\S+)')
    for line in iter(sys.stdin.readline, ''):
        for word in re.findall(pat, line):
            vow = ''.join(sorted(filter(lambda x: x in 'aeiou', word.lower())))
            print('{0}\t1'.format(vow))


if __name__ == '__main__':
    main(sys.argv)