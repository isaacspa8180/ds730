import argparse
import sys
from pathlib import Path


def main(argv):
    parser = argparse.ArgumentParser(description='STUFF')
    parser.add_argument('-f', '--folder', required=True, metavar='FOLDER')
    parser.add_argument('-m', '--mapper', required=True, metavar='FILE')
    parser.add_argument('-r', '--reducer', required=True, metavar='FILE')
    args = parser.parse_args()
    cmd = 'hadoop jar'
    jar = '/usr/hdp/2.6.5.0-292/hadoop-mapreduce/hadoop-streaming.jar'
    base_dir = Path('home/maria_dev')
    input = base_dir / args.folder / 'input'
    output = base_dir / args.folder / 'output'
    mapper_file = str(base_dir/ args.folder / args.mapper)
    reducer_file = str(base_dir/ args.folder / args.reducer)
    print('#!/usr/bin/bash \n\n {cmd} {jar} \\\n -files {files} \\\n -input {input} \\\n -output {output} \\\n -mapper {mapper} \ \n -reducer {reducer}\n'.format(
        cmd = cmd,
        jar = jar,
        files = ','.join([mapper_file, reducer_file]),
        input = input,
        output = output,
        mapper = args.mapper,
        reducer = args.reducer
    ))


if __name__ == '__main__':
    main(sys.argv)