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
FROM_UNIXTIME(UNIX_TIMESTAMP(concat(Year, "-", Month, "-", Day, " ", TimeCST), 'yyyy-M-d h:m a'), 'yyyy-MM-dd h:00:00 a') AS dte_h,
TemperatureF
FROM oshkosh
WHERE TemperatureF != -9999;

DROP VIEW IF EXISTS v2;
CREATE VIEW v2 AS
SELECT dte, dte_h, AVG(TemperatureF) as avgtemp
FROM v1
GROUP BY dte, dte_h;

DROP VIEW IF EXISTS v3;
CREATE VIEW v3 AS
SELECT *, MIN(avgtemp) OVER (PARTITION BY dte) AS mintemp
FROM v2;

DROP VIEW IF EXISTS v4;
CREATE VIEW v4 AS
SELECT HOUR(dte_h) AS hr
FROM v3
WHERE mintemp = avgtemp;

DROP VIEW IF EXISTS v5;
CREATE VIEW v5 AS
SELECT hr, COUNT(*)
FROM v4
GROUP BY hr;
