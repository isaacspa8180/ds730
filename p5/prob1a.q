--=============================================================================
-- iowacity
--=============================================================================
DROP TABLE IF EXISTS iowacity;
CREATE EXTERNAL TABLE IF NOT EXISTS iowacity(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/IowaCity/';

CREATE VIEW cold
AS
SELECT COUNT(*) 
FROM iowacity 
WHERE TemperatureF != -9999 
AND TemperatureF <= -10;

CREATE VIEW hot
AS
SELECT COUNT(*) 
FROM iowacity 
WHERE TemperatureF != -9999 
AND TemperatureF >= 95;

