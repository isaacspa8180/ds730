--=============================================================================
-- Data
--=============================================================================
f = LOAD 'hdfs:/user/maria_dev/pig/Fielding.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,POS:chararray,G:int,GS:int,InnOuts:int,PO:int,A:int,E:int,DP:int,PB:int,WP:int,SB:int,CS:int,ZR:int);

--=============================================================================
-- Main
--=============================================================================
A = FILTER f BY yearID == 2001;
B = FOREACH A GENERATE teamID, E;
C = GROUP B BY teamID;
D = FOREACH C GENERATE group, SUM(B.E) as tot;
E = RANK D by tot DESC DENSE;
F = FILTER E BY rank_D == 1;
G = FOREACH F GENERATE group;
DUMP G;
