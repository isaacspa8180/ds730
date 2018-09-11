import sys


vals = [int(x) for x in sys.stdin.read().split(' ')]
print(sum(vals) / len(vals))