#!/usr/bin/env python

import sys
from collections import namedtuple
from datetime import datetime


def main(argv):
    Order = namedtuple('Order', ['InvoiceNo','StockCode','Description','Quantity','InvoiceDate','UnitPrice','CustomerID','Country'])
    line = sys.stdin.readline().strip().split(',')
    order = Order(*line)
    while line:
        if order.InvoiceDate[0].lower() != 'c' and order.CustomerID != '':
            month = datetime.strptime(order.InvoiceDate, '%m/%d/%Y %H:%M').month
            spent = float(order.UnitPrice) * float(order.Quantity)
            print('{0:02},{1}\t{2},{3}'.format(month, order.Country, order.CustomerID, spent))
        line = sys.stdin.readline()

if __name__ == '__main__':
    main(sys.argv)
