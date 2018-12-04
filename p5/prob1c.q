--=============================================================================
-- oshkosh
--=============================================================================
DROP TABLE IF EXISTS oshkosh;
CREATE EXTERNAL TABLE IF NOT EXISTS oshkosh(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/Oshkosh/';


--=============================================================================
-- Detail view
--=============================================================================
DROP VIEW IF EXISTS v1;
CREATE VIEW v1 AS
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(concat(Year, "-", Month, "-", Day, " ", TimeCST), 'yyyy-M-d h:m a'), 'yyyy-MM-dd') AS dte,
TemperatureF
FROM oshkosh
WHERE TemperatureF != -9999;

DROP VIEW IF EXISTS v2;
CREATE VIEW v2 AS
SELECT DISTINCT dte AS startdate, DATE_ADD(dte, 7) AS enddate
FROM v1;

DROP VIEW IF EXISTS v3;
CREATE VIEW v3 AS
SELECT v2.startdate, v2.enddate, AVG(v1.TemperatureF) AS avgtemp
FROM v1, v2
WHERE v1.dte >= startdate AND v1.dte <= enddate
GROUP BY v2.startdate, v2.enddate;


SELECT MAX(avgtemp)
FROM v3;

SELECT *
FROM v3
WHERE avgtemp = 81.05365853658536;
