bat = LOAD 'Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,2B:int,3B:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
mas = LOAD 'Master.csv' USING PigStorage(';') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);
df = JOIN bat BY playerID, mas BY playerID;
df2 = FILTER df BY yearID >= 1980 AND yearID <= 1989;
df3 = FOREACH df2 GENERATE *, (2B + 3B + HR) AS exraBaseHit;
df4 = GROUP df3 BY playerID, COUNT(exraBaseHit)
df5 = FOREACH df4 GENERATE playerID, MAX(exraBaseHit);
