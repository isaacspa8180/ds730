--=============================================================================
-- Data
--=============================================================================
b = LOAD 'hdfs:/user/maria_dev/pig/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
m = LOAD 'hdfs:/user/maria_dev/pig/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);
f = LOAD 'hdfs:/user/maria_dev/pig/Fielding.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,POS:chararray,G:int,GS:int,InnOuts:int,PO:int,A:int,E:int,DP:int,PB:int,WP:int,SB:int,CS:int,ZR:int);

--=============================================================================
-- Main
--=============================================================================
A = FOREACH b GENERATE playerID, B2 + B3 AS dbl_tpl;
B = FILTER m BY birthCity IS NOT NULL AND birthState IS NOT NULL;
C = FOREACH B GENERATE playerID, CONCAT((chararray)birthCity, '/', (chararray)birthState) AS birthCityState;
D = JOIN C by playerID, A BY playerID;
E = FOREACH D GENERATE C::birthCityState AS birthCityState, A::dbl_tpl AS dbl_tpl;
F = GROUP E BY birthCityState;
G = FOREACH F GENERATE group AS birthCityState, SUM(E.dbl_tpl) AS tot;
H = ORDER G BY tot DESC;
I = FOREACH H GENERATE birthCityState;
J = LIMIT I 5;
DUMP J;
