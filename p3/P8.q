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
-- view master
--=============================================================================
DROP VIEW IF EXISTS BirthMonthState;
CREATE VIEW BirthMonthState AS
SELECT CONCAT(birthMonth, '/', birthState) AS birthMonthState
FROM master
GROUP BY CONCAT(birthMonth, '/', birthState)
HAVING COUNT(playerID) >= 5;

--=============================================================================
-- view batter
--=============================================================================
DROP VIEW IF EXISTS SumHitsAtBat;
CREATE VIEW SumHitsAtBat AS
SELECT ms.birthMonthState, SUM(b.H) AS H, SUM(b.AB) AS AB
FROM batting b
INNER JOIN master m on m.playerID = b.playerID
INNER JOIN BirthMonthState ms on ms.birthMonthState = CONCAT(m.birthMonth, '/', m.birthState)
GROUP BY ms.birthMonthState
HAVING SUM(b.AB) > 100;

--=============================================================================
-- view combo
--=============================================================================
DROP VIEW IF EXISTS RankedStats;
CREATE VIEW RankedStats AS
SELECT birthMonthState, H / AB AS stat, DENSE_RANK() OVER (ORDER BY H / AB) AS rnk
FROM SumHitsAtBat;

--=============================================================================
-- select
--=============================================================================
SELECT birthMonthState
FROM RankedStats
WHERE rnk <= 1;
