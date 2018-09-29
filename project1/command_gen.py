import argparse
import sys
from pathlib import Path


def main(argv):
    parser = argparse.ArgumentParser(description='This will generate a bash script for running MapReduce jobs on hdfs')
    parser.add_argument('-f', '--folder', required=True, metavar='FOLDER', help='folder for all files for job')
    parser.add_argument('-m', '--mapper', required=True, metavar='FILE')
    parser.add_argument('-r', '--reducer', required=True, metavar='FILE')
    parser.add_argument('--hdfs', action='store_true', help='Set this to use the hdfs instead of local filesystem')
    args = parser.parse_args()
    cmd = 'hadoop jar'
    jar = '/usr/hdp/2.6.5.0-292/hadoop-mapreduce/hadoop-streaming.jar'
    base_local = Path('/home/maria_dev/repos/ds730')
    base_hdfs = Path('/user/maria_dev/repos/ds730')
    full_hdfs = Path('hdfs://sandbox.hortonworks.com:8020/user/maria_dev/repos/ds730')
    base_dir = full_hdfs if args.hdfs else base_local
    input = base_hdfs / args.folder / 'input'
    output = base_hdfs / args.folder / 'output'
    mapper_file = str(base_dir/ args.folder / args.mapper)
    reducer_file = str(base_dir/ args.folder / args.reducer)
    print('#!/usr/bin/bash \n\n {cmd} {jar} \\\n -files {files} \\\n -input {input}/* \\\n -output {output} \\\n -mapper {mapper} \\\n -reducer {reducer}\n'.format(
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
