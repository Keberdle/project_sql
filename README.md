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
