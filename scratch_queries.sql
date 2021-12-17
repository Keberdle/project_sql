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
WHERE c19b.date IS NULL ;

