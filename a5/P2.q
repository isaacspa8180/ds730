--=============================================================================
-- batting
--=============================================================================
DROP TABLE IF EXISTS batting;
CREATE EXTERNAL TABLE IF NOT EXISTS batting(id STRING, year INT, team STRING, league STRING, games INT, ab INT, runs INT, hits INT, doubles INT, triples INT, homeruns INT, rbi INT, sb INT, cs INT, walks INT, strikeouts INT, ibb INT, hbp INT, sh INT, sf INT, gidp INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hivetest/batting';

--=============================================================================
-- master
--=============================================================================
DROP TABLE IF EXISTS master;
CREATE EXTERNAL TABLE IF NOT EXISTS master(id STRING, byear INT, bmonth INT, bday INT, bcountry STRING, bstate STRING, bcity STRING, dyear INT, dmonth INT, dday INT, dcountry STRING, dstate STRING, dcity STRING, fname STRING, lname STRING, name STRING, weight INT, height INT, bats STRING, throws STRING, debut STRING, finalgame STRING, retro STRING, bbref STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hivetest/master';

--=============================================================================
-- view
--=============================================================================
CREATE VIEW PlayerTeamCountByYear
AS
SELECT b.id, COUNT(*) AS cnt
FROM batting b
GROUP BY b.id, b.year;

--=============================================================================
-- select
--=============================================================================
SELECT id FROM PlayerTeamCountByYear 
INNER JOIN (SELECT MAX(cnt) AS max_cnt FROM PlayerTeamCountByYear) AS max
ON max.max_cnt = PlayerTeamCountByYear.cnt;

--This is another was to do it.
--SELECT id FROM PlayerTeamCountByYear
--WHERE cnt IN (SELECT MAX(cnt) FROM PlayerTeamCountByYear);
