--=============================================================================
-- Data
--=============================================================================
b = LOAD 'hdfs:/user/maria_dev/pig/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
m = LOAD 'hdfs:/user/maria_dev/pig/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);

--============================================================================
-- Master
--============================================================================
A1 = FILTER m BY birthMonth IS NOT NULL AND birthState IS NOT NULL;
B1 = FOREACH A1 GENERATE CONCAT((chararray)birthMonth, '/', birthState) AS birthMonthState, playerID;
C1 = GROUP B1 BY birthMonthState;
D1 = FOREACH C1 GENERATE group AS birthMonthState, COUNT(B1.playerID) AS cnt;
E1 = FILTER D1 BY cnt >= 5;
F1 = JOIN E1 BY birthMonthState, B1 BY birthMonthState;

--============================================================================
-- Batting
--============================================================================
A2 = JOIN F1 BY B1::playerID, b BY playerID;
B2 = GROUP A2 BY F1::E1::birthMonthState;
C2 = FOREACH B2 GENERATE group AS birthMonthState, SUM(A2.H) AS H, SUM(A2.AB) AS AB;
D2 = FILTER C2 BY AB > 100;
E2 = FOREACH D2 GENERATE birthMonthState, ((float)(H) / (float)(AB)) AS stat;
F2 = RANK E2 BY stat ASC DENSE;
G2 = FILTER F2 BY rank_E2 == 1;
H2 = FOREACH G2 GENERATE birthMonthState;
DUMP H2;
