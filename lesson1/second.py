import sys


# for line in sys.stdin:
#     vals = [int(x) for x in line.split(' ')]
#     print(sum(vals) / len(vals))

vals = [int(x) for x in sys.stdin.read().split(' ')]
print(sum(vals) / len(vals))