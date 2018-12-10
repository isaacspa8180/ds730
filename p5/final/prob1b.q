--=============================================================================
-- iowacity
--=============================================================================
DROP TABLE IF EXISTS iowacity;
CREATE EXTERNAL TABLE IF NOT EXISTS iowacity(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/IowaCity/';


--=============================================================================
-- oshkosh
--=============================================================================
DROP TABLE IF EXISTS oshkosh;
CREATE EXTERNAL TABLE IF NOT EXISTS oshkosh(Year STRING, Month STRING, Day STRING, TimeCST STRING, TemperatureF INT, DewPointF STRING, Humidity STRING, SeaLevelPressureIn STRING, VisibilityMPH STRING, WindDirection STRING, WindSpeedMPH STRING, GustSpeedMPH STRING, PrecipitationIn STRING, Events STRING, Conditions STRING, WindDirDegrees STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/final/Oshkosh/';


--=============================================================================
-- Detail view
--=============================================================================
CREATE VIEW SeasonTemperatureDetail AS
SELECT 
    'oshkosh' AS city, 
    CASE WHEN Month IN (12, 1, 2) THEN 'winter'
         WHEN Month IN (3, 4, 5) THEN 'spring'
         WHEN Month IN (6, 7, 8) THEN 'summer'
         WHEN Month IN (9, 10, 11) THEN 'fall'
    END AS season,
    TemperatureF
FROM 
    oshkosh
WHERE 
    TemperatureF != -9999
UNION ALL
SELECT 
    'iowacity' AS city, 
    CASE WHEN Month IN (12, 1, 2) THEN 'winter'
         WHEN Month IN (3, 4, 5) THEN 'spring'
         WHEN Month IN (6, 7, 8) THEN 'summer'
         WHEN Month IN (9, 10, 11) THEN 'fall'
    END AS season,
    TemperatureF
FROM 
    iowacity
WHERE 
    TemperatureF != -9999;


--=============================================================================
-- Summary view
--=============================================================================
CREATE VIEW SeasonTemperatureAvg AS
SELECT DISTINCT
    city, 
    season, 
    AVG(TemperatureF) OVER (PARTITION BY city, season) AS avgtemp
FROM SeasonTemperatureDetail;


--=============================================================================
-- Main
--=============================================================================
SELECT o.season, o.avgtemp - i.avgtemp AS oshkosh_minus_iowacity_tempdiff 
FROM 
    SeasonTemperatureAvg AS o
INNER JOIN 
    (
    SELECT * 
    FROM SeasonTemperatureAvg
    WHERE city = 'iowacity'
    ) AS i
    ON i.season = o.season
WHERE 
    o.city = 'oshkosh';
