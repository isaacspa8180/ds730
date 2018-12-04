--=============================================================================
-- oshkosh
--=============================================================================
DROP TABLE IF EXISTS oshkosh;
CREATE EXTERNAL TABLE IF NOT EXISTS oshkosh(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/Oshkosh/';


--=============================================================================
-- iowacity
--=============================================================================
DROP TABLE IF EXISTS iowacity;
CREATE EXTERNAL TABLE IF NOT EXISTS iowacity(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/IowaCity/';


--=============================================================================
-- Detail view
--=============================================================================
DROP VIEW IF EXISTS v1;
CREATE VIEW v1 AS
SELECT 
'oshkosh' AS city,
Month,
FROM_UNIXTIME(UNIX_TIMESTAMP(concat(Year, "-", Month, "-", Day, " ", TimeCST), 'yyyy-M-d h:m a'), 'HH') AS Hour,
TemperatureF
FROM oshkosh
WHERE TemperatureF != -9999
UNION ALL
SELECT 
'iowacity' AS city,
Month,
FROM_UNIXTIME(UNIX_TIMESTAMP(concat(Year, "-", Month, "-", Day, " ", TimeCST), 'yyyy-M-d h:m a'), 'HH') AS Hour,
TemperatureF
FROM iowacity
WHERE TemperatureF != -9999;


DROP VIEW IF EXISTS v2;
CREATE VIEW v2 AS
SELECT city, Month, Hour, AVG(TemperatureF) as avgtemp
FROM v1
GROUP BY city, Month, Hour;

DROP VIEW IF EXISTS v3;
CREATE VIEW v3 AS
SELECT *, ABS(50 - avgtemp) AS distto50, MIN(ABS(50 - avgtemp)) OVER (PARTITION BY city, Month) AS closestto50
FROM v2;

SELECT *
FROM v3
WHERE distto50 = closestto50;

