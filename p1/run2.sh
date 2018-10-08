#!/usr/bin/bash 

 hadoop jar /usr/hdp/2.6.5.0-292/hadoop-mapreduce/hadoop-streaming.jar \
 -files /home/maria_dev/repos/ds730/project1/mapper2.py,/home/maria_dev/repos/ds730/project1/reducer2.py \
 -input /user/maria_dev/repos/ds730/project1/input2/* \
 -output /user/maria_dev/repos/ds730/project1/output2 \
 -mapper mapper2.py \
 -reducer reducer2.py

