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

ALTER TABLE t_vasek_keberdle_projekt_SQL_final ADD time_is_weekend tinyint(1) NULL;

UPDATE t_vasek_keberdle_projekt_SQL_final
SET time_is_weekend = IF(WEEKDAY(date) > 4, 1, 0)
WHERE 1
;
