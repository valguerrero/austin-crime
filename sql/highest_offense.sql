-- Inspecting available data
SELECT *
FROM austin_crime.crime_reports
LIMIT 20;

-- Number of records
SELECT
	COUNT(*) AS records_count
FROM
	austin_crime.crime_reports;

-- Taking a subset of the data using highest offense description and code 
DROP TABLE IF EXISTS highest_offense;
CREATE TEMPORARY TABLE highest_offense AS
SELECT
	`Incident Number` AS incident_number,
	`Highest Offense Description` AS description,
	`Highest Offense Code` AS offense_code
FROM
	austin_crime.crime_reports;

-- Examining unique values for highest offense description and code
SELECT
	description,
	COUNT(*) AS frequency,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM
	austin_crime.highest_offense
GROUP BY
	description
ORDER BY
	frequency DESC;

SELECT
	offense_code,
	COUNT(*) AS frequency
FROM 
	austin_crime.highest_offense
GROUP BY
	code
ORDER BY
	frequency DESC;

SELECT
	description,
	offense_code,
	COUNT(*) AS frequency,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM
	austin_crime.highest_offense
GROUP BY
	description,
	offense_code
ORDER BY
	frequency DESC;

-- Checking for nulls for highest offense description and code
-- Identifying and managing duplicates

SELECT DISTINCT
	description,
	offense_code
FROM
	austin_crime.highest_offense
ORDER BY
	offense_code;

SELECT
	description,
	offense_code,
	COUNT(*)
FROM
	austin_crime.highest_offense
GROUP BY
	description,
	offense_code
HAVING
	COUNT(*) > 1;