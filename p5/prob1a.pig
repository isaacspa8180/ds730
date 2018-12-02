--=============================================================================
-- iowa
--=============================================================================
iowa= LOAD '/user/maria_dev/final/IowaCity/IowaCityWeather.csv'USING PigStorage(',') AS (Year:CHARARRAY,Month:CHARARRAY,Day:CHARARRAY,TimeCST:CHARARRAY,TemperatureF:INT,DewPointF:CHARARRAY,Humidity:CHARARRAY,SeaLevelPressureIn:CHARARRAY,VisibilityMPH:CHARARRAY,WindDirection:CHARARRAY,WindSpeedMPH:CHARARRAY,GustSpeedMPH:CHARARRAY,PrecipitationIn:CHARARRAY,Events:CHARARRAY,Conditions:CHARARRAY,WindDirDegrees:CHARARRAY);

cold = FILTER iowa BY TemperatureF != -9999 AND TemperatureF <= -10;
