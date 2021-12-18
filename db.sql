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

CREATE TABLE `country_codes` (
  `index` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `iso3` text DEFAULT NULL,
  `iso2` text DEFAULT NULL,
  KEY `ix_country_codes_index` (`index`)
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

CREATE TABLE `life_expectancy` (
  `index` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `iso3` text DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL
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



CREATE TABLE `pop_religion_per_country` (
  `year` bigint(20) DEFAULT NULL,
  `country` text DEFAULT NULL,
  `religion` text DEFAULT NULL,
  `share_pop_per_country` double(19,2) DEFAULT NULL
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
