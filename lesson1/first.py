import sys
# from functools import reduce


def factorial(val):
    if val < 0:
        return -1
    elif val == 0 or val == 1:
        return 1
    elif val > 1:
        i = 1
        acc = 1
        while i <= val:
            acc *= i
            i += 1
        return acc

if __name__ == '__main__':
    while True:
        line = input('Please enter a positive integer:\n')
        val = int(line)
        if val < 0:
            continue
        elif val >= 1:
            print(factorial(val))
            break