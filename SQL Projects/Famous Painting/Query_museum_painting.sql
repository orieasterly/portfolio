
-- museum open on Sunday and Monday
SELECT m.Name, m.City
FROM [paintings].[dbo].[museum_hours] m_
JOIN [paintings].[dbo].[museum] m 
    ON m.museum_id = m_.museum_id
WHERE m_.day ='Sunday' AND
EXISTS (SELECT 1 FROM [paintings].[dbo].[museum_hours] mh_ 
        WHERE mh_.museum_id = m_.museum_id
        AND mh_.day='Monday')

-- which museums are open the longest during a day, display name, state and hours and which day

WITH
    MuseumHoursCTE
    as
    (
        SELECT
        m.[name]
        , m.[city]
        , m.[state]
        , mh_.[day]    
        /*  Used CONVERT function to convert the time portion of the string to TIME.
            Combined the hh:mm part and the AM/PM part using string concatenation (+).
            Applied RIGHT function to extract the AM or PM part from the time string and concatenate it with the hh:mm part. */
        , CONVERT(TIME, SUBSTRING(mh_.[open], 1, 5) + ' ' + RIGHT(mh_.[open], 2)) AS open_time
        , CONVERT(TIME, SUBSTRING(mh_.[close], 1, 5) + ' ' + RIGHT(mh_.[close], 2)) AS close_time
        FROM [paintings].[dbo].[museum_hours] mh_
            JOIN [paintings].[dbo].[museum] m
            ON m.museum_id = mh_.museum_id
    )

SELECT 
    [name],
    [city],
    [day],
    open_time,
    close_time, 
    CAST(DATEDIFF(MINUTE, open_time, close_time) AS DECIMAL )  / 60 AS duration
FROM 
    MuseumHoursCTE

WHERE 
    DATEDIFF(MINUTE, open_time, close_time) = (
        SELECT MAX(DATEDIFF(MINUTE, open_time, close_time)) 
        FROM MuseumHoursCTE
    );

-- Display the country and the city with the most number of museums. Output 2 separate columns to with the city name and the country name.
-- If there are multiple values, separate the result with a comma.

WITH
    CTE_city_count
    AS
    (
        SELECT m.Country, m.City, COUNT(m.museum_id) AS city_museum_count
        FROM paintings.dbo.museum AS m
        GROUP BY m.Country, m.City
        --ORDER BY museum_count DESC
    ),
    CTE_country_count
    AS
    (
        SELECT m.Country, COUNT(m.museum_id) AS country_museum_count
        FROM paintings.dbo.museum AS m
        GROUP BY m.Country
    )
SELECT 
  STUFF(
            (
                SELECT ', ' + CONCAT(country.Country, ' ', ' - ', CAST(country.country_museum_count AS VARCHAR(10)))
                FROM CTE_country_count country
                WHERE country.country_museum_count = (SELECT MAX(country_museum_count) FROM CTE_country_count)
                FOR XML PATH('')
            ), 1, 2, ''
        ) AS Top_country,

  STUFF(
            (
                SELECT ', ' + CONCAT(city.Country, ' ', city.City, ' - ', CAST(city.city_museum_count AS VARCHAR(10)))
                FROM CTE_city_count city
                WHERE city.city_museum_count = (SELECT MAX(city_museum_count) FROM CTE_city_count)
                ORDER BY city.Country DESC
                FOR XML PATH('')
            ), 1, 2, ''
        ) AS Top_city;

    -- The STUFF function concatenates the individual rows into one line.
    -- The FOR XML PATH clause is used to concatenate the rows into one string.
    -- The WHERE clause filters for the maximum museum count.
    -- ORDER BY sorts the result by country in descending order.

    -- CONCAT_WS(', ', m_.Country, m_.City, m_.museum_count) as number_of_museums
    -- FROM MuseumCount m_
    -- WHERE m_.museum_count = (SELECT MAX(museum_count) FROM MuseumCount)
    -- ORDER BY m_.country DESC;

