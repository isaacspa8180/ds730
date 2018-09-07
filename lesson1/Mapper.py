import sys
import re


def main(argv):
    line = sys.stdin.readline()
    pattern = re.compile("[a-zA-Z0-9]+")
    while line:
        for word in pattern.findall(line):
            print(word.lower() + "\t" + "1")
        line = sys.stdin.readline()


if __name__ == "__main__":
    main(sys.argv)    