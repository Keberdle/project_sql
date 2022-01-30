# CREATE TABLE
DROP TABLE IF EXISTS t_vasek_keberdle_projekt_SQL_final;
CREATE TABLE t_vasek_keberdle_projekt_SQL_final (
    country text NOT NULL,
    date    date NOT NULL,
    tests_performed double NULL,
    confirmed double NULL
)
;

# FILL basic data confirmed and tests
# I have no time to wait to joint without index
ALTER TABLE `covid19_tests` ADD INDEX `date` (`date`);
ALTER TABLE `covid19_tests` ADD INDEX `country` (`country`);

SELECT DISTINCT  c19b.country, c19b.date, confirmed, tests_performed
FROM covid19_basic_differences c19b
RIGHT JOIN covid19_tests c19t ON c19b.country = c19t.country AND c19b.date = c19t.date
WHERE 1
#AND c19b.date IS NULL
;

# FIx tests
SELECT COUNT(entity), entity
FROM covid19_tests
group by entity;
/**
5300,people tested
784,people tested (incl. non-PCR)
5404,samples tested
15360,tests performed
451,tests performed (incl. non-PCR)
567,units unclear
306,units unclear (incl. non-PCR)
 */
SELECT DISTINCT entities FROM (
SELECT count(entity), GROUP_CONCAT(entity) as entities, date, country
FROM `engeto-2021-07-29`.covid19_tests t
WHERE 1
#AND entity LIKE 'units unclear'
#AND country LIKE 'Bahrain'
#AND country LIKE 'Bahrain'
GROUP BY country, date
HAVING COUNT(entity) > 1
ORDER BY country) as tab
;
/**
"people tested,tests performed (incl. non-PCR)"
"people tested,samples tested"
"people tested,tests performed"
"people tested (incl. non-PCR),tests performed"
"tests performed,units unclear (incl. non-PCR)"

 */

SELECT count(entity), GROUP_CONCAT(entity, tests_performed) as entities, date, country
FROM `engeto-2021-07-29`.covid19_tests t
WHERE 1
#AND entity LIKE 'units unclear'
#AND country LIKE 'Bahrain'
AND entity LIKE 'units unclear (incl. non-PCR)' OR entity LIKE 'tests performed'
GROUP BY country, date
HAVING COUNT(entity) > 1
ORDER BY country
;

SELECT *
FROM covid19_tests
WHERE country LIKE 'BAhrain';
#TODO jaká data o testování tedy načíst nebo donačíst / odečíst
#nejprve zjistit zda "units unclear" jsou opravdu data opravná viz Bahrain má pouze "unit unclear"
#zmenit na pocty kde je people tested ?
#zmenit pocty kde je entity = people tested (incl. non-PCR?
#odecist units unclear (incl. non-PCR)?


# pocet obyvatel
# @TODO rozdelit na provincie? nebude pro ně dostatek dat nejspíše
SELECT country,  population FROM countries WHERE population IS NULL;
UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
LEFT JOIN countries c ON tvkpSf.country = c.country
SET tvkpSf.population = c.population
WHERE 1;



#TIME
##is_weekend
ALTER TABLE t_vasek_keberdle_projekt_SQL_final ADD time_is_weekend tinyint(1) NULL;

SELECT
       DISTINCT
    date,
    WEEKDAY(date)
FROM
    t_vasek_keberdle_projekt_SQL_final
WHERE 1;

    UPDATE t_vasek_keberdle_projekt_SQL_final
SET time_is_weekend = IF(WEEKDAY(date) > 4, 1 ,0)
WHERE 1;



#season_code
/**
  Meteorologické jaro začíná 1. března a končí 31. května
  https://cs.wikipedia.org/wiki/Ro%C4%8Dn%C3%AD_obdob%C3%AD
   */
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD time_season_code tinyint(1) NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final
SET time_season_code = CASE
                           WHEN MONTH(date) IN (3, 4, 5) THEN 0
                           WHEN MONTH(date) IN (6, 7, 8) THEN 1
                           WHEN MONTH(date) IN (9, 10, 11) THEN 2
                           WHEN MONTH(date) IN (12, 1, 2) THEN 3
    END
WHERE 1;

### density
SELECT population_density FROM countries;

#GDP
ALTER TABLE economies ADD INDEX `country` (`country`);
ALTER TABLE economies ADD INDEX `year` (year);


#GINI

SELECT MAX(gini) FROM economies;

#mortaliy_under5
SELECT max(year) FROM economies WHERE country LIKE 'Cze%';
SELECT max(year) FROM economies WHERE mortaliy_under5 IS NOT NULL;

