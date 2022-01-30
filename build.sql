# CREATE TABLE
DROP TABLE IF EXISTS t_vasek_keberdle_projekt_SQL_final
;

DROP TABLE IF EXISTS tmp_covid19_basic_differences
;
CREATE TABLE t_vasek_keberdle_projekt_SQL_final (
    country         text   NOT NULL,
    date            date   NOT NULL,
    tests_performed double NULL,
    confirmed       double NULL
)
;

ALTER TABLE `t_vasek_keberdle_projekt_SQL_final`
    ADD PRIMARY KEY `date_country` (`date`, `country`(32));

#basic diferences table use Czechia and test !!
## FIX Czechia / Czech republic

CREATE TABLE IF NOT EXISTS tmp_covid19_basic_differences AS (
    SELECT * FROM covid19_basic_differences
);


UPDATE tmp_covid19_basic_differences  t
    LEFT JOIN lookup_table lt ON t.country = lt.country AND lt.province IS NULL
    LEFT JOIN countries c ON lt.iso3 = c.iso3
SET t.country = c.country
WHERE lt.country != c.country
;

# FILL basic data confirmed and tests
INSERT INTO t_vasek_keberdle_projekt_SQL_final (country, date, confirmed, tests_performed)
SELECT DISTINCT c19b.country,
                c19b.date,
                c19b.confirmed,
                MAX(tests_performed) AS tests_performed
FROM tmp_covid19_basic_differences c19b
         LEFT JOIN covid19_tests c19t ON c19b.country = c19t.country AND c19b.date = c19t.date
GROUP BY c19b.country, c19b.date
;

DROP TABLE IF EXISTS tmp_covid19_basic_differences
;
/**
  SLOWLY good way?
  INSERT INTO t_vasek_keberdle_projekt_SQL_final
SELECT DISTINCT c19b.country,
                c19b.date,
                c19b.confirmed,
                MAX(tests_performed) AS tests_performed
FROM covid19_basic_differences c19b
         LEFT JOIN lookup_table lt ON c19b.country = lt.country
         LEFT JOIN countries c ON lt.iso3 = c.iso3
         LEFT JOIN covid19_tests c19t ON c.country = c19t.country AND c19b.date = c19t.date
WHERE lt.province IS NULL
GROUP BY c.country, c19b.date
 */

#population
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD population double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN countries c ON t.country = c.country
SET t.population = c.population
WHERE 1
;


#TIME
##is_weekend

ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD time_is_weekend tinyint(1) NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final
SET time_is_weekend = IF(WEEKDAY(date) > 4, 1, 0)
WHERE 1
;


#season_code
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
WHERE 1
;

#population_density
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD population_density double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN countries c ON t.country = c.country
SET t.population_density = c.population_density
WHERE 1
;

#GDP
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD GDP_per_citizen double NULL
;
UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN (SELECT
                   MAX(year) AS max_year,
                   country
               FROM economies
               WHERE  GDP IS NOT NULL
               GROUP BY country) y ON t.country = y.country
    LEFT JOIN economies c ON t.country = c.country AND y.max_year = c.year
SET t.GDP_per_citizen = c.GDP/c.population
WHERE 1;


#GINI
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD GINI double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
LEFT JOIN (SELECT
     MAX(year) AS max_year,
     country
 FROM economies
 WHERE  gini IS NOT NULL
 GROUP BY country) y ON t.country = y.country
    LEFT JOIN economies c ON t.country = c.country AND y.max_year = c.year
SET t.GINI = c.gini
WHERE 1
;
#mortaliy_under5
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD mortaliy_under5 double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN (SELECT
                   MAX(year) AS max_year,
                   country
               FROM economies
               WHERE  mortaliy_under5 IS NOT NULL
               GROUP BY country) y ON t.country = y.country
    LEFT JOIN economies c ON t.country = c.country AND y.max_year = c.year
SET t.mortaliy_under5 = c.mortaliy_under5
WHERE 1
;

#median_age_2018
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD median_age_2018 double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN countries c ON t.country = c.country
SET t.median_age_2018 = c.median_age_2018
WHERE c.median_age_2018 IS NOT NULL
;

