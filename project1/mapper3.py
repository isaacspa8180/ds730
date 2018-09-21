import sys 


def main(argv):
    for line in iter(sys.stdin.readline, ''):
        line = line.strip()
        k, vs = line.split(' : ', 1)
        for v in vs.split(' '):
            l = min(int(k), int(v))
            h = max(int(k), int(v))
            print('{0},{1}\t{2}'.format(l, h, vs))        


if __name__ == '__main__':
    main(sys.argv)