#religions
ALTER TABLE pop_religion_per_country ADD INDEX `country` (`country`);
ALTER TABLE pop_religion_per_country ADD INDEX `year` (year);

SELECT DISTINCT religion
FROM pop_religion_per_country
WHERE country IN (SELECT country FROM t_vasek_keberdle_projekt_SQL_final);

SELECT t.population, r.population, ROUND(100*r.population/t.population, 2)
FROM t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN religions r ON t.country = r.country AND year = YEAR(date)
WHERE religion = 'Christianity' AND r.population > 0;

# fix Czechia problem
ALTER TABLE `lookup_table`
    ADD INDEX `iso3` (`iso3`(3));

ALTER TABLE `countries`
    ADD INDEX `country` (`country`(32)),
    ADD INDEX `iso3` (`iso3`(3));


SELECT DISTINCT c.country, lt.country, cbd.country
FROM covid19_basic_differences cbd
         LEFT JOIN lookup_table lt ON cbd.country = lt.country
         LEFT JOIN countries c ON lt.iso3 = c.iso3
WHERE lt.country != c.country AND lt.province IS NULL
ORDER BY lt.country;

ALTER TABLE `religions`
ADD INDEX `year_country` (`year`, `country`(32));

#rozdíl mezi očekávanou dobou dožití v roce 1965 a v roce 2015
SELECT * FROM life_expectancy WHERE country like 'Cze%';

SELECT y2015.country, ROUND(y2015.life_expectancy-y1965.life_expectancy) as life_expectancy_extend
FROM life_expectancy y2015
LEFT JOIN life_expectancy y1965 ON y2015.country = y1965.country
WHERE y1965.year = 1965
AND y2015.year = 2015
ORDER BY y2015.country;

SELECT *
FROM t_vasek_keberdle_projekt_SQL_final
WHERE life_expectancy_extend IS NULL;
SELECT *
FROM t_vasek_keberdle_projekt_SQL_final
WHERE country LIKE 'Cze%';


#WEATER
SELECT * FROM weather WHERE gust NOT LIKE '%km/h';
SELECT * FROM weather WHERE time = '06:00';
SELECT CONVERT(temp, INTEGER), weather.* FROM weather WHERE 1;
ALTER TABLE `weather`
    ADD INDEX `city_date_time` (`city`(32), `date`, time(5));

#Avg temp

SELECT c.country,
       DATE(w_six.date) AS date,
       capital_city,
       (w_six.temp + w_fifteen.temp + 2 * w_twenty_one.temp)/4 AS avg_temp
FROM countries c
         LEFT JOIN (SELECT REPLACE(temp, ' °C', '') AS temp, city, date  FROM weather WHERE time = '06:00') w_six ON c.capital_city = w_six.city
         LEFT JOIN (SELECT REPLACE(temp, ' °C', '') AS temp, city, date  FROM weather WHERE time = '15:00') w_fifteen ON c.capital_city = w_fifteen.city
         LEFT JOIN (SELECT REPLACE(temp, ' °C', '') AS temp, city, date  FROM weather WHERE time = '21:00') w_twenty_one ON c.capital_city = w_twenty_one.city
WHERE 1
  AND w_six.date = w_fifteen.date
  AND w_six.date = w_twenty_one.date
GROUP BY w_six.city, w_six.date
;
#Rainy
SELECT c.country,
       DATE(date),
       capital_city,
       SUM(IF(rain NOT LIKE '0.0 mm', 1, 0)) * 3 AS rainy_hours
FROM countries c
         LEFT JOIN weather w ON c.capital_city = w.city
WHERE w.city IS NOT NULL
GROUP BY city, date
;

# gust
SELECT c.country,
       DATE(date),
       capital_city,
       MAX(CONVERT(REPLACE(gust, ' km/h', ''), INTEGER )) AS max_gust
FROM countries c
         LEFT JOIN weather w ON c.capital_city = w.city
WHERE w.city IS NOT NULL
GROUP BY city, date
;

#GDP FIX
SELECT
       MAX(year) AS max_year,
       country
FROM economies
WHERE  gini IS NOT NULL
GROUP BY country;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN economies c ON t.country = c.country AND YEAR(t.date) = c.year
SET t.GDP_per_citizen = c.GDP/c.population
WHERE 1


## ideas
SELECT yearly_average_temperature FROM countries WHERE government_type IN ('Socialistic Republic', 'Socialistic State');

SELECT distinct country
FROM covid19_detail_us_differences;
