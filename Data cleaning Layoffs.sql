SELECT *
FROM layoffs_staging;


-- Remove Duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Company, Location_HQ, Industry, Laid_Off_Count, Percentage, 'Date', 'Source', Funds_Raised, Stage, Country, Date_Added) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

-- No Duplicates in the given table
-- if any, check how to remove duplicate
-- Use Delete to remove duplicates with the condition where row_num > 1

-- Standardizing Data

SELECT company, TRIM(Company)
FROM layoffs_staging;

UPDATE layoffs_staging
SET Company = TRIM(Company);

SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY 1;

-- If are any industry are in same field with different names,
-- we can update using 
-- UPDATE layoffs_staging
-- SET industry = 'Crypto'
-- WHERE industry LIKE 'Crypto%';
-- This updates the table with Cryptocurrency into crypto for 
-- better exploratory data analysis 
-- This should be done for every coloum by checking every column 

-- For exploratory data analysis, we need date in date format
-- SELECT 'Date',
-- STR_TO_DATE('Date', '%m/%d/%Y')
-- FROM layoffs_staging;
-- UPDATE layoffs_staging
-- SET 'Date' = STR_TO_DATE('Date', '%m/%d/%Y')

ALTER TABLE layoffs_staging
MODIFY COLUMN `Date` DATE;

-- NULL Values
SELECT *
FROM layoffs_staging
WHERE Laid_Off_Count IS NULL
AND Percentage IS NULL;

SELECT DISTINCT Industry
FROM layoffs_staging
WHERE Industry IS NULL
OR Industry = '';

-- To populate those nulls if possible
-- SELECT t1.industry, t2.industry
-- FROM layoffs_staging AS t1
-- JOIN layoffs_staging AS t2
-- 		ON t1.Company = t2.Company
-- WHERE (t1.industry IS NULL OR t1.industry = '')
-- AND t2.industry IS NOT NULL;

-- Update the table to remove null and populate
-- UPDATE layoffs_staging AS t1
-- JOIN layoffs_staging AS t2
-- 		ON t1.Company = t2.Company
-- SET t1.industry = t2.industry
-- WHERE (t1.industry IS NULL OR t1.industry = '')
-- AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging
WHERE Laid_Off_Count IS NULL
AND Percentage IS NULL;

-- If there are any with null, 
-- DELETE 
-- FROM layoffs_staging
-- WHERE Laid_Off_Count IS NULL
-- AND Percentage IS NULL;

SELECT *
FROM layoffs_staging;

ALTER TABLE layoffs_staging
DROP COLUMN row_num;





