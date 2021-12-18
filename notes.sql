#SOURCES

# FIND best source of basic data
SELECT count(DISTINCT country) FROM countries;
SELECT * FROM economies;
SELECT * FROM life_expectancy;
SELECT * FROM religions;
SELECT * FROM covid19_basic_differences;
# SELECT * FROM covid19_testing; NOT EXIST!!
SELECT count(DISTINCT country), min(date), max(date) FROM covid19_tests;
SELECT count(DISTINCT country), min(date), max(date) FROM covid19_basic_differences;

SELECT count(DISTINCT city), min(date), max(date) FROM weather;
SELECT * FROM lookup_table;

### Czech / Chzechia problem
SELECT * FROM countries WHERE country LIKE 'Czech%'; # CR
SELECT * FROM economies WHERE country LIKE 'Czech%'; # CR
SELECT * FROM life_expectancy WHERE country LIKE 'Czech%'; # CR
SELECT * FROM religions WHERE country LIKE 'Czech%'; # CR
SELECT * FROM covid19_basic_differences WHERE country LIKE 'Czech%'; # Czechia
# SELECT * FROM covid19_testing WHERE country LIKE 'Czech%; NOT EXIST!!
SELECT * FROM covid19_tests WHERE country LIKE 'Czech%'; # CR

SELECT * FROM weather WHERE country LIKE 'Czech%';
SELECT * FROM lookup_table WHERE country LIKE 'Czech%'; # Czechia

SELECT * FROM cities WHERE country LIKE 'Czech%'; # Czechia has iso3

SELECT *
FROM covid19_basic_differences cbd
LEFT JOIN lookup_table lt ON cbd.country = lt.country
LEFT JOIN countries c ON lt.iso3 = c.iso3
