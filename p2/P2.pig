--=============================================================================
-- Data
--=============================================================================
m = LOAD 'hdfs:/user/maria_dev/pig/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);

--=============================================================================
-- Main
--=============================================================================
A = FOREACH m GENERATE CONCAT((chararray)birthMonth,'/', (chararray)birthDay) as birthMonDay, 1 AS cnt;
B = FILTER A BY birthMonDay IS NOT NULL;
C = GROUP B by birthMonDay;
D = FOREACH C GENERATE group, SUM(B.cnt) AS tot;
E = RANK D BY tot DESC DENSE;
F = FILTER E BY rank_D <= 3;
G = FOREACH F GENERATE group;
DUMP G;
