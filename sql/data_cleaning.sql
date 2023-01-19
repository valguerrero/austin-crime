-- Inspecting available data
SELECT *
FROM austin_crime.crime_reports
LIMIT 20;

-- Number of records
SELECT
	COUNT(*) AS records_count
FROM
	austin_crime.crime_reports;

-- Verifying incident number values are unique
SELECT
	COUNT(*) AS records_count,
	COUNT(DISTINCT `Incident Number`) AS unique_incident_count
FROM
	austin_crime.crime_reports;

/*---------------------------
Removing irrelevant columns
---------------------------*/

DROP TABLE IF EXISTS crime;
CREATE TEMPORARY TABLE crime AS
SELECT
	`Incident Number` AS incident_id,
	`Highest Offense Description` AS crime_description,
	`Highest Offense Code` AS crime_code,
	`Occurred Date Time` AS occured_date_time,
	`Report Date Time` AS report_date_time,
	`Location Type` AS location_type,
	Address AS address,
	`Zip Code` AS zip_code,
	Latitude AS latitude,
	Longitude AS longitude
FROM
	austin_crime.crime_reports;

SELECT * 
FROM austin_crime.crime 
LIMIT 20;

/*------------------------------------------
Examining crime types to ensure uniqueness
------------------------------------------*/

-- Examining unique values for crime_description
SELECT
	crime_description,
	COUNT(crime_description) AS frequency,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM
	austin_crime.crime
GROUP BY
	crime_description
ORDER BY
	frequency DESC; -- 429 unique values


-- Examining unique values for crime_code
SELECT
	crime_code,
	COUNT(DISTINCT crime_code) AS record_counts
FROM
	austin_crime.crime
GROUP BY
	crime_code
ORDER BY
	crime_code; -- 390 unique values

-- Matching crime_code to crime_description
SELECT DISTINCT
	crime_code,
	crime_description
FROM
	austin_crime.crime
ORDER BY
	crime_code;

-- Ignorning duplicate crime_code values as we will be only working 
-- with the crime_description for the visualization

/*------------------------------------------
Standardizing crime_description values for
readability in final visualization
------------------------------------------*/

SELECT DISTINCT
	crime_description
FROM
	austin_crime.crime
ORDER BY
	crime_description;

-- Removing expired crime_description values
DELETE FROM austin_crime.crime WHERE crime_description LIKE '%EXPIRED%'; -- 649 rows

SELECT crime_description, COUNT(*)
FROM austin_crime.crime
GROUP BY crime_description;