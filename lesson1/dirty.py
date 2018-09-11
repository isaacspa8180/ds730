import csv
from collections import OrderedDict
from pathlib import Path

dats = {}
filenames = [x for x in Path('dat/').iterdir() if x.is_file()]
for filename in filenames:
    dat = []
    with open(filename, newline='') as fh:
        delimiter = ','
        if len(fh.readline().split(';')) > 1:
            delimiter = ';'
        fh.seek(0)            
        for rw in csv.DictReader(fh, delimiter=delimiter):
            if 'TemperatureC' in rw.keys():
                rw['TemperatureF'] = float(rw['TemperatureC']) * (9/5) + 32
                del rw['TemperatureC']
            if 'Wind SpeedKPH' in rw.keys():
                rw['Wind SpeedMPH'] = float(rw['Wind SpeedKPH']) * 0.6213711922
                del rw['Wind SpeedKPH']
            if rw['Wind SpeedMPH'] == 'Calm':
                rw['Wind SpeedMPH'] = 0               
            # myorder = ['Year', 'Month', 'Day', 'TimeCST', 'TemperatureF', 'Wind SpeedMPH']
            # rw_ordered = OrderedDict((k, rw[k]) for k in myorder)
            rw_ordered = OrderedDict([('Year', int(rw['Year'])), ('Month', int(rw['Month'])), 
                ('Day', int(rw['Day'])), ('TimeCST', rw['TimeCST']), 
                ('TemperatureF', float(rw['TemperatureF'])), 
                ('Wind SpeedMPH', float(rw['Wind SpeedMPH']))])            
            dat.append(rw_ordered)
        dats[filename.stem] = dat


wind_mar_2006 = {}
for k, v in dats.items():
    acc = 0
    cnt = 0
    for rw in v:
        if rw['Year'] == 2006 and rw['Month'] == 3:
            if rw['Wind SpeedMPH'] > 0:
                acc += rw['Wind SpeedMPH']
                cnt += 1
    wind_mar_2006[k] = acc / cnt        


temp_2006 = {}
for k, v in dats.items():
    acc = 0
    cnt = 0
    for rw in v:
        if rw['Year'] == 2006:
            if rw['TemperatureF'] >= -129:
                acc += rw['TemperatureF']
                cnt += 1
    temp_2006[k] = acc / cnt        