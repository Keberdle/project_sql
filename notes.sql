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


