#!/usr/bin/bash 

 hadoop jar /usr/hdp/2.6.5.0-292/hadoop-mapreduce/hadoop-streaming.jar \
 -files /home/maria_dev/repos/ds730/project1/mapper3.py,/home/maria_dev/repos/ds730/project1/reducer3.py \
 -input /user/maria_dev/repos/ds730/project1/input3/* \
 -output /user/maria_dev/repos/ds730/project1/output3 \
 -mapper mapper3.py \
 -reducer reducer3.py

