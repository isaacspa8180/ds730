#!/usr/bin/bash 

 hadoop jar /usr/hdp/2.6.5.0-292/hadoop-mapreduce/hadoop-streaming.jar \
 -files /home/maria_dev/repos/ds730/project1/mapper1.py,/home/maria_dev/repos/ds730/project1/reducer1.py \
 -input /user/maria_dev/repos/ds730/project1/input1/* \
 -output /user/maria_dev/repos/ds730/project1/output1 \
 -mapper mapper1.py \
 -reducer reducer1.py

