b = LOAD 'hdfs:/user/maria_dev/pig/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
f = LOAD 'hdfs:/user/maria_dev/pig/Fielding.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,POS:chararray,G:int,GS:int,InnOuts:int,PO:int,A:int,E:int,DP:int,PB:int,WP:int,SB:int,CS:int,ZR:int);
--============================================================================
-- Batting 
--============================================================================
A1 = FILTER b BY yearID >= 2005 AND yearID <= 2009;
B1 = FOREACH A1 GENERATE playerID, AB, H;
C1 = GROUP B1 BY playerID; 
D1 = FOREACH C1 GENERATE group AS playerID, (float)SUM(B1.AB) AS AB_tot, (float)SUM(B1.H) AS H_tot;
E1 = FILTER D1 BY AB_tot >= 40;

--============================================================================
-- Fielding 
--============================================================================
A2a = FILTER f BY yearID >= 2005 AND yearID <= 2009;
A2b = FILTER A2a BY GS IS NOT NULL OR InnOuts IS NOT NULL OR PO IS NOT NULL OR A IS NOT NULL OR E IS NOT NULL OR DP IS NOT NULL OR PB IS NOT NULL OR WP IS NOT NULL OR SB IS NOT NULL OR CS IS NOT NULL OR ZR IS NOT NULL;
B2 = FOREACH A2b GENERATE playerID, G, E;
C2 = GROUP B2 BY playerID;
D2 = FOREACH C2 GENERATE group AS playerID, (float)SUM(B2.G) AS G_tot, (float)SUM(B2.E) AS E_tot;
E2 = FILTER D2 BY G_tot >= 20;

--============================================================================
-- Main
--============================================================================
F = JOIN E1 BY playerID, E2 BY playerID;
G = FOREACH F GENERATE E1::playerID AS playerID, ((E1::H_tot / E1::AB_tot) - (E2::E_tot / E2::G_tot)) AS stat;
H = ORDER G by stat DESC;
I = LIMIT H 3;
DUMP I;
