import csv
from collections import defaultdict
from datetime import datetime


# with open('test_orders.csv', newline='') as fh:
#     rdr = csv.DictReader(fh)
#     d = defaultdict(float)
#     for rw in rdr:
#         month = datetime.strptime(rw['InvoiceDate'], '%m/%d/%Y %H:%M').month
#         spent = float(rw['UnitPrice']) * float(rw['Quantity'])
#         d[(month, rw['Country'].lower(), rw['CustomerID'])] += spent
#     for k, v in d.items():
#         print('{0},{1}\t{2},{3}'.format(k[0], k[1], k[2], v))


with open('test_orders.csv', newline='') as fh:
    rdr = csv.DictReader(fh)
    for rw in rdr:
        month = datetime.strptime(rw['InvoiceDate'], '%m/%d/%Y %H:%M').month
        spent = float(rw['UnitPrice']) * float(rw['Quantity'])
        print('{0},{1}\t{2},{3}'.format(month, rw['Country'].lower(), rw['CustomerID'], spent))