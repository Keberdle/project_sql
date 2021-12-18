-- Adminer 4.8.1 MySQL 5.5.5-10.4.17-MariaDB-1:10.4.17+maria~focal-log dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE TABLE `address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `street` varchar(255) DEFAULT NULL,
  `street_number` int(11) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip_code` varchar(6) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `attendees` (
  `name` text DEFAULT NULL,
  `profession` text DEFAULT NULL,
  `employment` text DEFAULT NULL,
  `motivation` text DEFAULT NULL,
  `tableau_link` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `start_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `cities` (
  `city` text DEFAULT NULL,
  `city_ascii` text DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `country` text DEFAULT NULL,
  `iso2` text DEFAULT NULL,
  `iso3` text DEFAULT NULL,
  `admin_name` text DEFAULT NULL,
  `capital` text DEFAULT NULL,
  `population` double DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `companies` (
  `company` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `open` double DEFAULT NULL,
  `close` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `adj_close` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `content` (
  `lekce` int(11) DEFAULT NULL,
  `tema` text DEFAULT NULL,
  `content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `countries` (
  `country` text DEFAULT NULL,
  `abbreviation` text DEFAULT NULL,
  `avg_height` double DEFAULT NULL,
  `calling_code` double DEFAULT NULL,
  `capital_city` text DEFAULT NULL,
  `continent` text DEFAULT NULL,
  `currency_name` text DEFAULT NULL,
  `religion` text DEFAULT NULL,
  `currency_code` text DEFAULT NULL,
  `domain_tld` text DEFAULT NULL,
  `elevation` double DEFAULT NULL,
  `north` double DEFAULT NULL,
  `south` double DEFAULT NULL,
  `west` double DEFAULT NULL,
  `east` double DEFAULT NULL,
  `government_type` text DEFAULT NULL,
  `independence_date` double DEFAULT NULL,
  `iso_numeric` double DEFAULT NULL,
  `landlocked` double DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL,
  `national_symbol` text DEFAULT NULL,
  `national_dish` text DEFAULT NULL,
  `population_density` double DEFAULT NULL,
  `population` double DEFAULT NULL,
  `region_in_world` text DEFAULT NULL,
  `surface_area` double DEFAULT NULL,
  `yearly_average_temperature` double DEFAULT NULL,
  `median_age_2018` double DEFAULT NULL,
  `iso2` text DEFAULT NULL,
  `iso3` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `countries_to_finale_gdp_gini_mor` (
  `Date` date DEFAULT NULL,
  `Country` text DEFAULT NULL,
  `Confirmed` double DEFAULT NULL,
  `Covid_Tests` double DEFAULT NULL,
  `Population` double DEFAULT NULL,
  `seasons` bigint(20) DEFAULT NULL,
  `week` bigint(20) DEFAULT NULL,
  `population_density` double DEFAULT NULL,
  `GDP_per_person` double DEFAULT NULL,
  `gini_coef` double DEFAULT NULL,
  `children_mortality` double DEFAULT NULL,
  `med_age_2018` double DEFAULT NULL,
  `christianity` double DEFAULT NULL,
  `islam` double DEFAULT NULL,
  `Hinduism` double DEFAULT NULL,
  `Judaism` double DEFAULT NULL,
  `life_expectancy_diff` double DEFAULT NULL,
  `avg_temperature` double DEFAULT NULL,
  `number_of_raining_hours` bigint(20) DEFAULT NULL,
  `max_wind` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `country_codes` (
  `index` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `iso3` text DEFAULT NULL,
  `iso2` text DEFAULT NULL,
  KEY `ix_country_codes_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `country_religion_share` (
  `country` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `country_rel_share` (
  `country` text DEFAULT NULL,
  `rel_share` decimal(20,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_basic` (
  `date` date DEFAULT NULL,
  `country` text DEFAULT NULL,
  `confirmed` bigint(20) DEFAULT NULL,
  `deaths` bigint(20) DEFAULT NULL,
  `recovered` bigint(20) DEFAULT NULL,
  KEY `ix_covid19_basic_date` (`date`),
  KEY `ix_covid19_basic_country` (`country`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_basic_differences` (
  `date` date DEFAULT NULL,
  `country` text DEFAULT NULL,
  `confirmed` double DEFAULT NULL,
  `deaths` double DEFAULT NULL,
  `recovered` double DEFAULT NULL,
  KEY `ix_covid19_basic_differences_date` (`date`),
  KEY `ix_covid19_basic_differences_country` (`country`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_detail_global` (
  `date` date DEFAULT NULL,
  `country` text DEFAULT NULL,
  `province` text DEFAULT NULL,
  `confirmed` double DEFAULT NULL,
  `deaths` double DEFAULT NULL,
  `recovered` double DEFAULT NULL,
  KEY `ix_covid19_detail_global_country` (`country`(768)),
  KEY `ix_covid19_detail_global_date` (`date`),
  KEY `ix_covid19_detail_global_province` (`province`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_detail_global_differences` (
  `date` date DEFAULT NULL,
  `country` text DEFAULT NULL,
  `province` text DEFAULT NULL,
  `confirmed` double DEFAULT NULL,
  `deaths` double DEFAULT NULL,
  `recovered` double DEFAULT NULL,
  KEY `ix_covid19_detail_global_differences_date` (`date`),
  KEY `ix_covid19_detail_global_differences_country` (`country`(768)),
  KEY `ix_covid19_detail_global_differences_province` (`province`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_detail_us` (
  `date` date DEFAULT NULL,
  `country` text DEFAULT NULL,
  `province` text DEFAULT NULL,
  `admin2` text DEFAULT NULL,
  `confirmed` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `recovered` int(11) DEFAULT NULL,
  KEY `ix_covid19_detail_us_date` (`date`),
  KEY `ix_covid19_detail_us_country` (`country`(768)),
  KEY `ix_covid19_detail_us_province` (`province`(768)),
  KEY `ix_covid19_detail_us_admin2` (`admin2`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_detail_us_differences` (
  `date` date DEFAULT NULL,
  `country` text DEFAULT NULL,
  `province` text DEFAULT NULL,
  `admin2` text DEFAULT NULL,
  `confirmed` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `recovered` int(11) DEFAULT NULL,
  KEY `ix_covid19_detail_us_differences_date` (`date`),
  KEY `ix_covid19_detail_us_differences_country` (`country`(768)),
  KEY `ix_covid19_detail_us_differences_admin2` (`admin2`(768)),
  KEY `ix_covid19_detail_us_differences_province` (`province`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `covid19_tests` (
  `country` text DEFAULT NULL,
  `entity` text DEFAULT NULL,
  `date` text DEFAULT NULL,
  `ISO` text DEFAULT NULL,
  `cumulative` double DEFAULT NULL,
  `tests_performed` double DEFAULT NULL,
  KEY `country` (`country`(768)),
  KEY `date` (`date`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `gender2` enum('male','female') DEFAULT 'male',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `demographics` (
  `index` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `year` text DEFAULT NULL,
  `fertility` double DEFAULT NULL,
  `death_rate_per_thousand` double DEFAULT NULL,
  `birth_rate_per_thousand` double DEFAULT NULL,
  `mortaliy_under5` double DEFAULT NULL,
  `population` double DEFAULT NULL,
  KEY `ix_demographics_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `doctor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `economies` (
  `country` text DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `GDP` double DEFAULT NULL,
  `population` double DEFAULT NULL,
  `gini` double DEFAULT NULL,
  `taxes` double DEFAULT NULL,
  `fertility` double DEFAULT NULL,
  `mortaliy_under5` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `edinburgh_bikes` (
  `index` bigint(20) DEFAULT NULL,
  `started_at` text DEFAULT NULL,
  `ended_at` text DEFAULT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `start_station_id` bigint(20) DEFAULT NULL,
  `start_station_name` text DEFAULT NULL,
  `start_station_description` text DEFAULT NULL,
  `start_station_latitude` double DEFAULT NULL,
  `start_station_longitude` double DEFAULT NULL,
  `end_station_id` bigint(20) DEFAULT NULL,
  `end_station_name` text DEFAULT NULL,
  `end_station_description` text DEFAULT NULL,
  `end_station_latitude` double DEFAULT NULL,
  `end_station_longitude` double DEFAULT NULL,
  KEY `ix_edinburgh_bikes_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `edinburgh_weather` (
  `time` text DEFAULT NULL,
  `temp` text DEFAULT NULL,
  `feels` text DEFAULT NULL,
  `wind` text DEFAULT NULL,
  `gust` text DEFAULT NULL,
  `rain` text DEFAULT NULL,
  `humidity` text DEFAULT NULL,
  `cloud` text DEFAULT NULL,
  `pressure` text DEFAULT NULL,
  `vis` text DEFAULT NULL,
  `date` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `life_expectancy` (
  `index` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `iso3` text DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `life_expectyncy_diff` (
  `country` text DEFAULT NULL,
  `life_expectancy_diff` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `list_of_medicaments` (
  `prescription_id` int(11) DEFAULT NULL,
  `medicament_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `london_living` (
  `Area` text DEFAULT NULL,
  `Rent_per_m` double DEFAULT NULL,
  `green_spec` double DEFAULT NULL,
  `travel` double DEFAULT NULL,
  `safety` double DEFAULT NULL,
  `schools` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `london_living_missing` (
  `Area` text DEFAULT NULL,
  `Rent_per_m` double DEFAULT NULL,
  `green_spec` double DEFAULT NULL,
  `travel` double DEFAULT NULL,
  `safety` double DEFAULT NULL,
  `schools` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `lookup_table` (
  `country` text DEFAULT NULL,
  `province` text DEFAULT NULL,
  `UID` bigint(20) DEFAULT NULL,
  `iso2` text DEFAULT NULL,
  `iso3` text DEFAULT NULL,
  `code3` double DEFAULT NULL,
  `FIPS` double DEFAULT NULL,
  `admin2` text DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `long` double DEFAULT NULL,
  `combine_key` text DEFAULT NULL,
  `population` double DEFAULT NULL,
  KEY `ix_lookup_table_province` (`province`(768)),
  KEY `ix_lookup_table_country` (`country`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `marketing_data` (
  `ID` varchar(1024) DEFAULT NULL,
  `Revenue` varchar(1024) DEFAULT NULL,
  `Date` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `median_age` (
  `abbreviation` text DEFAULT NULL,
  `avg_height` double DEFAULT NULL,
  `calling_code` double DEFAULT NULL,
  `capital_city` text DEFAULT NULL,
  `continent` text DEFAULT NULL,
  `currency_name` text DEFAULT NULL,
  `religion` text DEFAULT NULL,
  `currency_code` text DEFAULT NULL,
  `domain_tld` text DEFAULT NULL,
  `elevation` double DEFAULT NULL,
  `north` double DEFAULT NULL,
  `south` double DEFAULT NULL,
  `west` double DEFAULT NULL,
  `east` double DEFAULT NULL,
  `government_type` text DEFAULT NULL,
  `independence_date` double DEFAULT NULL,
  `iso_numeric` double DEFAULT NULL,
  `landlocked` double DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL,
  `national_symbol` text DEFAULT NULL,
  `national_dish` text DEFAULT NULL,
  `population_density` double DEFAULT NULL,
  `population` double DEFAULT NULL,
  `region_in_world` text DEFAULT NULL,
  `surface_area` double DEFAULT NULL,
  `yearly_average_temperature` double DEFAULT NULL,
  `median_age_2018` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `medicament` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price_insurance` float DEFAULT NULL,
  `price_patient` float DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `patient` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `insurance_company` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `popis_tabulek` (
  `moje_jmeno` text DEFAULT NULL,
  `tabulka` text DEFAULT NULL,
  `popis` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `pop_religion_per_country` (
  `year` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `religion` text DEFAULT NULL,
  `share_pop_per_country` double(19,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `prescription` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `is_released` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `religions` (
  `year` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `region` text DEFAULT NULL,
  `religion` text DEFAULT NULL,
  `population` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `seasons` (
  `date` text DEFAULT NULL,
  `month_day` int(2) DEFAULT NULL,
  `day_date` int(2) DEFAULT NULL,
  `seasons` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `t_vasek_keberdle_projekt_SQL_final` (
  `country` text NOT NULL,
  `date` date NOT NULL,
  `tests_performed` double DEFAULT NULL,
  `confirmed` double DEFAULT NULL,
  `population` double DEFAULT NULL,
  `time_is_weekend` tinyint(1) DEFAULT NULL,
  `time_season_code` tinyint(1) DEFAULT NULL,
  `population_density` double DEFAULT NULL,
  KEY `date` (`date`),
  KEY `country` (`country`(1024))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `weather` (
  `index` bigint(20) DEFAULT NULL,
  `time` text DEFAULT NULL,
  `temp` text DEFAULT NULL,
  `feels` text DEFAULT NULL,
  `wind` text DEFAULT NULL,
  `gust` text DEFAULT NULL,
  `rain` text DEFAULT NULL,
  `humidity` text DEFAULT NULL,
  `cloud` text DEFAULT NULL,
  `pressure` text DEFAULT NULL,
  `vis` text DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `city` text DEFAULT NULL,
  KEY `ix_weather_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2021-12-18 16:02:04
