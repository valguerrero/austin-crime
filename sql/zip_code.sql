SELECT
	`Highest Offense Description`,
	`Highest Offense Code`,
	COUNT(`Highest Offense Code`) AS frequency,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM
	austin_crime.crime_reports
GROUP BY
	2,
	1
ORDER BY
	3 DESC;

SELECT
	`Location Type`,
	`Address`,
	`Council District`,
	`APD District`,
	`Latitude`,
	`Longitude`,
	 COUNT(*)
FROM
	austin_crime.crime_reports
WHERE
	`Zip Code` = ''
	OR `Zip Code` = 0
GROUP BY
	1, 2, 3, 4, 5, 6
ORDER BY
	7 DESC;

SELECT 
	`Zip Code`,
	`Latitude`,
	`Longitude`,
	COUNT(*)
FROM austin_crime.crime_reports
WHERE `Latitude` = 30.2309895 AND `Longitude` = -97.70564444
GROUP BY 1, 2, 3;

-- Total amount of crimes by zip code (nulls removed)
SELECT
	`Highest Offense Description`,
	`Highest Offense Code`,
	`Zip Code`,
	COUNT(*) AS frequency
FROM
	austin_crime.crime_reports
WHERE
	`Zip Code` != ''
	OR `Zip Code` != 0
GROUP BY
	1,
	2,
	3
ORDER BY
	4 DESC;