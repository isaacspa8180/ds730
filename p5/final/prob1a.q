--=============================================================================
-- oshkosh
--=============================================================================
DROP TABLE IF EXISTS oshkosh;
CREATE EXTERNAL TABLE IF NOT EXISTS oshkosh(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/Oshkosh/';

DROP VIEW IF EXISTS cold;
CREATE VIEW cold
AS
SELECT COUNT(*) 
FROM oshkosh 
WHERE TemperatureF != -9999 
AND TemperatureF <= -10;

DROP VIEW IF EXISTS hot;
CREATE VIEW hot
AS
SELECT COUNT(*) 
FROM oshkosh 
WHERE TemperatureF != -9999 
AND TemperatureF >= 95;

SELECT 'cold', * FROM cold
UNION ALL
SELECT 'hot', * FROM hot;

