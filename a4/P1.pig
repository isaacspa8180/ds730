bat = LOAD 'hdfs:/user/maria_dev/pigtest/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
mas = LOAD 'hdfs:/user/maria_dev/pigtest/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);
df = JOIN bat BY playerID, mas BY playerID;
df2 = FILTER df BY B3 > 5 AND yearID == 2005;
df3 = GROUP df2 ALL;
df4 = FOREACH df3 GENERATE MAX(df2.weight) AS max_weight;
df5 = JOIN df2 BY weight, df4 BY max_weight;
df6 = FOREACH df5 GENERATE df2::mas::playerID;
DUMP df6;
