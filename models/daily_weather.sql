WITH daily_weather AS (
    SELECT
    DATE(time) AS DAILY_WEATHER,
    WEATHER,
    TEMP,
    PRESSURE,
    HUMIDITY,
    CLOUDS

    FROM
    {{ source('demo', 'weather') }}
),

daily_weather_agg as (
    SELECT
    DAILY_WEATHER,
    WEATHER,
    ROUND(AVG(TEMP),2) AS AVG_TEMP,
    ROUND(AVG(PRESSURE),2) AS AVG_PRESSURE,
    ROUND(AVG(HUMIDITY),2) AS AVG_HUMIDITY,
    ROUND(AVG(CLOUDS),2) AS AVG_CLOUDS
    FROM
    daily_weather
    GROUP BY DAILY_WEATHER, WEATHER
    QUALIFY ROW_NUMBER() OVER (PARTITION BY DAILY_WEATHER ORDER BY COUNT(WEATHER) DESC) = 1 
)

select * FROM daily_weather_agg 



