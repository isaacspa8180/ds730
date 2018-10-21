--=============================================================================
-- batting
--=============================================================================
DROP TABLE IF EXISTS batting;
CREATE EXTERNAL TABLE IF NOT EXISTS batting(playerID STRING, yearID INT, teamID STRING, lgID STRING, G INT, AB INT, R INT, H INT, B2 INT, B3 INT, HR INT, RBI INT, SB INT, CS INT, BB INT, SO INT, IBB INT, HBP INT, SH INT, SF INT, GIDP INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hive/batting';

--=============================================================================
-- master
--=============================================================================
DROP TABLE IF EXISTS master;
CREATE EXTERNAL TABLE IF NOT EXISTS master(playerID STRING, birthYear INT, birthMonth INT, birthDay INT, birthCountry STRING, birthState STRING, birthCity STRING, deathYear INT, deathMonth INT, deathDay INT, deathCountry STRING, deathState STRING, deathCity STRING, nameFirst STRING, nameLast STRING, nameGiven STRING, weight INT, height INT, bats STRING, throws STRING, debut DATE, finalGame DATE, retroID STRING, bbrefID STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hive/master';

--=============================================================================
-- fielding
--=============================================================================
DROP TABLE IF EXISTS fielding;
CREATE EXTERNAL TABLE IF NOT EXISTS fielding(playerID STRING, yearID INT, teamID STRING, lgID STRING, POS STRING, G INT, GS INT, InnOuts INT, PO INT, A INT, E INT, DP INT, PB INT, WP INT, SB INT, CS INT, ZR INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hive/fielding';

--=============================================================================
-- batting
--=============================================================================
DROP VIEW IF EXISTS PlayerBatting;
CREATE VIEW PlayerBatting
AS
SELECT b.playerID, SUM(b.H) AS tot_h, SUM(b.AB) AS tot_ab
FROM batting AS b
WHERE b.yearID >= 2005 AND b.yearID <= 2009
GROUP BY b.playerID 
HAVING SUM(b.AB) >= 40;


--=============================================================================
-- fielding
--=============================================================================
DROP VIEW IF EXISTS PlayerFielding;
CREATE VIEW PlayerFielding
AS
SELECT f.playerID, SUM(f.E) AS tot_e, SUM(f.G) AS tot_g
FROM fielding AS f
WHERE f.yearID >= 2005 and f.yearID <= 2009 
AND (f.GS IS NOT NULL OR f.InnOuts IS NOT NULL OR f.PO IS NOT NULL OR f.A IS NOT NULL OR f.E IS NOT NULL OR f.DP IS NOT NULL OR f.PB IS NOT NULL OR f.WP IS NOT NULL OR f.SB IS NOT NULL OR f.CS IS NOT NULL OR f.ZR IS NOT NULL)
GROUP BY f.playerID 
HAVING SUM(f.G) >= 20;

--=============================================================================
-- select
--=============================================================================
DROP VIEW IF EXISTS PlayerStat;
CREATE VIEW PlayerStat
AS
SELECT 
b.playerID, 
(b.tot_h / b.tot_ab) - (f.tot_e / f.tot_g) AS stat,
DENSE_RANK() OVER (ORDER BY (b.tot_h / b.tot_ab) - (f.tot_e / f.tot_g) DESC) AS rnk
FROM PlayerBatting AS b
INNER JOIN PlayerFielding AS f
ON f.playerID = b.playerID;

SELECT playerID FROM PlayerStat WHERE rnk <= 3;

--(1,escobal01,0.3128436)
--(2,suzukic01,0.3082046)
--(3,hoppeno01,0.3076566)
--(4,mauerjo01,0.29985067)
--(5,redmomi01,0.29663962)
--(6,ordonma01,0.29417863)
--(7,velanjo01,0.2923077)
--(8,vargaja01,0.29166666)
--(9,ellsbja01,0.29061928)
--(10,hollima01,0.2891589)