#religions
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD religion_christianity double NULL,
    ADD religion_islam double NULL,
    ADD religion_unaffiliated double NULL,
    ADD religion_hinduism double NULL,
    ADD religion_buddhism double NULL,
    ADD religion_folk double NULL,
    ADD religion_other double NULL,
    ADD religion_judaism double NULL
;
#FIX CZECH/CZECHIA
DROP TABLE IF EXISTS tmp_religions;

CREATE TABLE IF NOT EXISTS tmp_religions AS (SELECT * FROM religions);

UPDATE tmp_religions  t
    LEFT JOIN lookup_table lt ON t.country = lt.country AND lt.province IS NULL
    LEFT JOIN countries c ON lt.iso3 = c.iso3
SET t.country = c.country
WHERE lt.country != c.country
;


UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_christianity =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Christianity'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_islam =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Islam'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_unaffiliated =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Unaffiliated Religions'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_hinduism =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Hinduism'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_buddhism =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Buddhism'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_folk =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Folk Religions'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_other =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Other Religions'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = 2020
SET t.religion_judaism =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Judaism'
;

DROP TABLE IF EXISTS tmp_religions;

#life_expectancy_extend
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD life_expectancy_extend double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN (SELECT y2015.country, ROUND(y2015.life_expectancy - y1965.life_expectancy) AS life_expectancy_extend
               FROM life_expectancy y2015
                        LEFT JOIN life_expectancy y1965 ON y2015.country = y1965.country
               WHERE y1965.year = 1965
                 AND y2015.year = 2015) l ON t.country = l.country
SET t.life_expectancy_extend = l.life_expectancy_extend
WHERE 1
;

#WEATER
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD avg_temp    double NULL,
    ADD rainy_hours double NULL,
    ADD max_gust    double NULL
;
#Avg temp
UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN (
        SELECT c.country,
               DATE(w_six.date)                                          AS date,
               capital_city,
               (w_six.temp + w_fifteen.temp + 2 * w_twenty_one.temp) / 4 AS avg_temp
        FROM countries c
                 LEFT JOIN (SELECT REPLACE(temp, ' °c', '') AS temp, city, date FROM weather WHERE time = '06:00') w_six
                           ON c.capital_city = w_six.city
                 LEFT JOIN (SELECT REPLACE(temp, ' °c', '') AS temp, city, date
                            FROM weather
                            WHERE time = '15:00') w_fifteen ON c.capital_city = w_fifteen.city
                 LEFT JOIN (SELECT REPLACE(temp, ' °c', '') AS temp, city, date
                            FROM weather
                            WHERE time = '21:00') w_twenty_one ON c.capital_city = w_twenty_one.city
        WHERE 1
          AND w_six.date = w_fifteen.date
          AND w_six.date = w_twenty_one.date
        GROUP BY w_six.city, w_six.date) w ON t.country = w.country AND w.date = t.date
SET t.avg_temp = w.avg_temp
WHERE 1
;

#Rainy
UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN (SELECT c.country,
                      DATE(date)                                AS date,
                      capital_city,
                      SUM(IF(rain NOT LIKE '0.0 mm', 1, 0)) * 3 AS rainy_hours
               FROM countries c
                        LEFT JOIN weather w ON c.capital_city = w.city
               WHERE w.city IS NOT NULL
               GROUP BY city, date) w ON t.country = w.country AND w.date = t.date
SET t.rainy_hours = w.rainy_hours
WHERE 1
;

# gust
UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN (SELECT c.country,
                      DATE(date)                                        AS date,
                      capital_city,
                      MAX(CONVERT(REPLACE(gust, ' km/h', ''), INTEGER)) AS max_gust
               FROM countries c
                        LEFT JOIN weather w ON c.capital_city = w.city
               WHERE w.city IS NOT NULL
               GROUP BY city, date) w ON t.country = w.country AND w.date = t.date
SET t.max_gust = w.max_gust
WHERE 1
;

/**
Queries	49
Updated Rows	2280256
Execute time (ms)	125402
Fetch time (ms)	0
Total time (ms)	125402
Finish time	2021-12-19 17:01:40.113
*/
