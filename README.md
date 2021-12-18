# SQL
Project for course data analytics

## links
* [Zadání](https://learn.engeto.com/cs/kurz/cviceni-pro-datovou-akademii/studium/DbO2pMl8SIykg9ucGXCxdA/projekty/sql)
* [mid map](https://orgpad.com/s/96eLznMNsrF)


## TODO
* CREATE NEW TABLE - t_vasek_keberdle_projekt_SQL_final
  * keys: country, date
* main variables:(@NOTE: nejsou v zadání imlicitně vyžadována) 
  * počty nakažených
  * počty provedených testů
  * počet obyvatel daného státu ( pozor kde jsou ty provincie!)
* add other variables

## HOW TO DO

* find best table as source of variable
* write finded data for control 
* create column with same datatype
* insert values 
  * by [INSERT  - SELECT] (https://mariadb.com/kb/en/insert-select/) to my table
  * by *UPDATE t_vasek_keberdle_projekt_SQL_final tvkpSf LEFT JOIN*
* check for empty values and compare with handy search in table for control 


## GOAL
Výstupem by měla být tabulka na databázi, ze které se požadovaná data dají získat jedním selectem. Tabulku pojmenujte **t_{jméno}_{příjmení}_projekt_SQL_final**


## Description
#### tests_performed
Source table covid19_tests
Problems bellow is about 1% of data and only for some countries. So it no depend too much on solutions.
Problems:
 
**1, Bahrain has only enitity = "unit unclear"** 
Solution: Use it as number of test - is used now.

**2, There is multiple rows for one day and country:**

"people tested,tests performed (incl. non-PCR)"
"people tested,samples tested"
"people tested,tests performed"
"people tested (incl. non-PCR),tests performed"
"tests performed,units unclear (incl. non-PCR)"

Solution: 
* let it be - because it is only for 1% of days, countries other countries do not have this data?! 
* change test_performed by entity = "people tested"
* change test_performed by entity = "people tested (incl. non-PCR"
* substract amount of "units unclear (incl. non-PCR)" 

### confirmed

FROM table covid19_basic_differences

### population
FROM table countries

### time_is_weekday
If Saturday, Sunday time_is_weekday = 1 else 0.

### time_season_code
Used by meteorologic seasons [Meteorologické jaro začíná 1. března a končí 31. května](https://cs.wikipedia.org/wiki/Ro%C4%8Dn%C3%AD_obdob%C3%AD)

### populatio_density
From table countries

### GDP
From table economies by country and year of date

### GINI
From table economies by country and year of date


