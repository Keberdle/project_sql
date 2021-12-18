# CREATE TABLE
DROP TABLE IF EXISTS t_vasek_keberdle_projekt_SQL_final
;

CREATE TABLE t_vasek_keberdle_projekt_SQL_final (
    country         text   NOT NULL,
    date            date   NOT NULL,
    tests_performed double NULL,
    confirmed       double NULL
)
;

ALTER TABLE `t_vasek_keberdle_projekt_SQL_final`
    ADD INDEX `date` (`date`)
;

ALTER TABLE `t_vasek_keberdle_projekt_SQL_final`
    ADD INDEX `country` (`country`)
;

# FILL basic data confirmed and tests
INSERT INTO t_vasek_keberdle_projekt_SQL_final
SELECT DISTINCT c19b.country,
                c19b.date,
                c19b.confirmed,
                MAX(tests_performed) AS tests_performed
FROM covid19_basic_differences c19b
         LEFT JOIN covid19_tests c19t ON c19b.country = c19t.country AND c19b.date = c19t.date
GROUP BY c19b.country, c19b.date
;

#[2021-12-17 22:58:07] 93,136 rows affected in 20 s 467 ms

#population
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD population double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
    LEFT JOIN countries c ON tvkpSf.country = c.country
SET tvkpSf.population = c.population
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

UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
    LEFT JOIN countries c ON tvkpSf.country = c.country
SET tvkpSf.population_density = c.population_density
WHERE 1
;

#GDP
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD GDP double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
    LEFT JOIN economies c ON tvkpSf.country = c.country AND YEAR(tvkpSf.date) = c.year
SET tvkpSf.GDP = c.GDP
WHERE 1
;


#GINI
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD GINI double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
    LEFT JOIN economies c ON tvkpSf.country = c.country AND YEAR(tvkpSf.date) = c.year
SET tvkpSf.GINI = c.GINI
WHERE 1
;


#mortaliy_under5
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD mortaliy_under5 double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
    LEFT JOIN economies c ON tvkpSf.country = c.country AND YEAR(tvkpSf.date) = c.year
SET tvkpSf.mortaliy_under5 = c.mortaliy_under5
WHERE 1
;

#median_age_2018
ALTER TABLE t_vasek_keberdle_projekt_SQL_final
    ADD median_age_2018 double NULL
;

UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf
    LEFT JOIN countries c ON tvkpSf.country = c.country
SET tvkpSf.median_age_2018 = c.median_age_2018
WHERE c.median_age_2018 IS NOT NULL
;
