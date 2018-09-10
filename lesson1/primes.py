import itertools


def test_factorial(val):
    for i in range(2, val):
        if val % i == 0:
            return False
    return True

def format_answer(vals):
    if not vals:
        return 'No Primes'
    symbols = [',', ':', '!']
    nested = list(zip(sorted(vals), itertools.cycle(symbols)))
    flatlist = []
    for tup in nested:
        for item in tup:
            flatlist.append(str(item))
    my_str = ''.join(flatlist)            
    return my_str[:-1]

def main ():
    # TODO: Add validation for input.
    val1 = input('Please enter first number:\n')
    val2 = input('Please enter second number:\n')
    val1 = int(val1)
    val2 = int(val2)
    min_val = min(val1, val2)
    max_val = max(val1, val2)

    vals = [i for i in range(min_val + 1, max_val)]
    primes = list(filter(test_factorial, vals))
    print(format_answer(primes))


if __name__ == '__main__':
    main()