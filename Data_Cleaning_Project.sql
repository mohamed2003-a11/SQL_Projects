-- Data Cleaning

-- 1- removing duplicate data
-- 2- Standardize the data
-- 3- Null values or blank values
-- 4- Remove any column

create table layoffs_staging
like layoffs;


select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;


select *,
row_number() over(partition by company,industry,total_laid_off,percentage_laid_off,`date`)as row_num 
from layoffs_staging;

with duplicate_CTE as(
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,country,
funds_raised_millions)as row_num 
from layoffs_staging
)
select *
from duplicate_CTE
where row_num > 1;

DELETE
from duplicate_CTE
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * 
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,country,
funds_raised_millions)as row_num 
from layoffs_staging;

SET SQL_SAFE_UPDATES = 0;

DELETE
from layoffs_staging2
where row_num > 1;

select * 
from layoffs_staging2
where row_num > 1;



-- Standardizing data means fixing data quality issues within your dataset so that every entry follows a consistent, uniform format.


select company,trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry 
from layoffs_staging2
order by 1;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry 
from layoffs_staging2;

select distinct location 
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;

select distinct country,trim(trailing '.' from country )
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

select *
from layoffs_staging2
order by 1;

-- NULL and BLANK VALUES 

select *
from layoffs_staging2
where company =  'Airbnb';

#here to make all blank values NULL which help sql to modifiy it 
update layoffs_staging2
set  industry = null
where industry = '';

#first we select to check
select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	ON t1.company = t2.company
    and t1.location =t2.location
where (t1.industry is null or t1.industry = '')
and t1.industry is NOT null;

#then we update the tabele 
update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry =t2.industry 
where t1.industry is null 
and t2.industry is not null;

select industry ,company
from layoffs_staging2;

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- Remove Columns
-- ALTER: The ALTER statement in SQL is used to change the structure of an existing table without destroying it.

alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2;