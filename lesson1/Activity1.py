import sys
from functools import reduce


def f(val: int):
    i = 1
    acc = 1
    while i <= val:
        acc *= i
        i += 1
    return acc

def f2(val):
    return reduce((lambda x, y: x * y), [i for i in range(1, val + 1)])    

def f3(val):
    acc = 1
    while val > 1:
        acc *= val
        val -= 1
    return acc

if __name__ == '__main__':
    while True:
        val = input('Please enter a positive integer:\n')
        val = int(val)
        if val < 0:
            continue
        elif val > 1:
            print(f(val))
            break
            
