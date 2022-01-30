#confirmed
SELECT * FROM covid19_basic_differences
WHERE country = 'Czechia'
AND date = '2020-01-28';

##tests_performed
SELECT * FROM covid19_tests
WHERE country = 'Czech Republic'
  AND date = '2020-01-28';

## population
SELECT country, population FROM countries WHERE country = 'Czech Republic';
SELECT DISTINCT population FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;

## weekend
SELECT DISTINCT date, time_is_weekend FROM t_vasek_keberdle_projekt_SQL_final WHERE date > '2020-12-20' AND date < '2020-12-28'

#season_code
#checked handy

#population_density
SELECT country, population_density FROM countries WHERE country = 'Czech Republic';
SELECT DISTINCT population_density FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;

#GDP_per_citizen
SELECT country, GDP, year FROM economies WHERE country = 'Czech Republic';
SELECT DISTINCT GDP_per_citizen, year(date) FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;
SELECT count(1) FROM t_vasek_keberdle_projekt_SQL_final WHERE GDP_per_citizen IS NULL;

#GINI
SELECT country, gini, year FROM economies WHERE country = 'Czech Republic';
SELECT DISTINCT GINI, year(date) FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;
SELECT count(1) FROM t_vasek_keberdle_projekt_SQL_final WHERE t_vasek_keberdle_projekt_SQL_final.GINI IS NULL;
#

#mortaliy_under5
SELECT country, mortaliy_under5, year FROM economies WHERE country = 'Czech Republic';
SELECT DISTINCT mortaliy_under5, year(date) FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;
SELECT count(1) FROM t_vasek_keberdle_projekt_SQL_final WHERE mortaliy_under5 IS NULL;
#

#median_age_2018

SELECT country, median_age_2018 FROM countries WHERE country = 'Czech Republic';
SELECT DISTINCT median_age_2018, year(date) FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;
SELECT count(1) FROM t_vasek_keberdle_projekt_SQL_final WHERE median_age_2018 IS NULL;

#religions

SELECT DISTINCT year FROM religions WHERE 1;

SELECT DISTINCT median_age_2018, year(date) FROM t_vasek_keberdle_projekt_SQL_final WHERE country = 'Czech Republic' ;
SELECT count(1) FROM t_vasek_keberdle_projekt_SQL_final WHERE median_age_2018 IS NULL;

## Countries like Taiwan*
SELECT DISTINCT country, sum(confirmed) FROM t_vasek_keberdle_projekt_SQL_final WHERE population IS NULL GROUP BY country;
