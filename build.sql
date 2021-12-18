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

#basic diferences table use Czechia and test !!
## FIX Czechia / Czech republic

ALTER TABLE `t_vasek_keberdle_projekt_SQL_final`
    ADD PRIMARY KEY `date_country` (`date`, `country`(32));

CREATE TABLE tmp_covid19_basic_differences LIKE covid19_basic_differences;
INSERT INTO tmp_covid19_basic_differences SELECT * FROM covid19_basic_differences;

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
    ADD GDP double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN economies c ON t.country = c.country AND YEAR(t.date) = c.year
SET t.GDP = c.GDP/c.population
WHERE 1
;


#GINI
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD GINI double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN economies c ON t.country = c.country AND YEAR(t.date) = c.year
SET t.GINI = c.GINI
WHERE 1
;


#mortaliy_under5
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD mortaliy_under5 double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN economies c ON t.country = c.country AND YEAR(t.date) = c.year
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
CREATE TABLE tmp_religions LIKE religions;
INSERT INTO tmp_religions SELECT * FROM religions;

UPDATE tmp_religions  t
    LEFT JOIN lookup_table lt ON t.country = lt.country AND lt.province IS NULL
    LEFT JOIN countries c ON lt.iso3 = c.iso3
SET t.country = c.country
WHERE lt.country != c.country
;


UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_christianity =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Christianity'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_islam =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Islam'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_unaffiliated =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Unaffiliated Religions'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_hinduism =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Hinduism'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_buddhism =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Buddhism'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_folk =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Folk Religions'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_other =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Other Religions'
;

UPDATE t_vasek_keberdle_projekt_SQL_final t
    LEFT JOIN tmp_religions r ON t.country = r.country AND year = YEAR(date)
SET t.religion_judaism =  ROUND(100*r.population/t.population, 2)
WHERE religion = 'Judaism'
;

DROP TABLE IF EXISTS tmp_religions;
