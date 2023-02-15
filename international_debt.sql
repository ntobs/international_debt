--info on the table
SELECT *
FROM international_debt
LIMIT 10;



--number of countries
SELECT COUNT(DISTINCT country_name)
	AS num_countries
FROM international_debt;



--number of debt indicators
SELECT COUNT(DISTINCT indicator_code)
	AS num_debt_types
FROM international_debt;



--common debt between countries
SELECT indicator_name,
	COUNT(indicator_code) 
		AS common_debt,
	SUM(debt) 
		AS total
FROM international_debt
WHERE indicator_code IS NOT NULL
GROUP BY indicator_name	
ORDER BY common_debt DESC, 
		total DESC;


		
--highest debt across indicators
SELECT indicator_name,
	MAX(debt) 
		AS max_indicator
FROM international_debt
GROUP BY indicator_name		
ORDER BY max_indicator DESC;



--lowest principal repayments
SELECT country_name,
	indicator_name,
	SUM(debt)
		AS principal_repay
FROM international_debt
WHERE indicator_name 
		LIKE '%Principal%'
GROUP BY country_name,
	indicator_name,
	debt
ORDER BY principal_repay;



--highest interest payments
SELECT country_name,
	indicator_name,
	SUM(debt)
		AS interest
FROM international_debt
WHERE indicator_name 
		LIKE '%Interest%'
GROUP BY country_name,
	indicator_name,
	debt
ORDER BY interest DESC;


	
--countries with debt above average
SELECT country_name,
	SUM(debt)
		AS total_debt
FROM international_debt
GROUP BY country_name
HAVING SUM(debt) > 
(SELECT AVG(debt)
 FROM international_debt)
ORDER BY total_debt DESC;

