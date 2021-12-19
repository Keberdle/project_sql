# SQL
Project for Engeto course Data analytics

## Links
* [Zadání](https://learn.engeto.com/cs/kurz/cviceni-pro-datovou-akademii/studium/DbO2pMl8SIykg9ucGXCxdA/projekty/sql)
* [mid map](https://orgpad.com/s/96eLznMNsrF)

## Variables to extend
* Holidays - people change behavior on holidays - shops closed etc.
* Sunny days by no clouds from weather table - clouds hide Sun - Sun kills covid by drying and UV light 
* region_in_world - in asia people wearing face mask many years ago daily.
* humidity - virus long live in air if humidity is high.


## TODO
* check country "Taiwan*" 
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
ISSUEs:
 
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
Can be used easily from TABLE seasons but this table was not mentioned in the assignment.

### populatio_density
From table countries

### GDP per citizen
From table economies by country and year of date.
**ISSUE: we have no GDP information for 2021**
Fixed by using last max(year) with not null data

### GINI
From table economies by country and year of date.
**ISSUE: we have no GINI information for this years**
Fixed by using last max(year) with not null data

### Children mortality - mortaliy_under5
Form table economies by country and year of date column mortaliy_under5
**ISSUE: we have no information for year > 2019**
Fixed by using last max(year) with not null data

### median_age_2018
From table countries

### religions
From table religions by year and country
Used for year 2020 ( it was only for years 2010,2020,2030,2040,2050)

### life_expectancy_extend
Life expectancy in 2015 - life expectancy in 1695 from table life_expectancy

## Weather
By capital city
Only ~12% data has weather information

### Avg daily teperature
counted as (7 + 14 + 2*21)/4
https://www.meteosvatonovice.cz/obecne-informace/metodika-mereni/

I have temp in 3,6,9,12,15,18,21,0 hour in day 
Best will be count temp in 7 by weighted arithmetic mean (2x6 + 9)/3

## Rainy hours
Because table weater contains data only per 3 hour we must multipli hours by 3

## gust
MAX gust by day and country (capital  city)
