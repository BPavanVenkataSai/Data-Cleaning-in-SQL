-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging;

SELECT Laid_Off_Count
FROM layoffs_staging
WHERE Laid_Off_Count = NULL;

UPDATE layoffs_staging
SET Laid_Off_Count = NULL
WHERE Laid_Off_Count = '';

ALTER TABLE layoffs_staging
MODIFY Laid_Off_Count INT;

SELECT MAX(Laid_Off_Count), MAX(Percentage)
FROM layoffs_staging;

SELECT *
FROM layoffs_staging
WHERE Percentage = 1
ORDER BY Laid_Off_Count DESC;

SELECT Company, SUM(Laid_Off_Count)
FROM layoffs_staging
GROUP BY Company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging;

SELECT Industry, SUM(Laid_Off_Count)
FROM layoffs_staging
GROUP BY Industry
ORDER BY 2 DESC;

SELECT Country, SUM(Laid_Off_Count)
FROM layoffs_staging
GROUP BY Country
ORDER BY 2 DESC;

SELECT Company, YEAR(`date`), SUM(Laid_Off_Count)
FROM layoffs_staging
GROUP BY Company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT Company, YEAR(`date`), SUM(Laid_Off_Count)
FROM layoffs_staging
GROUP BY Company, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT * ,
DENSE_RANK() OVER( PARTITION BY years
	ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)

SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5;









