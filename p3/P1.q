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
-- view
--=============================================================================
DROP VIEW IF EXISTS PlayerTotalAB;
CREATE VIEW PlayerTotalAB AS
SELECT b.playerID, SUM(b.AB) AS tot_ab, DENSE_RANK() OVER (ORDER BY SUM(b.AB) DESC) AS rnk
FROM batting AS b
GROUP BY b.playerID;

--=============================================================================
-- select
--=============================================================================
SELECT m.birthCity
FROM master AS m
INNER JOIN PlayerTotalAB AS x
ON x.playerID = m.playerID AND x.rnk = 1;
