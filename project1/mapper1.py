import csv
import sys
from collections import defaultdict
from datetime import datetime


def main(argv):
        for rw in csv.DictReader(iter(sys.stdin.readline, '')):
            if rw['InvoiceNo'][0].lower() != 'c' and rw['CustomerID'] != '':
                month = datetime.strptime(rw['InvoiceDate'], '%m/%d/%Y %H:%M').month
                spent = float(rw['UnitPrice']) * float(rw['Quantity'])
                print('{0:02},{1}\t{2},{3}'.format(month, rw['Country'].lower(), rw['CustomerID'], spent))


if __name__ == '__main__':
    main(sys.argv)