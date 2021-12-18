SET @country = 'Czech Republic';
SET @country_alias = 'Czechia';
SET @date = '2020-02-22';

SELECT * FROM covid19_basic_differences
WHERE country = 'Czechia'
AND date = '2020-01-28';

SELECT * FROM covid19_tests
WHERE country = 'Czech Republic'
  AND date = '2020-01-28';
