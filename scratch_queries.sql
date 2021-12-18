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
WHERE country LIKE 'BAhrain'
#TODO jaká data o testování tedy načíst nebo donačíst / odečíst
#nejprve zjistit zda "units unclear" jsou opravdu data opravná viz Bahrain má pouze "unit unclear"
#zmenit na pocty kde je people tested ?
#zmenit pocty kde je entity = people tested (incl. non-PCR?
#odecist units unclear (incl. non-PCR)?
